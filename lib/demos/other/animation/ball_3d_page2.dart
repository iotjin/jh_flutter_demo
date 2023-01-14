import 'package:flutter/material.dart';
import '/base_appbar.dart';
import 'xball_view.dart';

class Ball3DPage2 extends StatefulWidget {
  const Ball3DPage2({Key? key}) : super(key: key);

  @override
  State<Ball3DPage2> createState() => _DBallPage2State();
}

class _DBallPage2State extends State<Ball3DPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('3D球'),
      backgroundColor: Colors.white,
      body: XBallView(
        mediaQueryData: MediaQuery.of(context),
        keywords: const [
          '北京',
          '天津',
          '上海',
          '重庆',
          '河北',
          '山西',
          '辽宁',
          '吉林',
          '黑龙江',
          '江苏',
          '浙江',
          '安徽',
          '福建',
          '江西',
          '山东',
          '河南',
          '湖北',
          '湖南',
          '广东',
          '海南',
          '四川asdfasdf',
          '贵州',
          '云南',
          '陕西',
          '甘肃',
          '青海',
          '台湾',
          '内蒙古asdfsadfadf',
          '广西',
          '西藏',
          '宁夏',
          '新疆',
          '香港',
          '澳门',
        ],
        highlight: const ['四川'],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
