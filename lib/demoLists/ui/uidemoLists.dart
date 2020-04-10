import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class UIDemoListsPage extends StatelessWidget {

  final List titleData = ["UI","UI2"];
  final List routeData = ["UIPage","UIPage2"];


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

