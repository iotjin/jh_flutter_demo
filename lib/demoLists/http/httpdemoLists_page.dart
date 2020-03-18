import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class HttpDemoListsPage extends StatelessWidget {

  final List titleData = ["dio使用","分页加载数据",];
  final List routeData = ["HttpTest1Page","HttpPageTestPage"];

  @override
  Widget build(BuildContext context) {
    return
      JhTextList(
        title: "HttpDemoLists",
        dataArr: titleData,
        callBack: (index,str){
          Navigator.pushNamed(context, routeData[index]);
        },
      );

  }
}
