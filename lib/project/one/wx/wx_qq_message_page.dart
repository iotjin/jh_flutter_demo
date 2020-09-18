/**
 *  wx_qq_message_page.dart
 *
 *  Created by iotjin on 2020/09/03.
 *  description:
 */

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

List _dataArr = [
  {
    "title": "消息1",
    "subtitle": "您收到一封新的邮件",
  },
  {
    "title": "消息2",
    "subtitle": "您收到一封新的邮件",
  },
];

class WxQQMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'QQ邮箱提醒',
          rightImgPath: 'assets/images/ic_more_black.png',
          backgroundColor: Colors.transparent, rightItemCallBack: () {
        _clickCell(context, '更多');
      }),
      body: _body(context, _dataArr),
    );
  }

  Widget _body(context, dataArr) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: _dataArr.length,
//            itemExtent: 150.0, //强制高度为100.0
            itemBuilder: (context, index) {
              return _cell(context, dataArr[index]);
            }),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _bottomView(context, dataArr),
        ),
      ],
    );
  }

  //cell
  Widget _cell(context, item) {
    return Card(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        //设置圆角
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        // 抗锯齿
        clipBehavior: Clip.antiAlias,
        //普通的边
//    shape: Border.all(color: Colors.yellow, width: 5.0),
        elevation: 3,
        // 阴影大小
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text(item['title']),
            subtitle: Text(
              item['subtitle'],
            ),
            onTap: () => _clickCell(context, item['title']),
          ),
        ));
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }

  _bottomView(context, dataArr) {
    return Container(
      height: JhScreenUtils.bottomSafeHeight + 60,
      color: Colors.white,
      child: SafeArea(
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 60,
                color: Colors.white,
                child: Center(child: Text('写邮件')),
              ),
              onTap: () => _clickCell(context, '写邮件'),
            ),
          ),
          Container(height: 60, width: 0.5, color: KColor.kLineColor),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 60,
                color: Colors.white,
                child: Center(child: Text('QQ邮箱（${dataArr.length}）')),
              ),
              onTap: () => _clickCell(context, 'QQ邮箱'),
            ),
          ),
        ],
      )),
    );
  }
}
