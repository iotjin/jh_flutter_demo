import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'JhTopTabBar1',
  'JhTopTabBar2',
  'JhTopTabBar3 - 小红点',
  'JhTopTabBar4 - 分页+header/footer跟随',
  '个人中心1 - TopTabBar+背景图',
  '个人中心2 - TopTabBar+背景图+缓存滚动',
  '个人中心3 - TopTabBar+下拉背景图+缓存滚动',
  '图片下拉放大+刷新',
  '图片下拉放大+刷新+自定义指示器',
];
final List routeData = [
  'TopTabBarTest1Page',
  'TopTabBarTest2Page',
  'TopTabBarTest3Page',
  'TopTabBarTest4Page',
  'PersonalCenterPage1',
  'PersonalCenterPage2',
  'PersonalCenterPage3',
  'PersonalCenterPage4',
  'PersonalCenterPage5',
];

class TopTabBarDemoListPage extends StatelessWidget {
  const TopTabBarDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '十字滑动(个人中心效果)',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
