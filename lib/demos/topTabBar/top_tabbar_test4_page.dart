// ignore_for_file: unused_local_variable, unused_element, unused_field
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_top_tabbar.dart';
import './content_page.dart';

class TopTabBarTest4Page extends StatefulWidget {
  const TopTabBarTest4Page({Key? key}) : super(key: key);

  @override
  State<TopTabBarTest4Page> createState() => _TopTabBarTest4PageState();
}

class _TopTabBarTest4PageState extends State<TopTabBarTest4Page> {
  List<JhTopTabBarModel> model = [
    const JhTopTabBarModel(title: '标题一', widget: ContentPage()),
    const JhTopTabBarModel(title: '标题二', widget: ContentPage()),
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
