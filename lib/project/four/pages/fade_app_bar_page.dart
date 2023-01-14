///  fade_app_bar_page.dart
///
///  Created by iotjin on 2020/09/07.
///  description: 渐变效果

// ignore_for_file: must_be_immutable, duplicate_ignore
// ignore_for_file: avoid_print
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import '/base_appbar.dart';

/// 渐变 APPBar
class FadeAppBarPage extends StatefulWidget {
  const FadeAppBarPage({Key? key}) : super(key: key);

  @override
  State<FadeAppBarPage> createState() => _FadeAppBarPageState();
}

class _FadeAppBarPageState extends State<FadeAppBarPage> {
  final ScrollController _scrollController = ScrollController();
  late PositionedBtnWidget _roundLeftBtn;
  late PositionedBtnWidget _rectLeftBtn;

  // appbar 透明度
  double _appBarOpacity = 0.0;

  // 圆形按钮透明度
  double _roundOpacity = 0.0;

  // 方形按钮透明度
  double _rectOpacity = 1.0;

  double maxOffset = 80.0;

  @override
  void initState() {
    super.initState();
    _roundLeftBtn = PositionedBtnWidget(
      btnTop: 34,
      left: 20,
      opacity: _roundOpacity,
      image: 'assets/images/common/ic_nav_back_black.png',
      actionFunction: () {
        print('round left');
      },
    );
    _rectLeftBtn = PositionedBtnWidget(
      btnTop: 34,
      left: 20,
      opacity: _rectOpacity,
      image: 'assets/images/common/ic_nav_back_white.png',
      actionFunction: () {
        print('rect left');
      },
    );
  }

  scrollViewDidScrolled(double offSet) {
    //print('scroll offset ' + offSet.toString());

    double halfPace = maxOffset / 2.0;

    setState(() {
      // appbar 透明度
      _appBarOpacity = offSet / maxOffset;
      if (_appBarOpacity < 0) {
        _appBarOpacity = 0.0;
      } else if (_appBarOpacity > 1) {
        _appBarOpacity = 1.0;
      }
      // 圆形按钮透明度
      _roundOpacity = (halfPace - offSet) / halfPace;
      if (_roundOpacity < 0) {
        _roundOpacity = 0.0;
      } else if (_roundOpacity > 1) {
        _roundOpacity = 1;
      }
      // 方形按钮透明度
      _rectOpacity = (offSet - halfPace) / halfPace;
      if (_rectOpacity < 0) {
        _rectOpacity = 0.0;
      } else if (_rectOpacity > 1) {
        _rectOpacity = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = MediaQuery.of(context).padding.bottom;
    bottomBarHeight += 49;

    return Scaffold(
      body: _body(),
      bottomNavigationBar: Container(
        color: Colors.orange,
        height: bottomBarHeight,
        child: const Center(child: Text('bottom bar')),
      ),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        // 监听滚动
        NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification && notification.depth == 0) {
              // 滑动通知
              scrollViewDidScrolled(notification.metrics.pixels);
            }
            // 通知不再上传
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
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
        AppBarWidget(opacity: _appBarOpacity),
        // _roundLeftBtn,
        // _rectLeftBtn,
      ],
    );
  }
}

// 按钮
class PositionedBtnWidget extends StatefulWidget {
  const PositionedBtnWidget({
    Key? key,
    this.btnTop,
    this.right,
    this.left,
    this.image,
    this.opacity = 1.0,
    this.actionFunction,
  }) : super(key: key);

  final double? btnTop;
  final double? right;
  final double? left;
  final String? image;
  final double opacity;

  // 点击事件
  final Function? actionFunction;

  @override
  State<PositionedBtnWidget> createState() => _PositionedBtnWidgetState();
}

class _PositionedBtnWidgetState extends State<PositionedBtnWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.btnTop,
      right: widget.right,
      left: widget.left,
      child: Opacity(
        opacity: widget.opacity,
        child: IconButton(
          icon: Image.asset(widget.image ?? ''),
          onPressed: () {
            if (widget.actionFunction != null) {
              widget.actionFunction!();
            }
          },
        ),
      ),
    );
  }
}

// APPBar
class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    this.opacity = 1.0,
  }) : super(key: key);

  final double opacity;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
    print('AppBarState init');
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).padding.top;
    appBarHeight += 44;

    return Opacity(
      opacity: widget.opacity,
      child: SizedBox(
        height: appBarHeight,
        child: const BaseAppBar('app bar', bgColor: Colors.deepOrange),
      ),
    );
  }
}
