///  jh_media_browser.dart
///
///  Created by iotjin on 2025/06/05.
///  description:  图片/视频浏览器，支持图片、视频预览，支持 Chewie 视频播放器

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/utils/jh_screen_utils.dart';

const Color _bgColor = Colors.black;
const bool _useChewie = true;
const String _unsupportedText = '不支持的媒体类型';

enum JhMediaType { Image, Video, Other }

class JhMediaItem {
  final String url;
  final JhMediaType type;

  JhMediaItem({required this.url, required this.type});
}

/// 长按回调，返回当前索引和所有资源数组
typedef _OnLongPress = void Function(int index, dynamic mediaArr);

class JhMediaBrowser {
  static void show(
    BuildContext context, {
    required List<JhMediaItem> data, // 对象数组
    int index = 0,
    bool useChewie = _useChewie, // 是否使用 Chewie 视频播放器, 默认使用
    _OnLongPress? onLongPress,
  }) {
    // assert(
    //   data.isNotEmpty,
    //   'media list must not be empty list',
    // );

    // assert(
    //   data.every((item) => item.url.trim().isNotEmpty),
    //   'all items in the media list must have non-empty URLs',
    // );

    if (data.isEmpty) {
      return;
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

  final List<JhMediaItem> dataArr;
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
    var item = widget.dataArr[index];
    var isImage = JhImageUtils.isImageFormat(item.url);
    var isVideo = JhImageUtils.isVideoFormat(item.url);

    Widget content;

    if (item.type == JhMediaType.Image || isImage) {
      content = PhotoView(
        imageProvider: NetworkImage(item.url),
        backgroundDecoration: const BoxDecoration(color: _bgColor),
        loadingBuilder: (context, event) => const Center(child: LoadingWidget()),
      );
    } else if (item.type == JhMediaType.Video || isVideo) {
      content = widget.useChewie ? ChewiePlayerView(item.url) : VideoPlayerView(item.url);
    } else {
      content = const Text(
        _unsupportedText,
        style: TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    return Center(child: content);
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView(
    this.url, {
    Key? key,
  }) : super(key: key);

  final String url;

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
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
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
    this.url, {
    Key? key,
  }) : super(key: key);

  final String url;

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
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));

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
      setState(() {});
    } catch (e) {
      debugPrint("Video init error: $e");
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
