import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_flutter_demo/http/apis.dart';

import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:flui/src/widgets/avatar.dart';
import 'package:flustars/flustars.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';

import 'package:jh_flutter_demo/jh_common/utils/jh_storage_utils.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_color_utils.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_button.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_form.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';

import 'package:jh_flutter_demo/project/base_tabbar.dart';
import 'package:jh_flutter_demo/project/model/user_model.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';
import 'package:jh_flutter_demo/http/http_utils.dart';

/*
*        keyboardType: TextInputType.numberWithOptions(decimal: true),//设置键盘为可录入小数的数字
         inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//设置只能录入数字[0-9]

         WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),//只允许输入字母
         WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
         WhitelistingTextInputFormatter(RegExp("[0-9.]")),//只允许输入小数
         BlacklistingTextInputFormatter(RegExp("[abFeG])), //黑名单

         WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")) ,
         LengthLimitingTextInputFormatter(20)



* */
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _name = 'jin';
  var _pwd = '';

  bool _isClick = false;

  Color logoColor;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    super.initState();

    logoColor = JhColorUtils.randomColor();
    if (Platform.isIOS) {
//      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//        statusBarColor: Colors.red,
//      );
//      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);

    _getInfo();
  }

  void _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    print('版本号：${packageInfo.version}');
    JhStorageUtils.saveString(kUserDefault_LastVersion, packageInfo.version);
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

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("login dispose");
    _node1.unfocus();
    _node2.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: KeyboardActions(
      config: jhForm.getKeyboardConfig(context, [_node1, _node2]),
      child: _mainBody(),
    ));
  }

  Widget _mainBody() {
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
                        child: Text("注册", style: TextStyle(fontSize: 18)),
                        onTap: () {
                          NavigatorUtils.pushNamed(context, "RegisterPage");
                        },
                      )),
                ),

                SizedBox(height: 50),
//                  Image.asset("assets/images/lufei.png",width: 100,),

                FLAvatar(
//                  color: Colors.blue,
                  color: logoColor,
                  width: 100,
                  height: 100,
//                    radius: 0,
                  text: 'Logo',
                  textStyle: TextStyle(fontSize: 20, color: Colors.white),
                ),

                SizedBox(height: 30),
                JhLoginTextField(
                    text: _name,
                    hintText: "请输入用户名",
                    focusNode: _node1,
                    leftWidget: Icon(Icons.person),
                    isShowDeleteBtn: true,
                    controller: _nameController,
                    inputCallBack: (value) => _name = value),
                SizedBox(height: 10),

                JhLoginTextField(
                    hintText: "请输入密码",
                    focusNode: _node2,
                    leftWidget: Icon(Icons.lock),
                    isShowDeleteBtn: true,
                    isPwd: true,
                    controller: _passwordController,
                    pwdClose: 'assets/images/ic_pwd_close.png',
                    pwdOpen: 'assets/images/ic_pwd_open.png',
                    inputCallBack: (value) => _pwd = value),
                SizedBox(height: 50),
                JhButton(
                  text: "登 录",
                  onPressed: _isClick ? _ClickOkBtn : null,
                ),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                          child: Text(
                            '验证码登录',
                          ),
                          onTap: () => NavigatorUtils.pushNamed(
                              context, "CodeLoginPage")),
                    ),
                    Container(
                      height: 50.0,
//                        alignment: Alignment.centerRight,
                      child: GestureDetector(
                          child: Text(
                            '忘记密码',
                          ),
                          onTap: () =>
                              NavigatorUtils.pushNamed(context, "FindPwdPage")),
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

  void _ClickOkBtn() async {
//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, "BaseTabBar");

//    print('name =$_name');
//    print('pwd =$_pwd');
//    var hide =  JhToast.showIOSLoadingText(context,
//      msg:"正在登录...",
//    );
//    Future.delayed(Duration(seconds: 1),(){
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (context) => (BaseTabBar()
//      )));
//      hide();
//    });

    //请求网络登录
    print('name =$_name');
    print('pwd =$_pwd');

    var hide = JhToast.showIOSLoadingText(
      context,
      msg: "正在登录...",
    );

//    var url =
//        "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root/login";
//    var dio = new Dio();
//    var response = await dio.post(url, data: {"userName": _name, "pwd": _pwd});
//    var result = response.data.toString();
//    print("返回数据： " + result);
//    print(response.data["msg"]);
//
//    if (response.data["suc"] == true) {
//      Map<String, dynamic> json =
//          Map<String, dynamic>.from(response.data["data"]);
//      /*将Json转成实体类*/
//      userModel model = userModel.fromJson(json);
////      print(model.phone);
//      SpUtil.putObject(kUserDefault_UserInfo, model);
//      hide();
////      JhToast.showText(context, msg: response.data["msg"]);
//      JhToast.showSuccess(context, msg: response.data["msg"]);
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => (BaseTabBar())));
//    } else {
//      hide();
//      JhToast.showText(context, msg: response.data["msg"]);
//    }

    //登录请求
    HttpUtils.PostRequest(APIType.Login, {"userName": _name, "pwd": _pwd},
        success: (data) {
      if (data["suc"] == true) {
//        Map<String, dynamic> json = Map<String, dynamic>.from(data["data"]);
//        /*将Json转成实体类*/
//        userModel model = userModel.fromJson(json);
//      print(model.phone);
//        SpUtil.putObject(kUserDefault_UserInfo, model);

        //保存本地
        JhStorageUtils.saveModel(kUserDefault_UserInfo, data["data"]);

        hide();
        JhToast.showSuccess(context, msg: data["msg"]);
        NavigatorUtils.pushReplacement(context, Routes.home);
      } else {
        hide();
        JhToast.showText(context, msg: data["msg"]);
      }
    }, fail: (code) {
      hide();
    });
  }
}
