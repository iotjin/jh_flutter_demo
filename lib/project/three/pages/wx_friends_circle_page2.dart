///  wx_friends_circle_page2.dart
///
///  Created by iotjin on 2020/09/14.
///  description: 朋友圈

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/project/configs/project_config.dart';
import '/project/two/models/wx_contacts_model.dart';
import '../models/wx_friends_circle_model.dart';
import '../widgets/wx_friends_circle_cell.dart';

class WxFriendsCirclePage2 extends StatefulWidget {
  const WxFriendsCirclePage2({Key? key}) : super(key: key);

  @override
  State<WxFriendsCirclePage2> createState() => _WxFriendsCirclePage2State();
}

class _WxFriendsCirclePage2State extends State<WxFriendsCirclePage2> {
  final ScrollController _scrollController = ScrollController();

  final double _imgNormalHeight = 300;
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
    // 获取微信朋友圈数据
    final jsonStr = await rootBundle.loadString('lib/res/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    // dataArr.forEach((item) {
    // });
    _dataArr = dataArr;
    setState(() {});
  }

  // 滚动监听
  void _addListener() {
    _scrollController.addListener(() {
      double y = _scrollController.offset;
      // print('滑动距离: $y');

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
      // // 小于0 ，下拉放大
      // if (y < 0) {
      // } else {}

      // appbar 透明度
      double appBarOpacity = y / _navH;
      if (appBarOpacity < 0) {
        // 透明
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        // 不透明
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
      body: _body(_dataArr),
    );
  }

  Widget _body(dataArr) {
    var navBgColor = KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor);
    navBgColor = navBgColor.withOpacity(_appbarOpacity);

    return Stack(
      children: <Widget>[
        Container(
          color: KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(width: double.infinity, height: _imgNormalHeight);
                }
                WxFriendsCircleModel model = WxFriendsCircleModel.fromJson(dataArr[index - 1]);
                return WxFriendsCircleCell(
                  model: model,
                  onClickCell: (model) => _clickCell(model['name']),
                  onClickHeadPortrait: (model) => _jumpInfo(),
                  onClickComment: (model) => _clickCell('评论'),
                );
              },
            ),
          ),
        ),
        Positioned(top: 0, left: 0, right: 0, height: _imgChangeHeight, child: _header()),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BaseAppBar(
            '朋友圈',
            bgColor: navBgColor,
            brightness: _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightImgPath: 'assets/wechat/discover/ic_camera.png',
            rightItemCallBack: () {
              _clickNav();
            },
          ),
        ),
      ],
    );
  }

  // _header
  Widget _header() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
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
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  '小于',
                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/lufei.png'),
                    ),
                  ),
                ),
                onTap: () => _jumpInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 点击cell
  _clickCell(text) {
    JhToast.showText(context, msg: '点击 $text');
  }

  _clickNav() {
    JhBottomSheet.showText(context, title: '请选择操作', dataArr: ['拍摄', '从手机相册选择'], clickCallback: (index, text) {});
  }

  // 跳转个人信息页
  _jumpInfo() {
    WxContactsModel model = WxContactsModel();
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

    JhNavUtils.pushNamed(context, 'WxUserInfoPage', arguments: model.toJson());
  }
}
