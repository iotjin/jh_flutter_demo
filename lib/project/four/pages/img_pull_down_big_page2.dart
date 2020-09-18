/**
 *  img_pull_down_big_page2.dart
 *
 *  Created by iotjin on 2020/09/04.
 *  description:
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_screen_utils.dart';

class ImgPullDownBigPage2 extends StatefulWidget {
  @override
  _ImgPullDownBigPage2State createState() => _ImgPullDownBigPage2State();
}

class _ImgPullDownBigPage2State extends State<ImgPullDownBigPage2>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  double _imgNormalHeight = 200;
  double _imgExtraHeight = 0;
  double _imgChangeHeight = 0;
  double _scrollMinOffSet = 0;
  double _navH = 0;

  AppBarWidget appBar;

  @override
  void initState() {
    super.initState();
    _navH = JhScreenUtils.navigationBarHeight;
    _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navH;
    _addListener();
    appBar = AppBarWidget();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print("滑动距离: $_y");

      if (_y < _scrollMinOffSet) {
        _imgExtraHeight = -_y;
//        print(_topH);
        setState(() {
          _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
        });
      } else {
        setState(() {
          _imgChangeHeight = _navH;
        });
      }
//      //小于0 ，下拉放大
//      if (_y < 0) {
//      } else {}

      //appbar 透明度
      double appBarOpacity = _y / _navH;
      if (appBarOpacity < 0) {
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        appBarOpacity = 1.0;
      }

      ///更新透明度
      if (appBar != null && appBar.updateAppBarOpacity != null) {
        appBar.updateAppBarOpacity(appBarOpacity);
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return Stack(children: <Widget>[
      Container(
        color: Colors.yellow,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: 100 + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    height: _imgNormalHeight,
                  );
                }
                return ListTile(title: Text("$index"));
              }),
        ),
      ),
      Positioned(
        top: 0,
        width: JhScreenUtils.screenWidth,
        height: _imgChangeHeight,
        child: Container(
            color: Colors.white,
            child: Image.network(
              'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: JhScreen.topSafeHeight + 18,
        left: 18,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      appBar,
    ]);
  }
}

// AppBarWidget
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
    double appBarHeight = JhScreenUtils.navigationBarHeight;

    return Opacity(
      opacity: opacity,
      child: Container(
        height: appBarHeight,
        child: AppBar(
          title: Text(
            '图片下拉放大2',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
