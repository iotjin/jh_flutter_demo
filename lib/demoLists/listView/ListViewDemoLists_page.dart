import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class ListViewDemoListsPage extends StatelessWidget {

  final List titleData = ["ListViewTest","ListViewTest2","ListViewTest3","ListViewTest4","ListViewTest5","ListViewTest_Card","ListViewTest_CustomVC","ListViewTest_SimplePullDown","ListViewTest_PullDownVC"];
  final List routeData = ["ListViewTest","ListViewTest2","ListViewTest3","ListViewTest4","ListViewTest5","ListViewTest_Card","ListViewTest_CustomVC","ListViewTest_SimplePullDown","ListViewTest_PullDownVC"];


  @override
  Widget build(BuildContext context) {
    return  JhTextList(
        title: "ListViewDemoLists",dataArr: titleData,
        callBack: (index,str){
          print(routeData[index]);
          Navigator.pushNamed(context, routeData[index]);
        },
    );

  }
}
