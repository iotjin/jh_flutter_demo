///  jh_nine_picture2.dart
///
///  Created by iotjin on 2020/02/19.
///  description:  图片全屏浏览2 推荐使用 JhPhotoBrowser

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

/// 底部显示小圆点
class NinePictureAllScreenShow<T> extends PopupRoute<T> {
  NinePictureAllScreenShow(
    this.picList,
    this.index, {
    this.barrierLabel,
    this.startX,
    this.endX,
  });

  @override
  final String? barrierLabel;
  final List picList;
  final int? index;
  final int? startX;
  final int? endX;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 2000);

  @override
  Color get barrierColor => Colors.black; //背景颜色

  @override
  bool get barrierDismissible => true;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GestureDetector(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext? context, Widget? child) => GestureDetector(
            onTap: () {
              Navigator.pop(context!);
            },
            child: _PictureWidget(
              picList: picList,
              index: index,
            ),
            // child: _PictureWidget(index, index!),
          ),
        ),
      ),
    );
  }
}

class _PictureWidget extends StatefulWidget {
  const _PictureWidget({
    Key? key,
    this.picList = const [],
    this.index = 0,
  }) : super(key: key);

  final List picList;
  final int? index;

  @override
  State<_PictureWidget> createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<_PictureWidget> {
  int startX = 0;
  int endX = 0;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.picList[index],
                  fit: BoxFit.fill,
                ),
              ),
              onHorizontalDragDown: (detail) {
                startX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragUpdate: (detail) {
                endX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragEnd: (detail) {
                _getIndex(endX - startX);
                setState(() {});
              },
              onHorizontalDragCancel: () {},
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: widget.picList.length >= 6
                      ? 200
                      : widget.picList.length < 3
                          ? 50
                          : 100,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      widget.picList.length,
                      (i) => GestureDetector(
                        child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                          foregroundColor: _selColor,
                          radius: 5.0,
                          backgroundColor: index == i ? _selColor : _otherColor,
                        ),
                        onTap: () {
                          setState(() {
                            startX = endX = 0;
                            index = i;
                          });
                        },
                      ),
                    ).toList(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _getIndex(int delta) {
    if (delta > 50) {
      setState(() {
        index--;
        index = index.clamp(0, widget.picList.length - 1);
      });
    } else if (delta < 50) {
      setState(() {
        index++;
        index = index.clamp(0, widget.picList.length - 1);
      });
    }
  }
}
