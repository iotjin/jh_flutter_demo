import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_tag_view.dart';
import '/project/configs/project_config.dart';

class TagViewTestPage extends StatefulWidget {
  const TagViewTestPage({Key? key}) : super(key: key);

  @override
  State<TagViewTestPage> createState() => _TagViewTestPageState();
}

class _TagViewTestPageState extends State<TagViewTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhTagView'),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  _body() {
    return ListView(children: const [
      Column(children: [
        JhTagView(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        SuccessTag(text: 'success'),
        ErrorTag(text: 'error'),
        WarningTag(text: 'warning'),
        SuccessTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        ErrorTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        WarningTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        Row(
          children: [
            Text('Left'),
            SizedBox(width: 10),
            Expanded(
                child: JhTagView(
                    textList: ['123456789123456789123456789123456789123456789123456789', '111', '22', '333'])),
            SizedBox(width: 10),
            Text('Right'),
          ],
        ),
      ])
    ]);
  }
}
