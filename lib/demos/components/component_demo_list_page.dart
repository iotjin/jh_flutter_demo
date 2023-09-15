import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  '水平滑动菜单',
  'Tags标签',
];
final List routeData = [
  'SlideMenuTestPage',
  'TagViewTestPage',
];

class ComponentDemoListPage extends StatelessWidget {
  const ComponentDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '功能组件',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
