import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class UIDemoListsPage extends StatelessWidget {
  final List titleData = ["UI", "UI2", "Scroll"];
  final List routeData = ["UIPage", "UIPage2", "ScrollPage"];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "UITest",
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
