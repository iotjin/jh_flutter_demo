import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'JhLoginTextField',
  'JhTextField',
  'JhFormInputCell',
  'JhFormSelectCell',
  'JhSetCell',
  'FormTestPage',
  'FormValidatePage'
];
final List routeData = [
  'LoginTextFieldTestPage',
  'InputTextFieldTestPage',
  'FormInputCellTestPage',
  'FormSelectCellTestPage',
  'SetCellTestPage',
  'FormTestPage',
  'FormValidatePage'
];

class FormDemoListPage extends StatelessWidget {
  const FormDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'JhForm',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
