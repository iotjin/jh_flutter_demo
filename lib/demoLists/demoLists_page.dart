import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';
import 'package:jh_flutter_demo/routes/routes.dart' as Luyou;

class DemoListsPage extends StatelessWidget {

  final List titleData = ["UI","ListView","GridView","弹框","Form","图片选择","跳转传值和回传","网络请求","baseNav","JhForm"];
  final List routeData = ["UIDemoListsPage","ListViewDemoListsPage","GridViewDemoListsPage",
    "AlertDemoListsPage","FormTest","PhotoSelectTest","PassValuePage","HttpDemoListsPage",
    "NavTestPage","FormDemoListsPage",
  ];

  @override
  Widget build(BuildContext context) {
    return
      JhTextList(
        title: "DemoLists",
        dataArr: titleData,
        callBack: (index,str){
//          print(index);
          print(str);
//          print(routeData[index]);
          Navigator.pushNamed(context, routeData[index]);
        },
      );

  }
}
