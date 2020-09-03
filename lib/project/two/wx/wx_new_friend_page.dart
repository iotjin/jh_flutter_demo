/**
 *  wx_new_friend_page.dart
 *
 *  Created by iotjin on 2020/09/01.
 *  description: 新的朋友
 */

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

List _dataArr = [
  {
    "title": "张三",
    "subtitle": "欢迎欢迎",
    "img": "assets/images/picture/touxiang_1.jpeg",
    "isAdd": true,
  },
  {
    "title": "李四",
    "subtitle": "hello",
    "img": "assets/images/picture/touxiang_2.jpeg",
    "isAdd": false,
  },
  {
    "title": "王五",
    "subtitle": "[图片]",
    "img": "assets/images/picture/touxiang_3.jpeg",
    "isAdd": false,
  },
  {
    "title": "赵六",
    "subtitle": "[动画表情]",
    "img": "assets/images/picture/touxiang_4.jpeg",
    "isAdd": true,
  },
  {
    "title": "哈哈哈",
    "subtitle": "",
    "img": "assets/images/picture/touxiang_5.jpeg",
    "isAdd": false,
  },
  {
    "title": "@",
    "subtitle": "hi",
    "img": "assets/images/picture/touxiang_6.jpg",
    "isAdd": false,
  },
];

class WxNewFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '新的朋友',
          backgroundColor: Colors.transparent,
          rightText: '添加朋友', rightItemCallBack: () {
        NavigatorUtils.pushNamed(context, 'WxAddFriendPage');
      }),
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

    Widget _myCode = InkWell(
      child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
//        height: 60,
          child: Column(children: <Widget>[
            Icon(Icons.phone_iphone, color: KColor.kWeiXinThemeColor),
            SizedBox(height: 10),
            Text(
              '添加手机联系人',
              style: TextStyle(color: Colors.grey),
            ),
          ])),
      onTap: () => _clickCell(context, '添加手机联系人'),
    );

    Widget _text = Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      alignment: Alignment.centerLeft,
      height: 35,
      child: Text('三天前', style: TextStyle(color: Colors.grey)),
    );

    List<Widget> _topWidgetList =
        _dataArr.map((item2) => _cell(context, item2)).toList();

    _topWidgetList.insert(0, _text);
    _topWidgetList.insert(0, _myCode);
    _topWidgetList.insert(0, _searchBar);

    return ListView(
      children: _topWidgetList,
    );
  }

  //cell
  Widget _cell(context, item) {
    Widget _btn = InkWell(
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 35,
        decoration: BoxDecoration(
          color: KColor.kWeiXinThemeColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          '接受',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onTap: () => _clickCell(context, '接受'),
    );
    Widget _text = InkWell(
        child: Container(
      alignment: Alignment.center,
      width: 70,
      height: 35,
      child: Text(
        '已添加',
        style: TextStyle(color: Colors.grey),
      ),
    ));

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
              trailing: item['isAdd'] ? _text : _btn,
            )),
        SizedBox(width: 70, height: 1, child: Container(color: Colors.white))
      ],
    );
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }
}
