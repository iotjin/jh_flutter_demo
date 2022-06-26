// ignore_for_file: unused_field, unnecessary_null_comparison, prefer_is_not_empty

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '/jh_common/jh_form/jh_keyboard_utils.dart';
import '/jh_common/utils/jh_color_utils.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/routes/jh_nav_utils.dart';
import '/project/base_tabbar.dart';

class LoginPageFei extends StatefulWidget {
  @override
  _LoginPageFeiState createState() => _LoginPageFeiState();
}

class _LoginPageFeiState extends State<LoginPageFei> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  bool pwdShow = false; // 密码是否显示明文
  bool _nameAutoFocus = true;

  bool? _isShowDelete; // 右侧一键删除按钮
  bool? _isShowDelete2; // 右侧一键删除按钮

  Color? logoColor;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _nameController.text = "jin";
    if (_nameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();

//    _isShowDelete = !_nameController.text.isEmpty;
//    _isShowDelete2 = !_pwdController.text.isEmpty;
    // 监听输入改变
//    _nameController.addListener(() {
//      setState(() {
//        _isShowDelete = !_nameController.text.isEmpty;
//      });
//    });
//    _pwdController.addListener(() {
//      setState(() {
//        _isShowDelete2 = !_pwdController.text.isEmpty;
//      });
//    });

    _isShowDelete = _node1.hasFocus;
    _isShowDelete2 = _node2.hasFocus;
    _node1.addListener(() {
      setState(() {
        _isShowDelete = _node1.hasFocus;
      });
    });
    _node2.addListener(() {
      setState(() {
        _isShowDelete2 = _node2.hasFocus;
      });
    });

    _nameController.addListener(() {
      setState(() {
        _isShowDelete = !_nameController.text.isEmpty;
      });
    });

    logoColor = JhColorUtils.randomColor();

    if (Platform.isIOS) {
//      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//        statusBarColor: Colors.red,
//      );
//      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("login dispose-fei");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: KeyboardActions(
      config: JhKeyboardUtils.getKeyboardConfig(context, [_node1, _node2]),
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
                          JhNavUtils.pushNamed(context, "RegisterPage");
                        },
                      )),
                ),

                SizedBox(height: 50),
//                  Image.asset("assets/images/lufei.png",width: 100,),

                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Logo',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                TextFormField(
                  focusNode: _node1,
                  controller: _nameController,
                  decoration: InputDecoration(
//                    labelText: "用户名",
                    hintText: "请输入用户名",
                    hintStyle: TextStyle(fontSize: 15),
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _isShowDelete!
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Color(0xFFC8C8C8),
                                    size: 20,
                                  ),
                                  onPressed: () => _clickDeleteBtn())
                              : Text(""),
                        ],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.8)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  focusNode: _node2,
                  controller: _pwdController,
                  decoration: InputDecoration(
//                    labelText: "密码",
                    hintText: "请输入密码",
                    hintStyle: TextStyle(fontSize: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.8)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                    prefixIcon: Icon(Icons.lock),
//                        suffixIcon: IconButton(
//                          icon: Icon(
//                              pwdShow ?  Icons.visibility :Icons.visibility_off),
//                          onPressed: () {
//                            setState(() {
//                              pwdShow = !pwdShow;
//                            });
//                          },
//                        )
                    suffixIcon: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _isShowDelete2!
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Color(0xFFC8C8C8),
                                    size: 20,
                                  ),
                                  onPressed: () => _pwdController.text = "")
                              : Text(""),
                          IconButton(
                            icon: Icon(pwdShow
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                pwdShow = !pwdShow;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  obscureText: !pwdShow,
                ),
                SizedBox(height: 50),
                JhButton(text: "登 录", onPressed: _clickOkBtn),
                SizedBox(height: 10),
                Container(
                  height: 40.0,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      child: Text(
                        '忘记密码',
                      ),
                      onTap: () =>
                          JhNavUtils.pushNamed(context, "FindPwdPage")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _clickDeleteBtn() {
    print("点击删除");
    _nameController.text = "";
  }

  void _clickOkBtn() async {
//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, "BaseTabBar");

    var hide = JhToast.showIOSLoadingText(
      context,
      msg: "正在登录...",
    );
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => (BaseTabBar())));

      hide();
    });
  }
}
