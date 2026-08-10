import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'signature 签字',
  'hand_signature 签字',
];
final List routeData = [
  'SignatureTestPage',
  'HandSignatureTestPage',
];

class SignatureDemoListPage extends StatelessWidget {
  const SignatureDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '签名',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
