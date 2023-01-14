import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = ['搜索框1', '搜索框2', '搜索框3', '搜索框4'];
final List routeData = ['SearchTest1Page', 'SearchTest2Page', 'SearchTest3Page', 'SearchTest4Page'];

class SearchDemoListPage extends StatelessWidget {
  const SearchDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '搜索框',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
