import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/jh_common/jh_form/jh_form_input_cell.dart';
import '/jh_common/jh_form/jh_form_select_cell.dart';
import '/base_appbar.dart';

class FormTestPage extends StatefulWidget {
  const FormTestPage({Key? key}) : super(key: key);

  @override
  State<FormTestPage> createState() => _FormTestPageState();
}

class _FormTestPageState extends State<FormTestPage> {
  // bool _switchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('FormTest'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: <Widget>[
        const JhFormInputCell(
          title: '左标题',
          hintText: '默认1行,最多5行,100字符,标题垂直居中',
        ),
        const JhFormInputCell(title: '左标题', text: 'text赋初值,不可编辑', enabled: false),
        const JhFormInputCell(
          title: '左标题',
          hintText: '标题加红星',
          showRedStar: true,
        ),
        const JhFormInputCell(
          title: '左标题',
          hintText: '红色标题',
          titleStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhFormInputCell(
          title: '左标题',
          text: '红色文字',
          textStyle: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        const JhFormInputCell(
          title: '左标题',
          text: 'text靠右',
          textAlign: TextAlign.right,
        ),
        JhFormInputCell(
            title: '左标题',
            hintText: '限制 长度5，0-9，phone键盘',
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')), LengthLimitingTextInputFormatter(5)]),
        JhFormInputCell(title: '左标题', hintText: '自定义inputFormatters 长度10，a-zA-Z0-9', inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
          LengthLimitingTextInputFormatter(10)
        ]),
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
          titleStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
          ),
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
          title: '左标题',
          hintText: '隐藏箭头',
          rightWidget: Container(
            color: Colors.yellow,
            width: 168,
            height: 42,
          ),
          hiddenArrow: true,
        ),
      ],
    );
  }
}
