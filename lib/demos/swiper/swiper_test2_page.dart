// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import '/base_appbar.dart';

class SwiperTest2Page extends StatefulWidget {
  const SwiperTest2Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest2Page> createState() => _SwiperTest2PageState();
}

class _SwiperTest2PageState extends State<SwiperTest2Page> {
  List imgList = [
    'https://gitee.com/iotjh/Picture/raw/master/cat.png',
    'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
    'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('swiper2-缩放'),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
        height: 280,
        child: Swiper(
          scrollDirection: Axis.horizontal,
          itemCount: imgList.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(imgList[index]), fit: BoxFit.fill),
              ),
            );
          },
          onTap: (index) {
            print('点击了第$index');
          },
          // 分页指示器
          pagination: const SwiperPagination(
            // 位置 Alignment.bottomCenter 底部中间
            alignment: Alignment.bottomCenter,
            // 距离调整
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            builder: DotSwiperPaginationBuilder(
                // 点之间的间隔
                space: 5,
                // 没选中时的大小
                size: 10,
                // 选中时的大小
                activeSize: 12,
                // 没选中时的颜色
                color: Colors.grey,
                // 选中时的颜色
                activeColor: Colors.white),
          ),
          // 页面控制器 左右翻页按钮
//          control: new SwiperControl(color: Colors.pink),
          scale: 0.85,
          // 两张图片之间的间隔
          viewportFraction: 0.8, // 当前视窗展示比例 小于1可见上一个和下一个视窗
        ),
      ),
    );
  }
}
