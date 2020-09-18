/**
 *  wx_friends_circle_page.dart
 *
 *  Created by iotjin on 2020/09/14.
 *  description: 朋友圈
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_color_utils.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_nine_picture.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/model/contacts_model.dart';

class WxFriendsCirclePage extends StatefulWidget {
  @override
  _WxFriendsCirclePageState createState() => _WxFriendsCirclePageState();
}

class _WxFriendsCirclePageState extends State<WxFriendsCirclePage> {
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
    final jsonStr =
        await rootBundle.loadString('lib/res/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    // dataArr.forEach((item) {
    // });
    _dataArr = dataArr;
    setState(() {});
  }

  //滚动监听
  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
      // print("滑动距离: $_y");

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
      // //小于0 ，下拉放大
      // if (_y < 0) {
      // } else {}

      //appbar 透明度
      double appBarOpacity = _y / _navH;
      if (appBarOpacity < 0) {
        //透明
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        //不透明
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
    return Scaffold(
      body: _body(context, _dataArr),
    );
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
        left: 0,
        right: 0,
        height: _imgChangeHeight,
        child: _header(context),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: backAppBar(context, '朋友圈',
            backgroundColor: KColor.kWeiXinBgColor.withOpacity(_appbarOpacity),
            brightness:
                _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightImgPath: 'assets/wechat/discover/ic_xiangji.png',
            rightItemCallBack: () {
          _clickNav();
        }),
      ),
    ]);
  }

  //_header
  Widget _header(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          color: Colors.white,
          // child: Image.network(
          //   'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          //   fit: BoxFit.cover,
          // ),
          child: Image.asset(
            'assets/wechat/discover/friends/wx_bg0.jpeg',
            // 'assets/wechat/discover/friends/wx_bg1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            right: 20,
            bottom: 0,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '小于',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/images/lufei.png"),
                      ),
                    ),
                  ),
                  onTap: () => _jumpInfo(),
                ),
              ],
            )),
      ],
    );
  }

  //cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () => _clickCell(context, item['name']),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: KColor.kLineColor, width: 1),
              border: Border(
            bottom: BorderSide(width: 0.5, color: KColor.kLineColor), //下边框
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //头像
              InkWell(
                onTap: () => _jumpInfo(),
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: JhColorUtils.hexColor(item['color']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(item['name'].substring(0, 1),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                            color: KColor.kWeiXinTextBlueColor, fontSize: 15),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                        child: Text(
                          item['content'],
                          style: TextStyle(fontSize: 13),
                        )),
                    _imgs(context, item),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['time'],
                              style: TextStyle(
                                  color: KColor.kTextGrayColor, fontSize: 13),
                            ),
                            InkWell(
                              child: Container(
                                width: 34,
                                height: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Image.asset(
                                  'assets/wechat/discover/ic_diandian.png',
                                  color: KColor.kWeiXinTextBlueColor,
                                ),
                              ),
                              onTap: () => _clickCell(context, '评论'),
                            )
                          ],
                        )),
                  ])),
            ],
          ),
        ));
  }

  //图片view
  Widget _imgs(context, item) {
    return Container(
        child: JhNinePicture(
      imgData: item['imgs'],
      lRSpace: (80.0 + 20.0),
      onLongPress: () {
        print('objonLongPressect:');

        JhBottomSheet.showText(context, dataArr: ["保存图片"]);
      },
    ));
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }

  _clickNav() {
    JhBottomSheet.showText(context,
        title: "请选择操作",
        dataArr: ['拍摄', '从手机相册选择'],
        clickCallback: (index, text) {});
  }

  _jumpInfo() {
    //跳转个人信息页 跳转传递model

    ContactsModel model = ContactsModel();
    model.id = 123;
    model.name = '小于';
    model.namePinyin = '小于';
    model.phone = '17372826674';
    model.sex = '0';
    model.region = '淮北市';
    model.label = '';
    model.color = '#c579f2';
    model.avatarUrl = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    model.isStar = false;

    String jsonStr = Uri.encodeComponent(jsonEncode(model));
    NavigatorUtils.pushNamed(
        context, '${"WxUserInfoPage"}?passValue=${jsonStr}');
  }
}
