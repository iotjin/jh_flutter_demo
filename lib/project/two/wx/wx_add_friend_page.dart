/**
 *  wx_add_friend_page.dart
 *
 *  Created by iotjin on 2020/09/01.
 *  description: 添加朋友
 */

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

List _dataArr = [
  {
    "title": "雷达加朋友",
    "subtitle": "添加身边的朋友",
    "img": "assets/wechat/contacts/add/add_friend_icon_reda_36x36_@3x.png",
  },
  {
    "title": "面对面建群",
    "subtitle": "与身边的朋友进入同一个群聊",
    "img": "assets/wechat/contacts/add/add_friend_icon_addgroup_36x36_@3x.png",
  },
  {
    "title": "扫一扫",
    "subtitle": "扫描二维码名片",
    "img": "assets/wechat/contacts/add/add_friend_icon_scanqr_36x36_@3x.png",
  },
  {
    "title": "手机联系人",
    "subtitle": "添加手机通讯录中的朋友",
    "img": "assets/wechat/contacts/add/add_friend_icon_contacts_36x36_@3x.png",
  },
  {
    "title": "公众号",
    "subtitle": "获取更多资讯和服务",
    "img": "assets/wechat/contacts/add/add_friend_icon_offical_36x36_@3x.png",
  },
  {
    "title": "企业微信联系人",
    "subtitle": "通过手机号搜索企业微信用户",
    "img":
        "assets/wechat/contacts/add/add_friend_icon_search_wework_40x40_@2x.png",
  },
];

class WxAddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '添加朋友', backgroundColor: Colors.transparent),
      body: _body(context),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }

  Widget _body(context) {
    Widget _searchBar = Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      height: 38,
      child: JhLoginTextField(
        leftWidget: Icon(Icons.search, size: 25),
        hintText: '微信号/手机号',
        isShowDeleteBtn: true,
        isDense: true,
        border: InputBorder.none,
      ),
    );

    Widget _myCode = Container(
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('我的微信号：abc'),
              SizedBox(width: 10),
              Image.asset(
                  'assets/wechat/contacts/add/add_friend_myQR_20x20_@2x.png',
                  width: 20)
            ]));

    List<Widget> _topWidgetList =
        _dataArr.map((item2) => _cell(context, item2)).toList();

    _topWidgetList.insert(0, _myCode);
    _topWidgetList.insert(0, _searchBar);

    return ListView(
      children: _topWidgetList,
    );
  }

  //cell
  Widget _cell(context, item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            color: Colors.white,
            child: ListTile(
                onTap: () => _clickCell(context, item['title']),
                leading: Container(
                    child: CircleAvatar(
                        backgroundImage: AssetImage(
                  item['img'],
                ))),
                title: Text(
                  item['title'],
                  style: TextStyle(color: KColor.kWeiXinTextBlueColor),
                ),
                subtitle: Text(
                  item['subtitle'],
                ),
                trailing: Icon(Icons.arrow_forward_ios))),
        SizedBox(width: 70, height: 1, child: Container(color: Colors.white))
      ],
    );
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }
}
