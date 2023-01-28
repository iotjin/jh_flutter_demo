// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/jh_common/jh_form/jh_form_input_cell.dart';
import '/base_appbar.dart';

class FormInputCellTestPage extends StatefulWidget {
  const FormInputCellTestPage({Key? key}) : super(key: key);

  @override
  State<FormInputCellTestPage> createState() => _FormInputCellTestPageState();
}

class _FormInputCellTestPageState extends State<FormInputCellTestPage> {
  bool _switchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhFormInputCell'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.only(top: 15),
      children: <Widget>[
        JhFormInputCell(
          hintText: '默认样式，不设置左标题',
          inputCallBack: (value) {
            print(value);
          },
          inputCompletionCallBack: (value, isSubmitted) {
            print('inputCompletionCallBack: $value / $isSubmitted ');
          },
        ),
        JhFormInputCell(
          hintText: '请输入',
          labelText: '顶部文字',
          inputCallBack: (value) {
            print(value);
          },
        ),
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
          titleStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
          ),
        ),
        const JhFormInputCell(
          title: '左标题',
          text: '红色文字',
          textStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
          ),
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
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')), LengthLimitingTextInputFormatter(5)],
        ),
        JhFormInputCell(
          title: '左标题',
          hintText: '自定义inputFormatters 长度10，a-zA-Z0-9',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            LengthLimitingTextInputFormatter(10)
          ],
        ),
        JhFormInputCell(
          hintText: '左侧自定义，maxLength=15',
          leftWidget: Container(color: Colors.yellow, width: 92, height: 45),
          maxLength: 15,
        ),
        JhFormInputCell(
          title: '左标题',
          hintText: '右侧自定义',
          rightWidget: Container(color: Colors.yellow, width: 150, height: 45),
          maxLength: 15,
        ),
        JhFormInputCell(
          title: '左标题',
          hintText: '',
          enabled: false,
          rightWidget: CupertinoSwitch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        JhFormInputCell(
          title: '左标题',
          hintText: '',
          enabled: false,
          rightWidget: Checkbox(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value!;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        const JhFormInputCell(
          title: '左标题',
          hintText: '设置边框,隐藏底部线',
          hiddenLine: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.none),
          ),
        ),
        const SizedBox(height: 10),
        const JhFormInputCell(
          title: '左标题',
          hintText: '设置maxLines=5，设置边框，显示红星和最大长度，title顶部对齐',
          maxLines: 5,
          maxLength: 50,
          showMaxLength: true,
          hiddenLine: true,
          showRedStar: true,
          topAlign: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.none),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
