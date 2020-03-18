import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class GridViewDemoListsPage extends StatelessWidget {

  final List titleData = ["GridViewTest1","GirdViewTest2","GirdViewTest3","GirdViewTest4"];
  final List routeData = ["GridViewTest1","GridViewTest2","GridViewTest3","GridViewTest4"];
  @override
  Widget build(BuildContext context) {
    return  JhTextList(
        title: "GridViewDemoListsPage",dataArr: titleData,
        callBack: (index,str){
          print(index);
          Navigator.pushNamed(context, routeData[index]);
//          Navigator.pushNamed(context, "GirdViewTest1");

        },
    );

  }
}