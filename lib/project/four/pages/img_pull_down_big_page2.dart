///  img_pull_down_big_page2.dart
///
///  Created by iotjin on 2020/09/04.
///  description:

// ignore_for_file: must_be_immutable
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

class ImgPullDownBigPage2 extends StatefulWidget {
  const ImgPullDownBigPage2({Key? key}) : super(key: key);

  @override
  State<ImgPullDownBigPage2> createState() => _ImgPullDownBigPage2State();
}

class _ImgPullDownBigPage2State extends State<ImgPullDownBigPage2> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final double _imgNormalHeight = 200;
  double _imgExtraHeight = 0;
  double _imgChangeHeight = 0;
  double _scrollMinOffSet = 0;
  double _navH = 0;

  AppBarWidget? appBar;

  @override
  void initState() {
    super.initState();
    _navH = JhScreenUtils.navigationBarHeight;
    _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navH;
    _addListener();
    appBar = const AppBarWidget();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double y = _scrollController.offset;
//      print('滑动距离: $y');

      if (y < _scrollMinOffSet) {
        _imgExtraHeight = -y;
//        print(_topH);
        setState(() {
          _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
        });
      } else {
        setState(() {
          _imgChangeHeight = _navH;
        });
      }
//      // 小于0 ，下拉放大
//      if (y < 0) {
//      } else {}

      // appbar 透明度
      double appBarOpacity = y / _navH;
      if (appBarOpacity < 0) {
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        appBarOpacity = 1.0;
      }

      // 更新透明度
      if (appBar != null && appBar!.updateAppBarOpacity != null) {
        appBar!.updateAppBarOpacity!(appBarOpacity);
      }
    });
  }

  @override
  void dispose() {
    // 为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
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
        Container(
          color: Colors.yellow,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: 100 + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(width: double.infinity, height: _imgNormalHeight);
                }
                return ListTile(title: Text('$index'));
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          width: JhScreenUtils.screenWidth,
          height: _imgChangeHeight,
          child: Container(
            color: Colors.white,
            child: const JhNetworkImage('http://img1.mukewang.com/5c18cf540001ac8206000338.jpg'),
          ),
        ),
        Positioned(
          top: JhScreenUtils.topSafeHeight + 18,
          left: 18,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        appBar!,
      ],
    );
  }
}

// AppBarWidget

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    this.updateAppBarOpacity,
  }) : super(key: key);

  final Function? updateAppBarOpacity;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  Function? updateAppBarOpacity2;
  double opacity = 0;

  @override
  void initState() {
    print('AppBarState init');
    updateAppBarOpacity2 = widget.updateAppBarOpacity;
    updateAppBarOpacity2 = (double op) {
      setState(() {
        opacity = op;
      });
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = JhScreenUtils.navigationBarHeight;

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: appBarHeight,
        child: const BaseAppBar('图片下拉放大2', bgColor: Colors.deepOrange),
      ),
    );
  }
}
