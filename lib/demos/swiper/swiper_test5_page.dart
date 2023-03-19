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

  List textList2 = ['1111111111', '2222222222', '3333333333', '444444444444', '55555555555555', '6666666666666666666'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhSwiperView - 示例'),
      body: ListView(
        children: <Widget>[_swiper1(), const SizedBox(height: 50), _swiper2(), _swiper3()],
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

  _swiper3() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: JhSwiperView(
          data: textList2,
          scrollDirection: Axis.vertical,
          height: 30,
          viewportFraction: 1.0,
          radius: 0,
          enlargeCenterPage: false,
          itemBuilder: (BuildContext context, int index) {
            return _itemWidget(textList2[index]);
          }),
    );
  }

  _itemWidget(text) {
    return Container(
      height: 30,
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text)],
      ),
    );
  }
}
