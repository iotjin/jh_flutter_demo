// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/jh_common/widgets/jh_top_tabbar.dart';
import '/res/list_data.dart';

class TopTabBarTest2Page extends StatefulWidget {
  const TopTabBarTest2Page({Key? key}) : super(key: key);

  @override
  State<TopTabBarTest2Page> createState() => _TopTabBarTest2PageState();
}

class _TopTabBarTest2PageState extends State<TopTabBarTest2Page> {
  List<JhTopTabBarModel> model = [
    const JhTopTabBarModel(title: '标题一', widget: HomeContent()),
    const JhTopTabBarModel(title: '标题二', widget: HomeContent()),
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _getListData(context, index) {
    return ListTile(
      title: Text(listData[index]['title']),
      leading: JhNetworkImage(listData[index]['imageUrl']),
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
