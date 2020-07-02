import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

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
          NavigatorUtils.pushNamed(context, routeData[index]);
        },
      );

  }
}
