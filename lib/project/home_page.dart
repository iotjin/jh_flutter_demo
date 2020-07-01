import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'one/one_page.dart';
import 'Two/two_page.dart';
import 'Three/three_page.dart';
import 'four/four_page.dart';
import 'configs/strings.dart';
import '../jh_common/utils/jh_image_utils.dart';




class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

//  List<BottomNavigationBarItem> _items = [
//    BottomNavigationBarItem(
//        icon: Icon(Icons.chat_bubble),
//        title: Text(KString.oneTabTitle)
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(Icons.group),
//        title: Text(KString.twoTabTitle)
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(Icons.directions),
//        title: Text(KString.threeTabTitle)
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(Icons.person_outline),
//        title: Text(KString.fourTabTitle)
//    )
//  ];

  static _tabIcon(String assets) {
  return JhLoadAssetImage('tab/$assets',width: 25);
  }

  static _tabSelectedIcon(String assets) {
    return JhLoadAssetImage('tab/$assets',width: 25);
  }

  static _tabTitleText(String txt) {
    return Text(txt, style: TextStyle(fontSize: 12));
  }

  List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        title:_tabTitleText(KString.oneTabTitle),
        icon: _tabIcon("nav_tab_1"),
        activeIcon: _tabSelectedIcon("nav_tab_1_on")
    ),
    BottomNavigationBarItem(
        title:_tabTitleText(KString.twoTabTitle),
        icon: _tabIcon("nav_tab_2"),
        activeIcon: _tabSelectedIcon("nav_tab_2_on")
    ),
    BottomNavigationBarItem(
        title:_tabTitleText(KString.threeTabTitle),
        icon: _tabIcon("nav_tab_3"),
        activeIcon: _tabSelectedIcon("nav_tab_3_on")
    ),
    BottomNavigationBarItem(
        title:_tabTitleText(KString.fourTabTitle),
        icon: _tabIcon("nav_tab_4"),
        activeIcon: _tabSelectedIcon("nav_tab_4_on")
    ),
  ];


  List<Widget> _pages = [
    OnePage(),
    TwoPage(),
    ThreePage(),
    FourPage()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        items: bottomTabs,
        unselectedFontSize:12,
        selectedFontSize:12,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}