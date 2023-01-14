///  jh_photo_browser.dart
///
///  Created by iotjin on 2020/09/16.
///  description:  图片全屏浏览器

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '/jh_common/utils/jh_screen_utils.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class JhPhotoBrowser extends StatefulWidget {
  const JhPhotoBrowser({
    Key? key,
    required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
  }) : super(key: key);

  final List imgDataArr;
  final int index;
  final String? heroTag;
  final PageController? controller;
  final GestureTapCallback? onLongPress;
  final bool isHiddenClose;
  final bool isHiddenTitle;

  @override
  State<JhPhotoBrowser> createState() => _JhPhotoBrowserState();
}

class _JhPhotoBrowserState extends State<JhPhotoBrowser> {
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
              onLongPress: () => widget.onLongPress?.call(),
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
