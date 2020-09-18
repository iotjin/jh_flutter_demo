/**
 *  jh_photo_browser.dart
 *
 *  Created by iotjin on 2020/09/16.
 *  description: 图片全屏浏览器
 */

import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_screen_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
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

class JhPhotoBrowser extends StatefulWidget {
  List imgDataArr = [];
  int index;
  String heroTag;
  PageController controller;
  GestureTapCallback onLongPress;
  bool isHiddenClose;
  bool isHiddenTitle;

  JhPhotoBrowser({
    Key key,
    @required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
  }) : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _JhPhotoBrowserState createState() => _JhPhotoBrowserState();
}

class _JhPhotoBrowserState extends State<JhPhotoBrowser> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.index;
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
                onTap: () {
                  Navigator.of(context).pop();
                },
                onLongPress: () {
                  widget.onLongPress();
                },
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    var _imgURL = widget.imgDataArr[index];
                    ImageProvider _picture = _imgURL.startsWith('http')
                        ? NetworkImage(_imgURL)
                        : AssetImage(_imgURL);

                    return PhotoViewGalleryPageOptions(
                      imageProvider: _picture,
                      heroAttributes: widget.heroTag != null
                          ? PhotoViewHeroAttributes(tag: widget.heroTag)
                          : null,
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  itemCount: widget.imgDataArr.length,
                  // loadingChild: Container(),
                  backgroundDecoration: null,
                  pageController: widget.controller,
                  enableRotation: false,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              )),
        ),
        Positioned(
          top: JhScreenUtils.topSafeHeight + 20,
          left: 0,
          right: 0,
          height: 30,
          child: Offstage(
            offstage: widget.imgDataArr.length == 1 || widget.isHiddenTitle,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.imgDataArr.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
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
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.5),
                        child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                          radius: 3.5,
                          backgroundColor:
                              currentIndex == i ? _selColor : _otherColor,
                        )),
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
