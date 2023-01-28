// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/jh_common/jh_form/jh_count_down_btn.dart';
import '/jh_common/jh_form/jh_login_text_field.dart';
import '/jh_common/widgets/jh_button.dart';
import '/base_appbar.dart';

class LoginTextFieldTestPage extends StatefulWidget {
  const LoginTextFieldTestPage({Key? key}) : super(key: key);

  @override
  State<LoginTextFieldTestPage> createState() => _LoginTextFieldTestPageState();
}

class _LoginTextFieldTestPageState extends State<LoginTextFieldTestPage> {
  var _name = '';
  var _pwd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhLoginTextField'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: <Widget>[
        const JhLoginTextField(
          text: 'text赋初值',
          hintText: '请输入',
        ),
        const JhLoginTextField(
          hintText: '输入时不显示删除按钮',
        ),
        const JhLoginTextField(
          hintText: '输入时显示删除按钮',
          isShowDeleteBtn: true,
        ),
        const JhLoginTextField(
          hintText: '密码样式(右侧默认图片)',
          isShowDeleteBtn: true,
          isPwd: true,
        ),
        const JhLoginTextField(hintText: '默认只限制长度20', isShowDeleteBtn: true),
        JhLoginTextField(
          hintText: '自定义inputFormatters 长度5，a-zA-Z0-9',
          isShowDeleteBtn: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            LengthLimitingTextInputFormatter(5)
          ],
        ),
        JhLoginTextField(
          hintText: '限制 长度5，0-9，phone键盘',
          isShowDeleteBtn: true,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')), LengthLimitingTextInputFormatter(5)],
        ),
        const JhLoginTextField(hintText: '左侧添加按钮', leftWidget: Icon(Icons.perm_identity)),
        JhLoginTextField(
          hintText: '左侧自定义',
          leftWidget: Container(color: Colors.yellow, width: 50),
        ),
        JhLoginTextField(hintText: '右侧自定义', rightWidget: Container(color: Colors.yellow, width: 100, height: 45)),
        Container(
          padding: const EdgeInsets.all(20),
          child: JhLoginTextField(
            text: _name,
            hintText: '请输入用户名',
            labelText: '用户名',
            leftWidget: const Icon(Icons.person),
            isShowDeleteBtn: true,
            isDense: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
        ),
        const JhLoginTextField(
          hintText: '请输入手机号',
          leftWidget: SizedBox(width: 50, child: Center(child: Text('+86'))),
          keyboardType: TextInputType.phone,
        ),
        JhLoginTextField(
            text: _name,
            hintText: '请输入用户名',
            labelText: '用户名',
            leftWidget: const Icon(Icons.person),
            isShowDeleteBtn: true,
            inputCallBack: (value) => _name = value),
        JhLoginTextField(
          text: _pwd,
          hintText: '请输入密码(添加右侧密码图片)',
          leftWidget: const Icon(Icons.lock),
          isShowDeleteBtn: true,
          isPwd: true,
          pwdClose: 'assets/images/ic_pwd_close.png',
          pwdOpen: 'assets/images/ic_pwd_open.png',
          inputCallBack: (value) => _pwd = value,
        ),
        JhLoginTextField(
          hintText: '验证码',
          maxLength: 6,
          keyboardType: TextInputType.number,
          rightWidget: JhCountDownBtn(
            showBorder: true,
            getVCode: () async {
              return true;
            },
          ),
        ),
        const SizedBox(height: 10),
        JhButton(text: '登 录', onPressed: () => _clickOkBtn(context)),
        const SizedBox(height: 50),
      ],
    );
  }

  void _clickOkBtn(context) {
    print('name =$_name');
    print('pwd =$_pwd');
  }
}
