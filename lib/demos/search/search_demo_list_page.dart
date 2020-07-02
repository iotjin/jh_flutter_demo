import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class SearchDemoListPage extends StatelessWidget {

  final List titleData = ["搜索框1","搜索框2","搜索框3"];
  final List routeData = ["SearchTest1Page","SearchTest2Page","SearchTest3Page"];


  @override
  Widget build(BuildContext context) {
    return  JhTextList(
        title: "搜索框",dataArr: titleData,
        callBack: (index,str){
          print(routeData[index]);
          NavigatorUtils.pushNamed(context, routeData[index]);
        },
    );

  }
}
