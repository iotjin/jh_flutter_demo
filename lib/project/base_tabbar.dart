/**
 *  base_tabbar.dart
 *
 *  Created by iotjin on 2020/03/08.
 *  description:  tabbar
 */

import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_image_utils.dart';
import 'package:jh_flutter_demo/project/one/one_page.dart';
import 'package:jh_flutter_demo/project/Two/two_page.dart';
import 'package:jh_flutter_demo/project/Three/three_page.dart';
import 'four/four_page.dart';

class BaseTabBar extends StatefulWidget {
  BaseTabBar({Key key}) : super(key: key);

  _BaseTabBarState createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> {
  int _currentIndex = 0;
  List<Widget> _pageList = [OnePage(), TwoPage(), ThreePage(), FourPage()];
  static double _iconWH = 24.0;
  static double _fontSize = 10.0;
  Color selColor = Color(0xFF3BB815);

  List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      title: Text("微信"),
      icon: JhLoadAssetImage('tab/nav_tab_1', width: _iconWH),
      activeIcon: JhLoadAssetImage('tab/nav_tab_1_on', width: _iconWH),
    ),
    BottomNavigationBarItem(
      title: Text("通讯录"),
      icon: JhLoadAssetImage('tab/nav_tab_2', width: _iconWH),
      activeIcon: JhLoadAssetImage('tab/nav_tab_2_on', width: _iconWH),
    ),
    BottomNavigationBarItem(
      title: Text("发现"),
//      icon: JhLoadAssetImage('tab/nav_tab_3', width: _iconWH),
      activeIcon: JhLoadAssetImage('tab/nav_tab_3_on', width: _iconWH),
      icon: Badge(
          padding: EdgeInsets.all(4),
          position: BadgePosition.topRight(top: -4, right: -4),
          child: JhLoadAssetImage('tab/nav_tab_3', width: _iconWH)),
//      activeIcon: Badge(
//          padding: EdgeInsets.all(4),
//          position: BadgePosition.topRight(top: -4, right: -4),
//          child: JhLoadAssetImage('tab/nav_tab_3_on', width: _iconWH)),
    ),
    BottomNavigationBarItem(
      title: Text("我的"),
      icon: JhLoadAssetImage('tab/nav_tab_4', width: _iconWH),
      activeIcon: JhLoadAssetImage('tab/nav_tab_4_on', width: _iconWH),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
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
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar:

//        Theme(
//          data: ThemeData(
//            highlightColor: Color.fromRGBO(0, 0, 0, 0),
//            splashColor: Color.fromRGBO(0, 0, 0, 0),
//          ),
//          child:
//          BottomNavigationBar(
////        unselectedItemColor:Colors.red,  //未选中颜色
////        selectedItemColor:Colors.yellow,  //选中颜色
//            fixedColor: selColor,  //选中的颜色
//            unselectedFontSize:_fontSize,
//            selectedFontSize:_fontSize,
//            type:BottomNavigationBarType.fixed,   //配置底部BaseTabBar可以有多个按钮
//            items: bottomTabs,
//            currentIndex: this._currentIndex,   //配置对应的索引值选中
//            onTap: (int index){
//              setState(() {  //改变状态
//                this._currentIndex=index;
//              });
//            },
//          ),
//
//        )

          BottomNavigationBar(
//        unselectedItemColor:Colors.red,  //未选中颜色
//        selectedItemColor:Colors.yellow,  //选中颜色
        fixedColor: selColor,
        //选中的颜色
        unselectedFontSize: _fontSize,
        selectedFontSize: _fontSize,
        type: BottomNavigationBarType.fixed,
        //配置底部BaseTabBar可以有多个按钮
        items: bottomTabs,
        currentIndex: this._currentIndex,
        //配置对应的索引值选中
        onTap: (int index) {
          setState(() {
            //改变状态
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}

/*-----------------------------------------------------------------------------*/
/*
BottomNavigationBar({
    Key key,
    @required this.items,  //必须有的item
    this.onTap,  //点击事件
    this.currentIndex = 0,  //当前选中
    this.elevation = 8.0,  //高度
    BottomNavigationBarType type,  //排列方式
    Color fixedColor,    //'Either selectedItemColor or fixedColor can be specified, but not both'
    this.backgroundColor,  //背景
    this.iconSize = 24.0,  //icon大小
    Color selectedItemColor,  //选中颜色
    this.unselectedItemColor,  //未选中颜色
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,  //选中文字大小
    this.unselectedFontSize = 12.0,  //未选中文字大小
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true, //是否显示选中的Item的文字
    bool showUnselectedLabels,  //是否显示未选中的Item的问题
  })

 */
