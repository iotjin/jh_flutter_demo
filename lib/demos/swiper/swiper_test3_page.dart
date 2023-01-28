// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

class SwiperTest3Page extends StatefulWidget {
  const SwiperTest3Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest3Page> createState() => _SwiperTest3PageState();
}

class _SwiperTest3PageState extends State<SwiperTest3Page> {
  List imgList = [
    'https://gitee.com/iotjh/Picture/raw/master/cat.png',
    'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
    'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  ];

  List imgList2 = [
    'https://desk-fd.zol-img.com.cn/t_s1024x768c5/g5/M00/02/00/ChMkJlbKw1eIdabyAASvPG-H6SwAALG1gFD3VQABK9U648.jpg',
    'https://desk-fd.zol-img.com.cn/t_s1024x768c5/g5/M00/02/00/ChMkJ1bKw1eILNybAAMnVXZZfj0AALG1gFIjKgAAydt911.jpg',
    'https://desk-fd.zol-img.com.cn/t_s1024x768c5/g5/M00/02/00/ChMkJlbKw1eIe_ACAAS4xbkUZBoAALG1gFLtBUABLjd443.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('swiper3 - flutter_swiper'),
      body: ListView(
        children: <Widget>[
          swiper_1(),
          swiper_2(),
        ],
      ),
    );
  }

  Widget swiper_1() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: 260,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return JhNetworkImage(imgList[index], fit: BoxFit.fill);
          },
          onTap: (index) {
            print('点击了第$index');
          },
          itemCount: imgList.length,
          autoplay: true,
          pagination: const SwiperPagination(
            // 位置 Alignment.bottomCenter 底部中间
            alignment: Alignment.bottomRight,
            // 距离调整
            margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: FractionPaginationBuilder(
              color: Colors.white, // 字体颜色
              activeColor: Colors.yellow, // 当前的指示字体颜色
              fontSize: 20, // 字体大小
              activeFontSize: 25, // 当前的指示字体大小
            ),
          ),
        ));
  }

  Widget swiper_2() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: 260,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(imgList2[index], fit: BoxFit.fitWidth);
          },
          onTap: (index) {
            print('点击了第$index');
          },
          itemCount: imgList2.length,
          autoplay: true,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
        ));
  }
}
