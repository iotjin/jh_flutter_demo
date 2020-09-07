/**
 *  fade_app_bar_page.dart
 *
 *  Created by iotjin on 2020/09/07.
 *  description: 渐变效果
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///渐变 APP var
class FadeAppBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FadeAppBarState();
}

class FadeAppBarState extends State<FadeAppBarPage> {
  AppBarWidget appBar;
  ScrollController scrollController;
  PositionedBtnWidget roundLeftBtn;
  PositionedBtnWidget rectLeftBtn;

  @override
  void initState() {
    super.initState();
    appBar = AppBarWidget();
    scrollController = ScrollController();
    roundLeftBtn = PositionedBtnWidget(
      btnTop: 34,
      left: 20,
      opacity: 1,
      image: 'assets/images/common/ic_nav_back_black.png',
      actionFunction: () {
        print('round left');
      },
    );
    rectLeftBtn = PositionedBtnWidget(
      btnTop: 34,
      left: 20,
      opacity: 0,
      image: "assets/images/common/ic_nav_back_white.png",
      actionFunction: () {
        print('rect left');
      },
    );
  }

  double maxOffset = 80.0;

  scrollViewDidScrolled(double offSet) {
    //print('scroll offset ' + offSet.toString());

    ///appbar 透明度
    double appBarOpacity = offSet / maxOffset;
    double halfPace = maxOffset / 2.0;

    ///圆形按钮透明度
    double roundOpacity = (halfPace - offSet) / halfPace;

    ///方形按钮透明度
    double rectOpacity = (offSet - halfPace) / halfPace;

    if (appBarOpacity < 0) {
      appBarOpacity = 0.0;
    } else if (appBarOpacity > 1) {
      appBarOpacity = 1.0;
    }

    if (roundOpacity < 0) {
      roundOpacity = 0.0;
    } else if (roundOpacity > 1) {
      roundOpacity = 1;
    }

    if (rectOpacity < 0) {
      rectOpacity = 0.0;
    } else if (rectOpacity > 1) {
      rectOpacity = 1.0;
    }
    //print('roundOpacity $roundOpacity rectOpacity $rectOpacity');

    ///更新透明度
    if (appBar != null && appBar.updateAppBarOpacity != null) {
      appBar.updateAppBarOpacity(appBarOpacity);
    }

    if (roundLeftBtn != null && roundLeftBtn.updateOpacity != null) {
      roundLeftBtn.updateOpacity(roundOpacity);
    }
    if (rectLeftBtn != null && rectLeftBtn.updateOpacity != null) {
      rectLeftBtn.updateOpacity(rectOpacity);
    }
  }

  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = MediaQuery.of(context).padding.bottom;
    bottomBarHeight += 49;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            ///监听滚动
            NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  ///滑动通知
                  scrollViewDidScrolled(notification.metrics.pixels);
                }

                ///通知不再上传
                return true;
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverFixedExtentList(
                    itemExtent: 80,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // 创建列表项
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: Text('list item $index'),
                        );
                      },
                      // 50个列表项
                      childCount: 50,
                    ),
                  )
                ],
              ),
            ),
            appBar,
//            rectLeftBtn,
//            roundLeftBtn,
          ],
        ),
        bottomNavigationBar: Container(
            color: Colors.orange,
            height: bottomBarHeight,
            child: Center(
              child: Text('bottom bar'),
            )));
  }
}

///按钮
// ignore: must_be_immutable
class PositionedBtnWidget extends StatefulWidget {
  double btnTop;
  double right;
  double left;
  String image;
  double opacity;

  ///更新透明度
  Function updateOpacity;

  ///要触发的事件
  Function actionFunction;

  PositionedBtnWidget(
      {this.btnTop,
      this.right,
      this.left,
      this.opacity,
      this.image,
      this.actionFunction});

  @override
  State<StatefulWidget> createState() {
    return PositionedBtnState();
  }
}

class PositionedBtnState extends State<PositionedBtnWidget> {
  double btnTop;
  double right;
  double left;
  String image;
  double btnOpacity;

  @override
  void initState() {
    super.initState();

    if (widget != null) {
      btnTop = widget.btnTop != null ? widget.btnTop : null;
      right = widget.right != null ? widget.right : null;
      left = widget.left != null ? widget.left : null;
      image = widget.image != null ? widget.image : null;
      btnOpacity = widget.opacity != null ? widget.opacity : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ///更新透明度
    if (widget != null && widget.updateOpacity == null) {
      widget.updateOpacity = (double opacity) {
        setState(() {
          btnOpacity = opacity;
        });
      };
    }

    return Positioned(
      top: btnTop,
      right: right,
      left: left,
      child: Opacity(
        opacity: btnOpacity,
        child: IconButton(
          icon: Image.asset(image),
          onPressed: () {
            if (widget != null && widget.actionFunction != null) {
              widget.actionFunction();
            }
          },
        ),
      ),
    );
  }
}

///app barb
class AppBarWidget extends StatefulWidget {
  Function updateAppBarOpacity;

  @override
  State<StatefulWidget> createState() => AppBarState();
}

class AppBarState extends State<AppBarWidget> {
  double opacity = 0;

  @override
  void initState() {
    if (widget != null) {
      print('AppBarState init');
      widget.updateAppBarOpacity = (double op) {
        setState(() {
          opacity = op;
        });
      };
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).padding.top;
    appBarHeight += 44;

    return Opacity(
      opacity: opacity,
      child: Container(
        height: appBarHeight,
        child: AppBar(
          title: Text('app bar'),
          backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
