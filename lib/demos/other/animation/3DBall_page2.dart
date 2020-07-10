import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'xball_view.dart';

class DBallPage2 extends StatefulWidget {
  @override
  _DBallPage2State createState() => _DBallPage2State();
}

class _DBallPage2State extends State<DBallPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '3D球'),
      backgroundColor: Colors.white,
      body: XBallView(
        mediaQueryData: MediaQuery.of(context),
        keywords: [
          "北京",
          "天津",
          "上海",
          "重庆",
          "河北",
          "山西",
          "辽宁",
          "吉林",
          "黑龙江",
          "江苏",
          "浙江",
          "安徽",
          "福建",
          "江西",
          "山东",
          "河南",
          "湖北",
          "湖南",
          "广东",
          "海南",
          "四川asdfasdf",
          "贵州",
          "云南",
          "陕西",
          "甘肃",
          "青海",
          "台湾",
          "内蒙古asdfsadfadf",
          "广西",
          "西藏",
          "宁夏",
          "新疆",
          "香港",
          "澳门",
        ],
        highlight: ["四川"],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
