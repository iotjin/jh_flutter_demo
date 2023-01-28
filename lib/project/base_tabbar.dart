///  base_tabbar.dart
///
///  Created by iotjin on 2020/03/08.
///  description: tabbar基类

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/widgets/base_refresh_view.dart';
import '/project/configs/colors.dart';
import '/project/provider/tabbar_provider.dart';
import '/project/provider/theme_provider.dart';
import '/project/one/one_page.dart';
import '/project/Two/two_page.dart';
import '/project/Three/three_page.dart';
import '/project/four/four_page.dart';

const double _iconWH = 24.0;
const double _fontSize = 10.0;

class BaseTabBar extends StatefulWidget {
  const BaseTabBar({Key? key}) : super(key: key);

  @override
  State<BaseTabBar> createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> {
  // int _currentIndex = 0;
  final List<Widget> _pageList = const [OnePage(), TwoPage(), ThreePage(), FourPage()];

  final PageController _pageController = PageController();

  List<BottomNavigationBarItem> getBottomTabs(iconColor) {
    return [
      BottomNavigationBarItem(
        label: '微信',
        icon: const JhAssetImage('tab/nav_tab_1', width: _iconWH),
        activeIcon: JhAssetImage('tab/nav_tab_1_on', width: _iconWH, color: iconColor),
      ),
      BottomNavigationBarItem(
        label: '通讯录',
        icon: const JhAssetImage('tab/nav_tab_2', width: _iconWH),
        activeIcon: JhAssetImage('tab/nav_tab_2_on', width: _iconWH, color: iconColor),
      ),
      BottomNavigationBarItem(
        label: '发现',
//      icon: JhAssetImage('tab/nav_tab_3', width: _iconWH),
        activeIcon: JhAssetImage('tab/nav_tab_3_on', width: _iconWH, color: iconColor),
        icon: Badge(
            padding: const EdgeInsets.all(4),
            position: BadgePosition.topEnd(top: -4, end: -4),
            child: const JhAssetImage('tab/nav_tab_3', width: _iconWH)),
//      activeIcon: Badge(
//          padding: EdgeInsets.all(4),
//          position: BadgePosition.topRight(top: -4, right: -4),
//          child: JhAssetImage('tab/nav_tab_3_on', width: _iconWH)),
      ),
      BottomNavigationBarItem(
        label: '我的',
        icon: const JhAssetImage('tab/nav_tab_4', width: _iconWH),
        activeIcon: JhAssetImage('tab/nav_tab_4_on', width: _iconWH, color: iconColor),
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 设置EasyRefresh的默认样式
    initEasyRefresh();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var bgColor = KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor);
    var normalTextColor =
        KColors.dynamicColor(context, KColors.kTabBarNormalTextColor, KColors.kTabBarNormalTextDarkColor);
    var selectTextColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var selectIconColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    /// 保持页面状态的几种方式 https://blog.csdn.net/iotjin/article/details/126870716
    /// 如果需要在某个页面跳转返回到tabbar的指定页面，Provider create 添加到main.dart，否则写在BaseTabBar中
    /// 通过 PageView + AutomaticKeepAliveClientMixin 保持页面状态（进到哪个页面，哪个页面开始初始化）
    /// 在需要保持页面状态的子页面State中，继承AutomaticKeepAliveClientMixin并重写方法 wantKeepAlive => true
    /// 并且它们的[build]方法必须调用super.build(context);
    return ChangeNotifierProvider(
      create: (_) => TabbarProvider(),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          controller: _pageController,
          children: _pageList,
        ),
        bottomNavigationBar: Consumer<TabbarProvider>(builder: (_, provider, __) {
          return BottomNavigationBar(
            backgroundColor: bgColor,
            // 未选中颜色
            unselectedItemColor: normalTextColor,
            // 选中颜色,与fixedColor不能同时设置
            // selectedItemColor: selectColor,
            // 选中的颜色
            fixedColor: selectTextColor,
            unselectedFontSize: _fontSize,
            selectedFontSize: _fontSize,
            // 配置底部BaseTabBar可以有多个按钮
            type: BottomNavigationBarType.fixed,
            items: getBottomTabs(selectIconColor),
            // 配置对应的索引值选中
            currentIndex: provider.currentIndex,
            // 配置对应的索引值选中
            onTap: (int index) {
              setState(() {
                // 改变状态
                provider.currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
          );
        }),
      ),
    );
  }
}
