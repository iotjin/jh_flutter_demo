// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_swiper_view.dart';

class SwiperTest6Page extends StatefulWidget {
  const SwiperTest6Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest6Page> createState() => _SwiperTest6PageState();
}

class _SwiperTest6PageState extends State<SwiperTest6Page> {
  List imgList = [
    'https://gitee.com/iotjh/Picture/raw/master/cat.png',
    'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
    'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return JhSwiperView(
      data: imgList,
      height: JhScreenUtils.screenHeight,
      viewportFraction: 1.0,
      aspectRatio: 16 / 9,
      radius: 0,
      loop: false,
      autoPlay: false,
      enlargeCenterPage: false,
      isShowIndicator: true,
      indicatorBottomMargin: 50,
      clickCallBack: (int index, dynamic imgArr) {
        print('index: $index');
        print('img: ${imgArr[index]}');
        Navigator.pop(context);
      },
      onPageChanged: (int index, dynamic imgArr) {
        // print('index: $index');
        // print('img: ${imgArr[index]}');
      },
    );
  }
}
