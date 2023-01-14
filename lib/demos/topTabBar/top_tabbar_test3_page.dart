// ignore_for_file: avoid_print

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_top_tabbar.dart';
import '/res/list_data.dart';

class TopTabBarTest3Page extends StatefulWidget {
  const TopTabBarTest3Page({Key? key}) : super(key: key);

  @override
  State<TopTabBarTest3Page> createState() => _TopTabBarTest3PageState();
}

class _TopTabBarTest3PageState extends State<TopTabBarTest3Page> {
  var _count = 99;

  @override
  Widget build(BuildContext context) {
    return JhTopTabBar(
      title: '标题',
      tabModelArr: [
        JhTopTabBarModel(
            widget: const HomeContent(),
            badge: Badge(
              toAnimate: false,
              position: BadgePosition.topEnd(top: -5, end: -20),
              child: const Text('标题一'),
            )),
        JhTopTabBarModel(
            widget: const HomeContent(),
            badge: Badge(
              toAnimate: false,
              position: BadgePosition.topEnd(top: -12, end: -20),
              badgeContent: Text(_count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10)),
              child: const Text('标题二'),
            )),
      ],
      showCenterLine: true,
      rightText: '添加',
      rightItemCallBack: () {
        print('点击右侧nav');
      },
      switchPageCallBack: (index) {
        print('切换到第$index页');
        if (index == 1 && _count > 0) {
          setState(() {
            _count--;
          });
        }
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _getListData(context, index) {
    return ListTile(
      title: Text(listData[index]['title']),
      leading: Image.network(listData[index]['imageUrl']),
      subtitle: Text(listData[index]['content']),
      onTap: () {
        print('点击的index$index');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: listData.length, itemBuilder: _getListData);
  }
}

Widget contentBody = Container(
  width: 200,
  height: 200,
  color: Colors.red,
  child: ElevatedButton(
    child: const Text('normal'),
    onPressed: () {},
  ),
);
