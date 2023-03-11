///  jh_photo_browser.dart
///
///  Created by iotjin on 2020/09/16.
///  description:  图片全屏浏览器

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '/jh_common/utils/jh_screen_utils.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

/// 长按回调，返回当前索引和所有图片数组
typedef _OnLongPress = void Function(int index, dynamic imgArr);

class JhPhotoBrowser {
  static void show(
    BuildContext context, {
    Key? key,
    required List data, // 图片数组(本地或网络图片路径)
    int index = 0, // 默认索引
    String? heroTag, // hero动画tag, 不设置或null为不启用hero动画
    _OnLongPress? onLongPress,
    PageController? controller,
    bool isHiddenClose = false, // 为true时隐藏右上角关闭按钮
    bool isHiddenTitle = false, // 当图片数量等于1或者为true时会隐藏顶部文字（1/9）
  }) {
    var view = JhPhotoBrowserView(
      imgDataArr: data,
      index: index,
      onLongPress: onLongPress,
      controller: controller,
      heroTag: heroTag,
      isHiddenClose: isHiddenClose,
      isHiddenTitle: isHiddenTitle,
    );
    // FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
    Navigator.of(context).push(FadeRoute(page: view));
  }
}

class JhPhotoBrowserView extends StatefulWidget {
  const JhPhotoBrowserView({
    Key? key,
    required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
  }) : super(key: key);

  final List imgDataArr; // 图片数组(本地或网络图片路径)
  final int index; // 默认索引
  final String? heroTag; // hero动画tag, 不设置或null为不启用hero动画
  final PageController? controller;
  final _OnLongPress? onLongPress;
  final bool isHiddenClose; // 为true时隐藏右上角关闭按钮
  final bool isHiddenTitle; // 当图片数量等于1或者为true时会隐藏顶部文字（1/9）

  @override
  State<JhPhotoBrowserView> createState() => _JhPhotoBrowserViewState();
}

class _JhPhotoBrowserViewState extends State<JhPhotoBrowserView> {
  int _currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
    _controller = widget.controller ?? PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              onLongPress: () => widget.onLongPress?.call(_currentIndex, widget.imgDataArr),
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  var imgURL = widget.imgDataArr[index];
                  ImageProvider picture;
                  if (imgURL.startsWith('http')) {
                    picture = NetworkImage(imgURL);
                  } else {
                    picture = AssetImage(imgURL);
                  }
                  return PhotoViewGalleryPageOptions(
                    imageProvider: picture,
                    heroAttributes: widget.heroTag != null ? PhotoViewHeroAttributes(tag: widget.heroTag!) : null,
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                itemCount: widget.imgDataArr.length,
                // loadingChild: Container(),
                backgroundDecoration: null,
                pageController: _controller,
                enableRotation: false,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: JhScreenUtils.topSafeHeight + 20,
          left: 0,
          right: 0,
          height: 30,
          child: Offstage(
            offstage: widget.imgDataArr.length == 1 || widget.isHiddenTitle,
            child: Center(
              child: Text('${_currentIndex + 1}/${widget.imgDataArr.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ),
        Positioned(
          top: JhScreenUtils.topSafeHeight + 20,
          right: 10,
          height: 30,
          child: Offstage(
            offstage: widget.isHiddenClose,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.close, size: 30, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3.5),
                      child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                        radius: 3.5,
                        backgroundColor: _currentIndex == i ? _selColor : _otherColor,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
