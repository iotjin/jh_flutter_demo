// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_button.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_picker_tool.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/base_appbar.dart';

class FormValidatePage extends StatefulWidget {
  const FormValidatePage({Key? key}) : super(key: key);

  @override
  State<FormValidatePage> createState() => _FormValidatePageState();
}

class _FormValidatePageState extends State<FormValidatePage> {
  Map params = {
    'isSelected': false,
    'isSelected2': false,
  };

  final dictArr = [
    {'label': '类型一', 'value': '1'},
    {'label': '类型二', 'value': '2'},
    {'label': '类型三', 'value': '3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('FormValidatePage'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: <Widget>[
        JhFormInputCell(
          title: '手机号',
          text: params['phone'],
          hintText: '请输入手机号(11位)',
          showRedStar: true,
          keyboardType: TextInputType.phone,
          inputFormatters: phone,
          inputCallBack: (value) => params['phone'] = value,
          inputCompletionCallBack: (value, isSubmitted) {
            print('inputCompletionCallBack: $value / $isSubmitted ');
          },
        ),
        JhFormInputCell(
          title: '手机号',
          text: params['phone2'],
          hintText: '请输入手机号(11位)',
          keyboardType: TextInputType.phone,
          inputFormatters: phone,
          inputCallBack: (value) => params['phone2'] = value,
        ),
        JhFormInputCell(
          title: '密码',
          text: params['pwd'],
          hintText: '请输入密码(16位)',
          showRedStar: true,
          keyboardType: TextInputType.visiblePassword,
          inputFormatters: pwd,
          inputCallBack: (value) => params['pwd'] = value,
        ),
        JhFormInputCell(
          title: '密码',
          text: params['pwd2'],
          hintText: '请输入密码(16位)',
          keyboardType: TextInputType.visiblePassword,
          inputFormatters: pwd,
          inputCallBack: (value) => params['pwd2'] = value,
        ),
        JhFormInputCell(
          title: '验证码',
          text: params['code'],
          hintText: '请输入验证码',
          showRedStar: true,
          keyboardType: TextInputType.number,
          inputFormatters: code,
          inputCallBack: (value) => params['code'] = value,
        ),
        JhFormInputCell(
          title: '验证码',
          text: params['code2'],
          hintText: '请输入验证码',
          keyboardType: TextInputType.number,
          inputFormatters: code,
          inputCallBack: (value) => params['code2'] = value,
        ),
        JhFormInputCell(
          title: '数字',
          text: params['num'],
          hintText: '请输入数字(8位)',
          showRedStar: true,
          keyboardType: TextInputType.number,
          inputFormatters: [length8, number],
          inputCallBack: (value) => params['num'] = value,
        ),
        JhFormInputCell(
          title: '数字',
          text: params['num2'],
          hintText: '请输入数字(8位)',
          keyboardType: TextInputType.number,
          inputFormatters: [length8, number],
          inputCallBack: (value) => params['num2'] = value,
        ),
        JhFormInputCell(
          title: '金额',
          text: params['money'],
          hintText: '请输入金额(整数不限，小数2位)',
          showRedStar: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [twoDecimal],
          inputCallBack: (value) => params['money'] = value,
        ),
        JhFormInputCell(
          title: '金额',
          text: params['money2'],
          hintText: '请输入金额(10位整数，小数2位)',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [money],
          inputCallBack: (value) => params['money2'] = value,
        ),
        JhFormInputCell(
          title: '英文名',
          text: params['letter'],
          hintText: '请输入英文名(8位)',
          showRedStar: true,
          inputFormatters: [length8, letter],
          inputCallBack: (value) => params['letter'] = value,
        ),
        JhFormInputCell(
          title: '英文名',
          text: params['letter2'],
          hintText: '请输入英文名(8位)',
          inputFormatters: [length8, letter],
          inputCallBack: (value) => params['letter2'] = value,
        ),
        JhFormInputCell(
          title: '中文名',
          text: params['chinese'],
          hintText: '请输入中文名(5位)',
          showRedStar: true,
          inputFormatters: [length5, chinese],
          inputCallBack: (value) => params['chinese'] = value,
        ),
        JhFormInputCell(
          title: '中文名',
          text: params['chinese2'],
          hintText: '请输入中文名(5位)',
          inputFormatters: [length5, chinese],
          inputCallBack: (value) => params['chinese2'] = value,
        ),
        JhFormSelectCell(
          title: '类型',
          text: params['type'],
          hintText: '请选择类型',
          showRedStar: true,
          clickCallBack: () {
            JhPickerTool.showStringPicker(context, data: dictArr, title: '请选择类型', labelKey: 'label', selectIndex: 2,
                clickCallBack: (selectValue, selectIndex) {
              setState(() {
                params['type'] = selectValue['label'];
              });
            });
          },
        ),
        JhFormSelectCell(
          title: '类型',
          text: params['type2'],
          hintText: '请选择类型',
          // textAlign: TextAlign.right,
          clickCallBack: () {
            JhPickerTool.showStringPicker(context, data: dictArr, title: '请选择类型', labelKey: 'label', selectIndex: 2,
                clickCallBack: (selectValue, selectIndex) {
              setState(() {
                params['type2'] = selectValue['label'];
              });
            });
          },
        ),
        JhFormInputCell(
          title: '协议',
          hintText: '',
          enabled: false,
          showRedStar: true,
          rightWidget: Checkbox(
            value: params['isSelected'],
            onChanged: (value) {
              setState(() {
                params['isSelected'] = value;
              });
            },
          ),
        ),
        JhFormInputCell(
          title: '协议2',
          hintText: '',
          enabled: false,
          rightWidget: CupertinoSwitch(
            value: params['isSelected2'],
            onChanged: (value) {
              setState(() {
                params['isSelected2'] = value;
              });
            },
          ),
        ),
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: JhButton(
            text: '提交',
            onPressed: () => _onClickSubmit(),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  _onClickSubmit() {
    print('params: ${params.toString()}');

    var rules = {
      'phone': [
        {'require': true, 'message': '请输入手机号码'},
        {'pattern': regularIsPhone, 'message': '请输入正确的手机号码'},
      ],
      'pwd': [
        {'require': true, 'message': '请输入密码'},
        {'minLength': 6, 'message': '密码长度最低6位数'},
      ],
      'code': [
        {'require': true, 'message': '请输入验证码'},
        {'maxLength': 6, 'message': '验证码长度最多6位数'}
      ],
      'num': [
        {'require': true, 'message': '请输入数字'},
        {'maxLength': 8, 'message': '数字长度最多8位数'}
      ],
      'money': [
        {'require': true, 'message': '请输入金额'},
      ],
      'letter': [
        {'require': true, 'message': '请输入英文名'},
        {'maxLength': 8, 'message': '英文名长度最多8位数'},
      ],
      'chinese': [
        {'require': true, 'message': '请输入中文名'},
        {'maxLength': 8, 'message': '中文名长度最多8位数'},
      ],
      'type': [
        {'require': true, 'message': '请选择类型'},
      ],
      'isSelected': [
        {'require': true, 'message': '请勾选协议'},
      ]
    };
    var validate = JhValidate(rules, params);
    var message = validate.check();
    print(message);
    if (message != null) {
      JhProgressHUD.showText(message);
    } else {
      print('校验成功，提交数据');
      JhProgressHUD.showSuccess('校验成功，提交数据');
    }
  }
}
