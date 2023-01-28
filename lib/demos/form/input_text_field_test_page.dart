import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/jh_common/jh_form/jh_text_field.dart';
import '/base_appbar.dart';

class InputTextFieldTestPage extends StatefulWidget {
  const InputTextFieldTestPage({Key? key}) : super(key: key);

  @override
  State<InputTextFieldTestPage> createState() => _InputTextFieldTestPageState();
}

class _InputTextFieldTestPageState extends State<InputTextFieldTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhTextField'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: <Widget>[
        const JhTextField(
          hintText: '默认样式，没有边框',
        ),
        const SizedBox(height: 10),
        const JhTextField(
          text: 'text赋初值,不可编辑',
          enabled: false,
        ),
        const SizedBox(height: 10),
        JhTextField(
          hintText: '限制 长度5，0-9，phone键盘',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')), LengthLimitingTextInputFormatter(5)],
        ),
        const SizedBox(height: 10),
        JhTextField(
          hintText: '自定义inputFormatters 长度10，a-zA-Z0-9',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            LengthLimitingTextInputFormatter(10)
          ],
        ),
        const SizedBox(height: 10),
        JhTextField(
          hintText: '左侧自定义，maxLength=15',
          leftWidget: Container(color: Colors.yellow, width: 100),
          maxLength: 15,
        ),
        const SizedBox(height: 10),
        JhTextField(
          hintText: '右侧自定义，maxLength=15',
          rightWidget: Container(color: Colors.yellow, width: 100),
          maxLength: 15,
        ),
        const SizedBox(height: 10),
        const JhTextField(
          hintText: '设置maxLines=5，设置边框',
          maxLines: 5,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const JhTextField(
          hintText: '默认1行，自动换行，最多5行，100字符',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.none),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
      ],
    );
  }
}
