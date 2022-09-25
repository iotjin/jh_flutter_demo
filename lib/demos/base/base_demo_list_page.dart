import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class BaseDemoListPage extends StatelessWidget {
  final List titleData = [
    'BaseListView',
    'BaseGridView',
    '空数据',
    'BaseAppBar(导航条)',
  ];
  final List routeData = [
    'BaseListViewTestPage',
    'BaseListViewTestPage',
    'EmptyDemoListPage',
    'NavTestPage',
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'Base',
      dataArr: titleData,
      callBack: (index, str) {
        if (index == 0 || index == 1) {
          var jumpParams = {'isGridView': index == 1 ? true : false};
          JhNavUtils.pushNamed(context, routeData[index], arguments: jumpParams);
        } else {
          JhNavUtils.pushNamed(context, routeData[index]);
        }
      },
    );
  }
}
