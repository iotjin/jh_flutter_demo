import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class SwiperDemoListPage extends StatelessWidget {
  final List titleData = ['swiper1-全屏', 'swiper2', 'swiper3-缩放'];
  final List routeData = [
    'TopTabBarTest1Page',
    'TopTabBarTest2Page',
    'TopTabBarTest3Page'
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "轮播",
      dataArr: titleData,
      callBack: (index, str) {
        NavigatorUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
