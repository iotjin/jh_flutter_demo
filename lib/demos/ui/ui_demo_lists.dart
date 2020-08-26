import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class UIDemoListsPage extends StatelessWidget {

  final List titleData = ["UI","UI2","Scroll"];
  final List routeData = ["UIPage","UIPage2","ScrollPage"];


  @override
  Widget build(BuildContext context) {
    return  JhTextList(
      title: "UITest",dataArr: titleData,
      callBack: (index,str){
        NavigatorUtils.pushNamed(context, routeData[index]);
      },
    );

  }
}

