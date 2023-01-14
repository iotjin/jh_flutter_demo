// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/base_appbar.dart';

class SwiperTest4Page extends StatefulWidget {
  const SwiperTest4Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest4Page> createState() => _SwiperTest4PageState();
}

class _SwiperTest4PageState extends State<SwiperTest4Page> {
  List imgList = [
    'https://gitee.com/iotjh/Picture/raw/master/cat.png',
    'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
    'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  ];

  List imgList2 = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('swiper4 - carousel_slider'),
      body: ListView(
        children: <Widget>[
          swiper_1(),
          const SizedBox(height: 50),
          swiper_2(),
        ],
      ),
    );
  }

  Widget swiper_1() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.8,
          aspectRatio: 2.0,
          initialPage: 2,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: imgList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  print('点击了第: $i');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(i), fit: BoxFit.fill),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget swiper_2() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.8,
          aspectRatio: 2.0,
          initialPage: 2,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: imgList2.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  print('点击了第: $i');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Text('text $i', style: const TextStyle(fontSize: 16.0)),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
