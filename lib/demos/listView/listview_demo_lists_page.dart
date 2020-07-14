import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class ListViewDemoListsPage extends StatelessWidget {
  final List titleData = [
    "ListViewTest",
    "ListViewTest2",
    "ListViewTest3",
    "ListViewTest4",
    "ListViewTest5",
    "ListViewTest_Card",
    "ListViewTest_CustomVC",
    "ListViewTest_SimplePullDown",
    "ListViewTest_PullDownVC",
    "ListViewGroupPage",
    "ListViewGroupPage2",
  ];
  final List routeData = [
    "ListViewTest",
    "ListViewTest2",
    "ListViewTest3",
    "ListViewTest4",
    "ListViewTest5",
    "ListViewTest_Card",
    "ListViewTest_CustomVC",
    "ListViewTest_SimplePullDown",
    "ListViewTest_PullDownVC",
    "ListViewGroupPage",
    "ListViewGroupPage2",
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "ListViewDemoLists",
      dataArr: titleData,
      callBack: (index, str) {
        print(routeData[index]);
        NavigatorUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
