// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/base_appbar.dart';

class SetCellTestPage extends StatefulWidget {
  const SetCellTestPage({Key? key}) : super(key: key);

  @override
  State<SetCellTestPage> createState() => _SetCellTestPageState();
}

class _SetCellTestPageState extends State<SetCellTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhSetCell'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.only(top: 15),
      children: <Widget>[
        JhSetCell(
          title: '左标题',
          text: '右侧文字',
          clickCallBack: () {
            print('点击cell');
          },
        ),
        const JhSetCell(
          title: '左标题左标题',
          text: '右侧文字',
        ),
        const JhSetCell(
          title: '左标题左标题左标题',
          text: '右侧文字',
          titleWidth: 150,
        ),
        const JhSetCell(leftImgPath: 'assets/images/shezhi.png', title: '设置', text: '右侧文字'),
        const JhSetCell(
          leftImgPath: 'assets/images/shezhi.png',
          title: '关于',
          text: '有新版本',
          textStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhSetCell(
          leftImgPath: 'assets/images/shezhi.png',
          title: '左侧文字红色',
          titleStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhSetCell(
          title: '左标题',
          text: '隐藏箭头',
          hiddenArrow: true,
        ),
        JhSetCell(
          title: '左标题',
          text: '左侧自定义',
          leftWidget: Container(color: Colors.yellow, width: 35, height: 35),
        ),
        JhSetCell(
          title: '左标题',
          text: '右侧自定义',
          rightWidget: Container(color: Colors.yellow, width: 150, height: 45),
        ),
        const SizedBox(height: 5),
        const JhSetCell(
          leftImgPath: 'assets/images/shezhi.png',
          title: '左标题',
          text: '隐藏底部线',
          hiddenLine: true,
        ),
        const SizedBox(height: 5),
        const JhSetCell(
          leftImgPath: 'assets/images/shezhi.png',
          title: '左标题',
          text: '隐藏底部线',
          hiddenLine: true,
        ),
      ],
    );
  }
}
