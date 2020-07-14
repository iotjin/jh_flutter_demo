import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class ChartDemoListPage extends StatelessWidget {

  final List titleData = ["ChartPage1","ChartPage2","EChartPage1","MpChartLinePage1","MpChartBarPage1",];
  final List routeData = ["ChartPage1","ChartPage2","EChartPage1","MpChartLinePage1","MpChartBarPage1",];
  @override
  Widget build(BuildContext context) {
    return  JhTextList(
      title: "Chart",dataArr: titleData,
      callBack: (index,str){
        print(index);
        NavigatorUtils.pushNamed(context, routeData[index]);

      },
    );

  }
}