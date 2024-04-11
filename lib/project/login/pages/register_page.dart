// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/configs/project_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();
  final FocusNode _node3 = FocusNode();

  var _phone = '';
  var _code = '';
  var _pwd = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(IntlKeys.registerTitle.tr),
      body: KeyboardActions(
        config: JhKeyboardUtils.getKeyboardConfig(context, [_node1, _node2, _node3]),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                JhLoginTextField(
                  text: _phone,
                  hintText: IntlKeys.loginHintPhone.tr,
                  labelText: IntlKeys.loginPhoneText.tr,
                  focusNode: _node1,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  inputCallBack: (value) => _phone = value,
                ),
                const SizedBox(height: 10),
                JhLoginTextField(
                  text: _code,
                  hintText: IntlKeys.loginHintCode.tr,
                  labelText: IntlKeys.loginCodeText.tr,
                  focusNode: _node2,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  rightWidget: JhCountDownBtn(
                    getCodeText: IntlKeys.loginGetCode.tr,
                    resendAfterText: IntlKeys.codeResendAfter.tr,
                    showBorder: true,
                    getVCode: () async {
                      return true;
                    },
                  ),
                  controller: _codeController,
                  inputCallBack: (value) => _code = value,
                ),
                const SizedBox(height: 10),
                JhLoginTextField(
                  text: _pwd,
                  hintText: IntlKeys.loginHintPwd.tr,
                  labelText: IntlKeys.loginPwdText.tr,
                  focusNode: _node3,
                  isShowDeleteBtn: true,
                  isPwd: true,
                  pwdClose: 'assets/images/ic_pwd_close.png',
                  pwdOpen: 'assets/images/ic_pwd_open.png',
                  controller: _pwdController,
                  inputCallBack: (value) => _pwd = value,
                ),
                const SizedBox(height: 65),
                JhButton(text: IntlKeys.registerBtn.tr, onPressed: _clickOkBtn),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: KColors.dynamicColor(context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor),
                    ),
                    children: <InlineSpan>[
                      TextSpan(text: IntlKeys.registerAgreement1.tr),
                      TextSpan(
                        text: IntlKeys.registerAgreement2.tr,
                        style: const TextStyle(color: Colors.red),
                        recognizer: TapGestureRecognizer()..onTap = () => _clickAgreement(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _clickOkBtn() async {
//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, 'BaseTabBar');

    // var hide = JhToast.showIOSLoadingText(context, msg: '正在注册...');
    var hide = JhToast.showIOSLoadingText(context, msg: IntlKeys.registerLoading.tr);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      hide();
    });
  }

  _clickAgreement() {
    print('Tap Here onTap');
    JhToast.showText(context, msg: IntlKeys.registerMsgAgreement.tr);
  }
}
