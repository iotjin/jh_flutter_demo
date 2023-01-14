import 'package:flutter/material.dart';
import '/base_appbar.dart';
import '/jh_common/widgets/tag_cloud_widget.dart';

var _data = [
  {'ID': '111', 'name': '1.这是文字', 'num': '11'},
  {'ID': '222', 'name': '2.这是文', 'num': '22'},
  {'ID': '333', 'name': '3.这是文字文字', 'num': '33'},
  {'ID': '444', 'name': '4.这是文字', 'num': '44'},
  {'ID': '555', 'name': '5.这是文字', 'num': '55'},
  {'ID': '666', 'name': '6.这是', 'num': '66'},
  {'ID': '777', 'name': '7.这是文字', 'num': '77'},
  {'ID': '888', 'name': '8.这是文字', 'num': '88'},
];

class TagCloudPage extends StatefulWidget {
  const TagCloudPage({Key? key}) : super(key: key);

  @override
  State<TagCloudPage> createState() => _TagCloudPageState();
}

class _TagCloudPageState extends State<TagCloudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('TagCloudWidget'),
      // backgroundColor: Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TagCloudWidget(constraints.maxWidth - 40 * 2, _data, rpm: 4);
          },
        ),
      ),
    );
  }
}
