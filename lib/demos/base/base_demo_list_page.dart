import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class BaseDemoListPage extends StatelessWidget {
  final List titleData = [
    'BaseListView',
    'BaseGridView',
    'BaseListView - 骨架屏',
    'BaseGridView - 骨架屏',
    'BaseRefreshView - header/footer固定',
    'BaseRefreshView - header/footer跟随',
    'BaseAppBar(导航条)',
    'JhEmptyView(空数据)',
  ];
  final List routeData = [
    'BaseRefreshViewTestPage',
    'BaseRefreshViewTestPage',
    'BaseListViewShimmerTestPage',
    'BaseGridViewShimmerTestPage',
    'BaseRefreshViewHeaderFixedPage',
    'BaseRefreshViewHeaderFollowPage',
    'NavTestPage',
    'EmptyDemoListPage',
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
