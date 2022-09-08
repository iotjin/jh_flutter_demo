import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class SwiperDemoListPage extends StatelessWidget {
  final List titleData = [
    'swiper1-全屏',
    'swiper2-缩放',
    'swiper3 - flutter_swiper',
    'swiper4 - carousel_slider',
    '全屏',
  ];
  final List routeData = [
    'SwiperTest1Page',
    'SwiperTest2Page',
    'SwiperTest3Page',
    'SwiperTest4Page',
    'FullScreenSwiperWidget',
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '轮播',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
