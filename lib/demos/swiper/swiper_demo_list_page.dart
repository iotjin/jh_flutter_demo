import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'swiper1-全屏',
  'swiper2-缩放',
  'swiper3 - flutter_swiper',
  'swiper4 - carousel_slider',
  'PageView - 全屏',
  'JhSwiperView - 示例',
  'JhSwiperView - 全屏',
  'JhSwiperView - 全屏自定义',
];
final List routeData = [
  'SwiperTest1Page',
  'SwiperTest2Page',
  'SwiperTest3Page',
  'SwiperTest4Page',
  'FullScreenSwiperWidget',
  'SwiperTest5Page',
  'SwiperTest6Page',
  'SwiperTest7Page',
];

class SwiperDemoListPage extends StatelessWidget {
  const SwiperDemoListPage({super.key});

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
