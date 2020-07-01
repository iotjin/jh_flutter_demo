import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_top_tabbar.dart';
import 'package:jh_flutter_demo/demos/listView/listview_test_simple_pull_down.dart';
import 'package:jh_flutter_demo/demos/listView/listview_test_pull_down_vc.dart';
import 'package:jh_flutter_demo/res/listData.dart';


class TopTabBarTest2Page extends StatefulWidget {
  @override
  _TopTabBarTest2PageState createState() => _TopTabBarTest2PageState();
}

class _TopTabBarTest2PageState extends State<TopTabBarTest2Page> {



  List<JhTopTabBarModel> model = [
    JhTopTabBarModel(title: '标题一', widget: HomeContent()),
    JhTopTabBarModel(title: '标题二', widget: HomeContent()),
  ];

  @override
  Widget build(BuildContext context) {
    return
        JhTopTabBar(
          title: '标题',
          tabModelArr: model,
          showCenterLine: true,
          rightText: '添加',
          rightItemCallBack: (){
            print('点击右侧nav');
          },
          switchPageCallBack: (index){
            print('切换到第$index页');
          },
        );

  }
}



class HomeContent extends StatelessWidget {

  Widget _getListData(context,index){
    return ListTile(
      title: Text(listData[index]["title"]),
      leading:Image.network(listData[index]["imageUrl"]),
      subtitle:Text(listData[index]["content"]),
      onTap: (){
        print("点击的index"+index.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:listData.length,
        itemBuilder:this._getListData
    );
  }
}


Widget ContentBody = Container(
    width: 200,
    height: 200,
    color: Colors.red,
    child: RaisedButton(
      child: Text("normal"),
      onPressed: () {},
    )
);