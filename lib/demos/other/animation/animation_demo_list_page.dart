import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

class AnimationDemoListPage extends StatelessWidget {
  final List titleData = ['3D球', '3D球2', '3D球 - 文字', '3D球 - 封装', '3D球 - 圆形阴影'];
  final List routeData = [
    'DBallPage',
    'DBallPage2',
    'DBallPage3',
    'TagCloudPage',
    'DBallPage4',
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "Animation",
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
