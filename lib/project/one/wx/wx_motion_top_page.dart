/**
 *  wx_motion_top_page.dart
 *
 *  Created by iotjin on 2020/09/09.
 *  description: 微信运动排行榜
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_color_utils.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

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

  //滚动监听
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

      //更新透明度
      setState(() {
        _appbarOpacity = appBarOpacity;
        // print('_appbarO: ${_appbarOpacity}');
      });
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
    return Scaffold(body: _body(context, _dataArr));
  }

  Widget _body(context, dataArr) {
    return Stack(children: <Widget>[
      Container(
        color: Colors.white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    height: _imgNormalHeight,
                  );
                }
                return _cell(context, dataArr[index - 1]);
              }),
        ),
      ),
      Positioned(
        top: 0,
        width: JhScreenUtils.screenWidth,
        height: _imgChangeHeight,
        child: Container(
          color: Colors.white,
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
        child: backAppBar(context, '排行榜',
            backgroundColor: Colors.white.withOpacity(_appbarOpacity),
            brightness:
                _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightImgPath: 'assets/images/ic_more_black.png',
            rightItemCallBack: () {
          _clickCell(context, '更多');
        }),
      ),
    ]);
  }

  //cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () => _clickCell(context, item['name']),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        item['isOwn'] ? '' : (item['id'] + 1).toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 75,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: JhColorUtils.hexColor(item['color']),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(item['name'].substring(0, 1),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                      title: Text(
                        item['name'],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        item['steps'].toString(),
                        style: TextStyle(
                            fontSize: 28,
                            color: item['steps'] > 10000
                                ? Colors.orange
                                : KColor.kWeiXinTextColor),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['starNum'].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          child: Icon(
                            Icons.favorite,
                            color: item['isStar'] ? Colors.red : Colors.grey,
                          ),
                          onTap: () {
                            //点赞
                            setState(() {
                              item['isStar'] = !item['isStar'];
                              if (item['isStar']) {
                                item['starNum']++;
                              } else {
                                item['starNum']--;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                  color: KColor.kLineColor, height: item['isOwn'] ? 10 : 1),
            ],
          ),
        ));
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }
}
