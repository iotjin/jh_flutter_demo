import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_status_bar_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/configs/project_config.dart';
import '/project/routes/routes.dart';
import '/data/data_utils.dart';

/*
   keyboardType: TextInputType.numberWithOptions(decimal: true),// 设置键盘为可录入小数的数字
   inputFormatters: [FilteringTextInputFormatter.allow.digitsOnly],// 设置只能录入数字[0-9]

   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),// 只允许输入字母
   FilteringTextInputFormatter.allow.digitsOnly],// 只允许输入数字
   FilteringTextInputFormatter.allow(RegExp('[0-9.]')),// 只允许输入小数
   BlacklistingTextInputFormatter(RegExp('[abFeG])), // 黑名单

   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')) ,
   LengthLimitingTextInputFormatter(20)
*/

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _name = 'jin';
  var _pwd = '';

  bool _isClick = false;

  Color? logoColor;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    super.initState();

    logoColor = JhColorUtils.randomColor();
    if (JhDeviceUtils.isIOS) {
//      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//        statusBarColor: Colors.red,
//      );
//      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 3) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    // 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _node1.unfocus();
    _node2.unfocus();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: JhStatusBarUtils.getBlackStatusBarStyle(context.jhIsDark),
      child: Scaffold(
        body: KeyboardActions(
          config: JhKeyboardUtils.getKeyboardConfig(context, [_node1, _node2]),
          child: _body(),
        ),
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
              children: <Widget>[
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Text('注册', style: TextStyle(fontSize: 18)),
                      onTap: () => JhNavUtils.pushNamed(context, 'RegisterPage'),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: logoColor, borderRadius: BorderRadius.circular(50)),
                  child: const Center(child: Text('Logo', style: TextStyle(fontSize: 20, color: Colors.white))),
                ),
                const SizedBox(height: 30),
                JhLoginTextField(
                  text: _name,
                  hintText: '请输入用户名',
                  focusNode: _node1,
                  leftWidget: const Icon(Icons.person),
                  isShowDeleteBtn: true,
                  controller: _nameController,
                  inputCallBack: (value) => _name = value,
                ),
                const SizedBox(height: 10),
                JhLoginTextField(
                  text: _pwd,
                  hintText: '请输入密码',
                  focusNode: _node2,
                  leftWidget: const Icon(Icons.lock),
                  isShowDeleteBtn: true,
                  isPwd: true,
                  controller: _passwordController,
                  pwdClose: 'assets/images/ic_pwd_close.png',
                  pwdOpen: 'assets/images/ic_pwd_open.png',
                  inputCallBack: (value) => _pwd = value,
                ),
                const SizedBox(height: 50),
                JhButton(text: '登 录', onPressed: _isClick ? _clickOkBtn : null),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      child: GestureDetector(
                        child: const Text('验证码登录'),
                        onTap: () => JhNavUtils.pushNamed(context, 'CodeLoginPage'),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: GestureDetector(
                        child: const Text('忘记密码'),
                        onTap: () => JhNavUtils.pushNamed(context, 'FindPwdPage'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _clickOkBtn() async {
    var hide = JhToast.showIOSLoadingText(
      context,
      msg: '正在登录...',
    );

    var params = {'userName': _name, 'pwd': _pwd};
    // 登录请求
    DataUtils.login(params, success: (res) {
      hide();
      // 保存本地
      JhAESStorageUtils.saveModel(kUserDefault_UserInfo, res['data']);
      JhToast.showSuccess(context, msg: res['msg']);
      JhNavUtils.pushReplacement(context, Routes.pHome);
    }, fail: (code, msg) {
      hide();
    });
  }

// void _clickOkBtn() async {
//   var params = {'userName': _name, 'pwd': _pwd};
//   // 登录请求
//   HttpUtils.post(APIs.login, params, loadingText: '正在登录...', success: (res) {
//     JhProgressHUD.showSuccess(res['msg']);
//     // 保存本地
//     JhAESStorageUtils.saveModel(kUserDefault_UserInfo, res['data']);
//     JhToast.showSuccess(context, msg: res['msg']);
//     JhNavUtils.pushReplacement(context, Routes.pHome);
//   }, fail: (code, msg) {});
// }
}
