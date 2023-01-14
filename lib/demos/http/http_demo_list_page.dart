import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'dio使用',
  '分页加载数据',
  '分页加载数据 - header/footer跟随',
];
final List routeData = ['HttpTest1Page', 'HttpPageTestPage', 'HttpPageTestHeaderFollowPage'];

class HttpDemoListPage extends StatelessWidget {
  const HttpDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'HttpDemoList',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
