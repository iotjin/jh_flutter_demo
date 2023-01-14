// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_top_tabbar.dart';

class TopTabBarTest1Page extends StatefulWidget {
  const TopTabBarTest1Page({Key? key}) : super(key: key);

  @override
  State<TopTabBarTest1Page> createState() => _TopTabBarTest1PageState();
}

class _TopTabBarTest1PageState extends State<TopTabBarTest1Page> {
  List<JhTopTabBarModel> model = [
    JhTopTabBarModel(
      title: '标题一',
      widget: Container(
        alignment: Alignment.center,
        child: const Text('页面一', textScaleFactor: 3),
      ),
    ),
    JhTopTabBarModel(
      title: '标题二',
      widget: Container(
        alignment: Alignment.center,
        child: const Text('页面二', textScaleFactor: 3),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return JhTopTabBar(
      title: '标题',
      tabModelArr: model,
      showCenterLine: true,
      rightText: '添加',
      rightItemCallBack: () {
        print('点击右侧nav');
      },
      switchPageCallBack: (index) {
        print('切换到第$index页');
      },
    );
  }
}
