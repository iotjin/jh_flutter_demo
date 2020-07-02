import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class GridViewDemoListsPage extends StatelessWidget {

  final List titleData = ["GridViewTest1","GirdViewTest2","GirdViewTest3","GirdViewTest4","GridViewTest5"];
  final List routeData = ["GridViewTest1","GridViewTest2","GridViewTest3","GridViewTest4","GridViewTestPage5"];
  @override
  Widget build(BuildContext context) {
    return  JhTextList(
        title: "GridViewDemoListsPage",dataArr: titleData,
        callBack: (index,str){
          print(index);
          NavigatorUtils.pushNamed(context, routeData[index]);
//          NavigatorUtils.pushNamed(context, "GirdViewTest1");

        },
    );

  }
}