///  jh_nine_picture2.dart
///
///  Created by iotjin on 2020/02/19.
///  description:  图片全屏浏览 推荐使用 JhPhotoBrowser

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class JhPhotoAllScreenShow extends StatefulWidget {
  const JhPhotoAllScreenShow({
    Key? key,
    this.imgDataArr = const [],
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
  }) : super(key: key);

  final List imgDataArr;
  final int index;
  final String? heroTag;
  final PageController? controller;
  final GestureTapCallback? onLongPress;

  @override
  State<JhPhotoAllScreenShow> createState() => _JhPhotoAllScreenShowState();
}

class _JhPhotoAllScreenShowState extends State<JhPhotoAllScreenShow> {
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

  _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            onLongPress: widget.onLongPress,
            child: Container(
              color: Colors.black,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.imgDataArr[index]),
                    heroAttributes: widget.heroTag != null ? PhotoViewHeroAttributes(tag: widget.heroTag!) : null,
                  );
                },
                itemCount: widget.imgDataArr.length,
                // loadingChild: Container(),
                backgroundDecoration: null,
                pageController: _controller,
                enableRotation: true,
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
          top: MediaQuery.of(context).padding.top + 30,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              '${_currentIndex + 1}/${widget.imgDataArr.length}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: MediaQuery.of(context).padding.top + 15,
          child: IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
//                color: Colors.red,
              width: widget.imgDataArr.length >= 6
                  ? 200
                  : widget.imgDataArr.length < 3
                      ? 50
                      : 100,
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                      radius: 5.0,
                      backgroundColor: _currentIndex == i ? _selColor : _otherColor,
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
