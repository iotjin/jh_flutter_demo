/**
 *  wx_userInfo_page.dart
 *
 *  Created by iotjin on 2020/09/01.
 *  description: 用户信息
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_color_utils.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/model/contacts_model.dart';

class WxUserInfoPage extends StatelessWidget {
  final ContactsModel _passValue;

  WxUserInfoPage(this._passValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '',
          rightImgPath: 'assets/images/ic_more_black.png',
          backgroundColor: Colors.transparent, rightItemCallBack: () {
        //跳转资料设置
        String jsonStr = Uri.encodeComponent(jsonEncode(_passValue));
        NavigatorUtils.pushNamed(
            context, '${"WxInfoSetPage"}?passValue=${jsonStr}');
      }),
      body: _body(context),
    );
  }

  Widget _body(context) {
    print('上个页面传递过来的model: ${_passValue.toJson()}');

    double _cellH = wx_cellH;
    double _rowSpace = wx_rowSpace;

    Widget _sex = _passValue.sex == '0'
        ? Icon(Icons.person, color: Colors.blue)
        : Icon(Icons.pregnant_woman, color: Colors.redAccent);
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 66, maxWidth: 66),
                height: 66,
                width: 66,
                margin: EdgeInsets.fromLTRB(20, 3, 15, 0),
                decoration: BoxDecoration(
                  color: JhColorUtils.hexColor(_passValue.color),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(_passValue.name.substring(0, 1),
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              Expanded(
                  flex: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(_passValue.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
//                      Icon(Icons.pregnant_woman, color: Colors.redAccent),
////                      Icon(Icons.person, color: Colors.blue),
                          _sex
                        ],
                      ),
                      SizedBox(height: 3),
                      Text('昵称：${_passValue.namePinyin}',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 3),
                      Text('手机号：${_passValue.phone}',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 3),
                      Text('地区：${_passValue.region}',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  )),
              Expanded(
                flex: 15,
                child: _passValue.isStar
                    ? Icon(Icons.star, color: Colors.yellow)
                    : Container(),
              ),
            ],
          ),
        ),
        Container(color: KColor.kLineColor, height: 0.5),
        JhSetCell(
          cellHeight: _cellH,
          title: '备注和标签',
          text: _passValue.label,
          textAlign: TextAlign.left,
          clickCallBack: () => _clickCell(context, '备注和标签'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '朋友权限',
          text: _passValue.isStar ? '' : '不看他的朋友圈和视频动态',
          textAlign: TextAlign.left,
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '朋友权限'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH + 20,
          title: '朋友圈',
          clickCallBack: () => _clickCell(context, '朋友圈'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '更多信息',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '更多信息'),
        ),
        SizedBox(height: _rowSpace),
        InkWell(
          onTap: () => _clickCell(context, '发消息'),
          child: Container(
              height: _cellH,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/wechat/contacts/ic_xinxi.png',
                      width: 20, color: KColor.kWeiXinTextBlueColor),
                  SizedBox(width: 5),
                  Text('发消息',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KColor.kWeiXinTextBlueColor))
                ],
              )),
        ),
        Container(color: KColor.kLineColor, height: 0.5),
        InkWell(
          onTap: () => _clickCell(context, '音视频通话'),
          child: Container(
              height: _cellH,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/wechat/contacts/ic_shipintonghua.png',
                      width: 20, color: KColor.kWeiXinTextBlueColor),
                  SizedBox(width: 5),
                  Text('音视频通话',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KColor.kWeiXinTextBlueColor))
                ],
              )),
        )
      ],
    );
  }

  void _clickCell(context, title) {
    JhToast.showText(context, msg: '点击 ${title}');
  }
}
