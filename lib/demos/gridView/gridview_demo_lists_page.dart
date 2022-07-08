import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class GridViewDemoListsPage extends StatelessWidget {
  final List titleData = ["GridViewTest1", "GirdViewTest2", "GirdViewTest3", "GirdViewTest4", "GridViewTest5"];
  final List routeData = ["GridViewTest1", "GridViewTest2", "GridViewTest3", "GridViewTest4", "GridViewTestPage5"];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "GridViewDemoListsPage",
      dataArr: titleData,
      callBack: (index, str) {
        print(index);
        JhNavUtils.pushNamed(context, routeData[index]);
//          JhNavUtils.pushNamed(context, "GirdViewTest1");
      },
    );
  }
}
