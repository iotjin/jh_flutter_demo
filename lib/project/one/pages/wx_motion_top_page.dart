///  wx_motion_top_page.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动排行榜

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhtoast/jhtoast.dart';
import '/project/configs/project_config.dart';
import '../models/wx_motion_top_model.dart';
import '../widgets/wx_motion_top_cell.dart';

class WxMotionTopPage extends StatefulWidget {
  @override
  _WxMotionTopPageState createState() => _WxMotionTopPageState();
}

class _WxMotionTopPageState extends State<WxMotionTopPage> {
  ScrollController _scrollController = ScrollController();

  double _imgNormalHeight = 300;
  double _imgExtraHeight = 0;
  double _imgChangeHeight = 0;
  double _scrollMinOffSet = 0;
  double _navH = 0;
  double _appbarOpacity = 0.0;

  var _dataArr = [];

  @override
  void initState() {
    super.initState();
    _navH = JhScreenUtils.navigationBarHeight;
    _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navH;
    _addListener();

    _loadData();
  }

  void _loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr = await rootBundle.loadString('lib/res/wx_motion_top.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    dataArr.forEach((item) {
      //print('steps: ${item['steps']}');
      if (item['isOwn'] == true) {
        dataArr.remove(item);
        dataArr.insert(0, item);
      }
    });
    _dataArr = dataArr;
    setState(() {});
  }

  // 滚动监听
  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print('滑动距离: $_y');

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
//      // 小于0 ，下拉放大
//      if (_y < 0) {
//      } else {}

      // appbar 透明度
      double appBarOpacity = _y / _navH;
      if (appBarOpacity < 0) {
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        appBarOpacity = 1.0;
      }

      // 更新透明度
      setState(() {
        _appbarOpacity = appBarOpacity;
        // print('_appbarO: ${_appbarOpacity}');
      });
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
      body: _body(context, _dataArr),
    );
  }

  Widget _body(context, dataArr) {
    var _navBgColor = KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor);
    _navBgColor = _navBgColor.withOpacity(_appbarOpacity);

    return Stack(
      children: <Widget>[
        Container(
          color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    height: _imgNormalHeight,
                  );
                }
                WxMotionTopModel model = WxMotionTopModel.fromJson(dataArr[index - 1]);
                return WxMotionTopCell(
                  model: model,
                  onClickCell: (model) {
                    _clickCell(context, model['name']);
                  },
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          width: JhScreenUtils.screenWidth,
          height: _imgChangeHeight,
          child: Container(
            // child: Image.network(
            //   'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
            //   fit: BoxFit.cover,
            // ),
            child: Image.asset(
              'assets/wechat/home/ic_top.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BaseAppBar(
            '排行榜',
            bgColor: _navBgColor,
            brightness: _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightImgPath: 'assets/images/ic_more_black.png',
            rightItemCallBack: () {
              _clickCell(context, '更多');
            },
          ),
        ),
      ],
    );
  }

  // 点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 $text');
  }
}
