import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class UIDemoListsPage extends StatelessWidget {

  final List titleData = ["UI"];
  final List routeData = ["UIPage"];


  @override
  Widget build(BuildContext context) {
    return  JhTextList(
      title: "UITest",dataArr: titleData,
      callBack: (index,str){
        Navigator.pushNamed(context, routeData[index]);
      },
    );

  }
}

