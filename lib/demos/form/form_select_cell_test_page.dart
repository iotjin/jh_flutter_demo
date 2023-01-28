// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_form_select_cell.dart';
import '/base_appbar.dart';

class FormSelectCellTestPage extends StatefulWidget {
  const FormSelectCellTestPage({Key? key}) : super(key: key);

  @override
  State<FormSelectCellTestPage> createState() => _FormSelectCellTestPageState();
}

class _FormSelectCellTestPageState extends State<FormSelectCellTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhFormSelectCell'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.only(top: 15),
      children: <Widget>[
        JhFormSelectCell(clickCallBack: () {
          print('点击cell');
        }),
        const JhFormSelectCell(labelText: '请选择', text: 'text赋初值'),
        const JhFormSelectCell(title: '左标题'),
        const JhFormSelectCell(title: '左标题', text: 'text赋初值'),
        const JhFormSelectCell(
          title: '左标题',
          hintText: '标题加红星',
          showRedStar: true,
        ),
        const JhFormSelectCell(
          title: '左标题',
          hintText: '红色标题',
          titleStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhFormSelectCell(
          title: '左标题',
          text: '红色文字',
          textStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhFormSelectCell(
          title: '左标题',
          text: 'text靠右',
          textAlign: TextAlign.right,
        ),
        JhFormSelectCell(
          hintText: '左侧自定义',
          leftWidget: Container(
            color: Colors.yellow,
            width: 92,
            height: 45,
          ),
        ),
        JhFormSelectCell(
          title: '左标题',
          hintText: '右侧自定义',
          rightWidget: Container(
            color: Colors.yellow,
            width: 150,
            height: 45,
          ),
        ),
        JhFormSelectCell(
          title: '左标题',
          hintText: '隐藏箭头',
          rightWidget: Container(
            color: Colors.yellow,
            width: 168,
            height: 42,
          ),
          hiddenArrow: true,
        ),
        const SizedBox(height: 10),
        const JhFormSelectCell(
          title: '左标题',
          hintText: '设置边框,隐藏底部线',
          hiddenLine: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.none),
          ),
        ),
        const SizedBox(height: 10),
        const JhFormSelectCell(
          title: '左标题',
          hintText: '设置边框，显示红星，title顶部对齐',
          hiddenLine: true,
          showRedStar: true,
          topAlign: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.none),
          ),
        ),
      ],
    );
  }
}
