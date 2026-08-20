///  jh_media_browser3.dart
///
///  Created by iotjin on 2025/06/05.
///  description:  图片/视频浏览器，数据源支持 String(url / file path / assets) | Uint8List | File | ImageProvider

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/utils/jh_screen_utils.dart';

const Color _bgColor = Colors.black;
const bool _useChewie = true;
const String _unsupportedText = '不支持的媒体类型';

/// 长按回调，返回当前索引和所有资源数组
typedef _OnLongPress = void Function(int index, dynamic mediaArr);

class JhMediaBrowser3 {
  static void show(
    BuildContext context, {
    required List data, // String(url / file path / assets) | Uint8List | File | ImageProvider
    int index = 0,
    bool useChewie = _useChewie, // 是否使用 Chewie 视频播放器, 默认使用
    _OnLongPress? onLongPress,
  }) {
    // assert(
    //   data.every((item) => item.trim().isNotEmpty),
    //   'all items in the media list must be non-empty strings',
    // );

    if (data.isEmpty) {
      return;
    }
    if (index < 0 || index >= data.length) {
      index = 0;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MediaBrowserPage(dataArr: data, index: index, useChewie: useChewie, onLongPress: onLongPress),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => MediaBrowserPage(dataArr: data, index: index, useChewie: useChewie, onLongPress: onLongPress)),
    // );
  }
}

class MediaBrowserPage extends StatefulWidget {
  const MediaBrowserPage({
    Key? key,
    required this.dataArr,
    this.index = 0,
    this.useChewie = _useChewie,
    this.onLongPress,
  }) : super(key: key);

  final List dataArr; // String(url / file path / assets) | Uint8List | File | ImageProvider
  final int index;
  final bool useChewie;
  final _OnLongPress? onLongPress;

  @override
  State<MediaBrowserPage> createState() => _MediaBrowserPageState();
}

class _MediaBrowserPageState extends State<MediaBrowserPage> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta != null && details.primaryDelta! > 16) {
            Navigator.of(context).pop();
          }
        },
        onLongPress: () => widget.onLongPress?.call(_currentIndex, widget.dataArr),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.dataArr.length,
              onPageChanged: (i) {
                if (_currentIndex != i) {
                  setState(() => _currentIndex = i);
                }
              },
              itemBuilder: (context, index) {
                return _itemBuilder(index);
              },
            ),

            // 顶部关闭按钮
            Positioned(
              top: JhScreenUtils.topSafeHeight + 20,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // 顶部索引文字
            Positioned(
              top: JhScreenUtils.topSafeHeight + 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '${_currentIndex + 1} / ${widget.dataArr.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(index) {
    final item = widget.dataArr[index];
    Widget content;

    if (_isVideoSource(item)) {
      content = widget.useChewie ? ChewiePlayerView(item) : VideoPlayerView(item);
    } else {
      final ImageProvider? picture = _toImageProvider(item);
      if (picture != null) {
        content = PhotoView(
          imageProvider: picture,
          backgroundDecoration: const BoxDecoration(color: _bgColor),
          loadingBuilder: (context, event) => const Center(child: LoadingWidget()),
        );
      } else {
        content = const Text(
          _unsupportedText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        );
      }
    }

    return Center(child: content);
  }
}

bool _isVideoSource(dynamic source) {
  if (source is File) {
    return JhImageUtils.isVideoFormat(source.path);
  }
  if (source is String) {
    return JhImageUtils.isVideoFormat(source.trim());
  }
  return false;
}

bool _isLocalFilePath(String path) {
  if (path.startsWith('/') || path.startsWith('file://')) {
    return true;
  }
  if (!kIsWeb && Platform.isWindows && RegExp(r'^[a-zA-Z]:\\').hasMatch(path)) {
    return true;
  }
  return false;
}

/// String(url / file path / assets) | Uint8List | File | ImageProvider
ImageProvider? _toImageProvider(dynamic source) {
  if (source is ImageProvider) {
    return source;
  }
  if (source is Uint8List) {
    return MemoryImage(source);
  }
  if (source is File) {
    if (JhImageUtils.isVideoFormat(source.path)) {
      return null;
    }
    return FileImage(source);
  }
  if (source is String) {
    final path = source.trim();
    if (path.isEmpty) {
      return null;
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    }
    if (path.startsWith('assets/') || path.startsWith('asset/') || path.startsWith('packages/')) {
      return AssetImage(path);
    }
    // 本地绝对路径图片
    if (!kIsWeb && _isLocalFilePath(path) && JhImageUtils.isImageFormat(path)) {
      return FileImage(File(path));
    }
    // 兼容 JhPhotoBrowser：其余非 http 路径默认按 assets 处理
    if (!JhImageUtils.isVideoFormat(path)) {
      return AssetImage(path);
    }
  }
  return null;
}

String _videoSourcePath(dynamic source) {
  if (source is File) {
    return source.path;
  }
  if (source is String) {
    return source.trim();
  }
  return source.toString();
}

VideoPlayerController _videoControllerFrom(dynamic source) {
  if (source is File) {
    return VideoPlayerController.file(source);
  }
  final path = _videoSourcePath(source);
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return VideoPlayerController.networkUrl(Uri.parse(path));
  }
  if (path.startsWith('assets/') || path.startsWith('asset/') || path.startsWith('packages/')) {
    return VideoPlayerController.asset(path);
  }
  return VideoPlayerController.file(File(path));
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView(
    this.source, {
    Key? key,
  }) : super(key: key);

  final dynamic source; // String(url / file path / assets) | File

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

// class _VideoPlayerViewState extends State<VideoPlayerView> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url)
//       ..initialize().then((_) {
//         if (!mounted) return;
//         setState(() => _isInitialized = true);
//         _controller.setLooping(true);
//         _controller.play();
//       }).catchError((e) {
//         debugPrint("Video init failed: $e");
//         if (mounted) {
//           setState(() => _isInitialized = false);
//         }
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     debugPrint('VideoPlayerView: dispose');
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return const Center(child: LoadingWidget());
//     }
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _controller.value.isPlaying ? _controller.pause() : _controller.play();
//         });
//       },
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             VideoPlayer(_controller),
//             if (!_controller.value.isPlaying) const Icon(Icons.play_circle_outline, size: 64, color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isSeeking = false;

  @override
  void initState() {
    super.initState();
    _controller = _videoControllerFrom(widget.source)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() => _isInitialized = true);
        _controller.setLooping(true);
        _controller.play();
      }).catchError((e) {
        debugPrint("Video init failed: $e");
        if (mounted) {
          setState(() => _isInitialized = false);
        }
      });

    _controller.addListener(() {
      if (!_isSeeking && mounted) {
        setState(() {}); // 更新进度条
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    debugPrint('VideoPlayerView: dispose');
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: LoadingWidget());
    }

    final bool isPortrait = _controller.value.aspectRatio < 1.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: isPortrait ? (JhScreenUtils.topSafeHeight + 40 + 44) : 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: GestureDetector(
                    onTap: _togglePlay,
                    child: VideoPlayer(_controller),
                  ),
                ),
                if (!_controller.value.isPlaying)
                  GestureDetector(
                    onTap: _togglePlay,
                    child: const Icon(Icons.play_circle_outline, size: 64, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Text(
                _formatDuration(_controller.value.position),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Expanded(
                child: Slider(
                  value: _controller.value.position.inMilliseconds.toDouble().clamp(
                        0,
                        _controller.value.duration.inMilliseconds.toDouble(),
                      ),
                  max: _controller.value.duration.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    setState(() => _isSeeking = true);
                    _controller.seekTo(Duration(milliseconds: value.toInt())).then((_) {
                      setState(() => _isSeeking = false);
                    });
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                ),
              ),
              Text(
                _formatDuration(_controller.value.duration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChewiePlayerView extends StatefulWidget {
  const ChewiePlayerView(
    this.source, {
    Key? key,
  }) : super(key: key);

  final dynamic source; // String(url / file path / assets) | File

  @override
  State<ChewiePlayerView> createState() => _ChewiePlayerViewState();
}

class _ChewiePlayerViewState extends State<ChewiePlayerView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = _videoControllerFrom(widget.source);

    try {
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        // 所有控件是否显示
        showControls: true,
        // 顶部控制栏是否显示
        showOptions: false,
        // 静音按钮是否显示
        allowMuting: false,
        // 是否允许全屏
        allowFullScreen: false,
        allowedScreenSleep: false,
      );
      if (!mounted) {
        return;
      }
      setState(() {});
    } catch (e) {
      debugPrint("Video init error: $e");
      if (!mounted) {
        return;
      }
      setState(() => _isError = true);
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();

    debugPrint('ChewiePlayerView: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return const Center(child: Text('Video is error', style: TextStyle(color: Colors.white)));
    }

    if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }

    return const Center(child: LoadingWidget());
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
    );
  }
}
