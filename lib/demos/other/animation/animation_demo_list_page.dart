import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = ['抖动动画', '3D球', '3D球2', '3D球 - 文字', '3D球 - 封装', '3D球 - 圆形阴影'];
final List routeData = ['AnimationTestPage', 'Ball3DPage', 'Ball3DPage2', 'Ball3DPage3', 'TagCloudPage', 'Ball3DPage4'];

class AnimationDemoListPage extends StatelessWidget {
  const AnimationDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'Animation',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
