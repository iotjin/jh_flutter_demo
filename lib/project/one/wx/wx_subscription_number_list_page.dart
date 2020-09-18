/**
 *  wx_subscription_number_list_page.dart
 *
 *  Created by iotjin on 2020/09/03.
 *  description:
 */

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

var _dataArr;

List _getData() {
  _dataArr = new List();
  for (int i = 0; i < 50; i++) {
    var map = new Map();
    map["title"] = "title${i}";
    map["subtitle"] =
        "这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容";
    map["img"] = "assets/images/ic_demo1.png";
    map["time"] = "17:30";
    _dataArr.add(map);
  }
  return _dataArr;
}

class WxSubscriptionNumberListPage extends StatelessWidget {
  WxSubscriptionNumberListPage({Key key}) : super(key: key) {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '订阅号',
          rightImgPath: 'assets/images/ic_more_black.png',
          backgroundColor: Colors.transparent, rightItemCallBack: () {
        _clickCell(context, '更多');
      }),
      body: _body(context, _dataArr),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }

  //body
  Widget _body(context, dataArr) {
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

    return ListView.separated(
        //列表项构造器
        itemCount: dataArr.length + 1,
        //分割器构造器
        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
            indent: 70,
            endIndent: 0,
            color: KColor.kLineColor,
          );
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return _searchBar;
          }
          return _cell(context, dataArr[index]);
        });
  }

  //cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () => _clickCell(context, item['title']),
        child: Container(
            color: Colors.white,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      item['img'],
                      width: 60,
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                Container(color: KColor.kLineColor, height: 0.8),
                    SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 70,
                            child: Text(item['title'],
                                style: TextStyle(fontSize: 18))),
                        Expanded(
                            flex: 30,
                            child: Text(
                              item['time'],
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.right,
                            )),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(item['subtitle'],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                )),
              ],
            )));
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }

  //点击侧滑按钮
  void _showSnackBar(context, text) {
    print(text);
    JhToast.showText(context, msg: text);
  }
}
