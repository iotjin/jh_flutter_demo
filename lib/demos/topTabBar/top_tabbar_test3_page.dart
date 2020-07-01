import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/res/listData.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_top_tabbar.dart';

class TopTabBarTest3Page extends StatefulWidget {
  @override
  _TopTabBarTest3PageState createState() => _TopTabBarTest3PageState();
}

class _TopTabBarTest3PageState extends State<TopTabBarTest3Page> {
  var _count = 99;

  @override
  Widget build(BuildContext context) {
    return JhTopTabBar(
      title: '标题',
      tabModelArr: [
        JhTopTabBarModel(
            widget: HomeContent(),
            badge: Badge(
              toAnimate: false,
              position: BadgePosition.topRight(top: -5, right: -20),
              child: Text("标题一"),
            )),
        JhTopTabBarModel(
            widget: HomeContent(),
            badge: Badge(
              toAnimate: false,
              position: BadgePosition.topRight(top: -12, right: -20),
              badgeContent: Text(_count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              child: Text("标题二"),
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
  Widget _getListData(context, index) {
    return ListTile(
      title: Text(listData[index]["title"]),
      leading: Image.network(listData[index]["imageUrl"]),
      subtitle: Text(listData[index]["content"]),
      onTap: () {
        print("点击的index" + index.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listData.length, itemBuilder: this._getListData);
  }
}

Widget ContentBody = Container(
    width: 200,
    height: 200,
    color: Colors.red,
    child: RaisedButton(
      child: Text("normal"),
      onPressed: () {},
    ));
