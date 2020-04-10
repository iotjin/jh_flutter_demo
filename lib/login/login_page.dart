import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhButton.dart';
import 'package:jh_flutter_demo/baseTabBar.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhForm.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:flui/src/widgets/avatar.dart';
import 'package:jh_flutter_demo/JhTools/tools/jhColorTool.dart';
import 'package:jh_flutter_demo/JhTools/JhForm/jhLoginTextField.dart';


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

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _name ='jin';
  var _pwd = '';

  Color logoColor;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框

    super.initState();

    logoColor = JhColorTool.randomColor();


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
    print("login dispose");
    _node1.unfocus();
    _node2.unfocus();
  }

@override
  Widget build(BuildContext context) {

    return
    Scaffold(
      body:  KeyboardActions(
        config: jhForm.getKeyboardConfig(context, [_node1,_node2]),
        child: _mainBody(),
      )

    );
  }

  Widget _mainBody(){
    return

      Stack(

        children: <Widget>[

          SingleChildScrollView(
            child:
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:  Column(
                children: <Widget>[

                  SafeArea(child:
                  Align(
                    alignment: Alignment.topRight,
                    child:
                      InkWell(
                        child: Text("注册",style: TextStyle(fontSize: 18)),
                        onTap: (){
                          Navigator.pushNamed(context, "RegisterPage");
                        },
                      )
                  ),
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
                  JhLoginTextField(text:_name,hintText: "请输入用户名",focusNode:_node1,leftWidget: Icon(Icons.person),isShowDeleteBtn: true,
                    inputCallBack: (value)=> _name=value
                  ),
                  SizedBox(height: 10),

                  JhLoginTextField(hintText: "请输入密码",focusNode:_node2,leftWidget: Icon(Icons.lock),isShowDeleteBtn: true,isPwd: true,
                    pwdClose: 'assets/images/ic_pwd_close.png',pwdOpen: 'assets/images/ic_pwd_open.png',
                    inputCallBack: (value)=>_pwd =value

                  ),
                  SizedBox(height: 50),
                  JhButton(text: "登 录",
                      onPressed: _ClickOkBtn
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        child: GestureDetector(
                            child: Text('验证码登录',),
                            onTap: () => Navigator.pushNamed(context, "CodeLoginPage")
                        ),
                      ),
                      Container(
                        height: 50.0,
//                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            child: Text('忘记密码',),
                            onTap: () => Navigator.pushNamed(context, "FindPwdPage")
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


  void _ClickOkBtn() async {

//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, "BaseTabBar");


    print('name =$_name');
    print('pwd =$_pwd');


    var hide =  JhToast.showLoadingText_iOS(context,
      msg:"正在登录...",
    );
    Future.delayed(Duration(seconds: 1),(){

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => (BaseTabBar()
      )));

      hide();

    });

    
  }


}


