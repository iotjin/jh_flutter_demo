///  base_tabbar.dart
///
///  Created by iotjin on 2020/03/08.
///  description:  tabbar基类

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:badges/badges.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import '/jh_common/utils/jh_image_utils.dart';
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
  BaseTabBar({Key? key}) : super(key: key);

  _BaseTabBarState createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> {
  // int _currentIndex = 0;
  List<Widget> _pageList = [OnePage(), TwoPage(), ThreePage(), FourPage()];

  final PageController _pageController = PageController();

  List<BottomNavigationBarItem> getBottomTabs(iconColor) {
    return [
      BottomNavigationBarItem(
        label: '微信',
        icon: JhLoadAssetImage('tab/nav_tab_1', width: _iconWH),
        activeIcon: JhLoadAssetImage('tab/nav_tab_1_on', width: _iconWH, color: iconColor),
      ),
      BottomNavigationBarItem(
        label: '通讯录',
        icon: JhLoadAssetImage('tab/nav_tab_2', width: _iconWH),
        activeIcon: JhLoadAssetImage('tab/nav_tab_2_on', width: _iconWH, color: iconColor),
      ),
      BottomNavigationBarItem(
        label: '发现',
//      icon: JhLoadAssetImage('tab/nav_tab_3', width: _iconWH),
        activeIcon: JhLoadAssetImage('tab/nav_tab_3_on', width: _iconWH, color: iconColor),
        icon: Badge(
            padding: EdgeInsets.all(4),
            position: BadgePosition.topEnd(top: -4, end: -4),
            child: JhLoadAssetImage('tab/nav_tab_3', width: _iconWH)),
//      activeIcon: Badge(
//          padding: EdgeInsets.all(4),
//          position: BadgePosition.topRight(top: -4, right: -4),
//          child: JhLoadAssetImage('tab/nav_tab_3_on', width: _iconWH)),
      ),
      BottomNavigationBarItem(
        label: '我的',
        icon: JhLoadAssetImage('tab/nav_tab_4', width: _iconWH),
        activeIcon: JhLoadAssetImage('tab/nav_tab_4_on', width: _iconWH, color: iconColor),
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((Duration timestamp) {
      // 设置EasyRefresh的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
        noMoreText: '没有更多',
        showInfo: false,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var bgColor = KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor);
    var normalTextColor =
        KColors.dynamicColor(context, KColors.kTabBarNormalTextColor, KColors.kTabBarNormalTextDarkColor);
    var selectTextColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var selectIconColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

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

/*-----------------------------------------------------------------------------*/

  /// 保持页面状态的几种方式
  /// https://www.jianshu.com/p/4b09054640f3
  /// https://www.jianshu.com/p/369f00a40cc2
  /// https://zhuanlan.zhihu.com/p/58582876

  ///  使用IndexedStack保持页面状态如下：
  ///  这种方式有个小缺点：IndexedStack中管理的子页面在第一次加载时便实例化了所有的子页面State

// @override
// Widget build(BuildContext context) {
//   // TODO: 通过ThemeProvider进行主题管理
//   final provider = Provider.of<ThemeProvider>(context);
//   var bgColor = KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor);
//   var normalTextColor =
//       KColors.dynamicColor(context, KColors.kTabBarNormalTextColor, KColors.kTabBarNormalTextDarkColor);
//   var selectTextColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
//   var selectIconColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
//
//   return Scaffold(
//     body: IndexedStack(
//       index: _currentIndex,
//       children: _pageList,
//     ),
//     bottomNavigationBar: BottomNavigationBar(
//       backgroundColor: bgColor,
//       // 未选中颜色
//       unselectedItemColor: normalTextColor,
//       // 选中颜色,与fixedColor不能同时设置
//       // selectedItemColor: selectColor,
//       // 选中的颜色
//       fixedColor: selectTextColor,
//       unselectedFontSize: _fontSize,
//       selectedFontSize: _fontSize,
//       // 配置底部BaseTabBar可以有多个按钮
//       type: BottomNavigationBarType.fixed,
//       items: getBottomTabs(selectIconColor),
//       // 配置对应的索引值选中
//       currentIndex: this._currentIndex,
//       onTap: (int index) {
//         setState(() {
//           // 改变状态
//           this._currentIndex = index;
//         });
//       },
//     ),
//   );
// }

}

/*-----------------------------------------------------------------------------*/
/*

 Theme(
   data: ThemeData(
     highlightColor: Color.fromRGBO(0, 0, 0, 0),
     splashColor: Color.fromRGBO(0, 0, 0, 0),
   ),
 )

BottomNavigationBar({
    Key key,
    @required this.items,  // 必须有的item
    this.onTap,  // 点击事件
    this.currentIndex = 0,  // 当前选中
    this.elevation = 8.0,  // 高度
    BottomNavigationBarType type,  // 排列方式
    Color fixedColor,    // 'Either selectedItemColor or fixedColor can be specified, but not both'
    this.backgroundColor,  // 背景
    this.iconSize = 24.0,  // icon大小
    Color selectedItemColor,  // 选中颜色
    this.unselectedItemColor,  // 未选中颜色
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,  // 选中文字大小
    this.unselectedFontSize = 12.0,  // 未选中文字大小
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true, // 是否显示选中的Item的文字
    bool showUnselectedLabels,  // 是否显示未选中的Item的问题
  })

 */
