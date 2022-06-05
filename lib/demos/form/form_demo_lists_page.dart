import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/jh_nav_fluro_utils.dart';

class FormDemoListsPage extends StatelessWidget {
  final List titleData = [
    "JhLoginTextField",
    "JhTextField",
    "JhFormInputCell",
    "JhFormSelectCell",
    "JhSetCell",
    'FormTestPage'
  ];
  final List routeData = [
    "LoginTextFieldTestPage",
    "InputTextFieldTestPage",
    "FormInputCellTestPage",
    "FormSelectCellTestPage",
    "SetCellTestPage",
    'FormTestPage'
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "JhForm",
      dataArr: titleData,
      callBack: (index, str) {
        print(index);
        JhNavFluroUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
