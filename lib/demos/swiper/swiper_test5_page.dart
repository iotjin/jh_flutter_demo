// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_swiper_view.dart';
import '/base_appbar.dart';

class SwiperTest5Page extends StatefulWidget {
  const SwiperTest5Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest5Page> createState() => _SwiperTest5PageState();
}

class _SwiperTest5PageState extends State<SwiperTest5Page> {
  List imgList = [
    'https://gitee.com/iotjh/Picture/raw/master/cat.png',
    'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
    'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  ];

  List imgList2 = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhSwiperView - 示例'),
      body: ListView(
        children: <Widget>[
          _swiper1(),
          const SizedBox(height: 50),
          _swiper2(),
        ],
      ),
    );
  }

  _swiper1() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
      child: JhSwiperView(
        data: imgList,
        clickCallBack: (int index, dynamic imgArr) {
          print('index: $index');
          print('img: ${imgArr[index]}');
          JhProgressHUD.showText('点击第 $index 个');
        },
        onPageChanged: (int index, dynamic imgArr) {
          // print('index: $index');
          // print('img: ${imgArr[index]}');
        },
      ),
    );
  }

  _swiper2() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: JhSwiperView(
        data: imgList,
        viewportFraction: 1.0,
        radius: 0,
        enlargeCenterPage: false,
        isShowIndicator: true,
      ),
    );
  }
}
