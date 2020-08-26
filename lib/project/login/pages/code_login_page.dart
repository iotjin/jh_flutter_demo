/**
 *  code_login_page.dart
 *
 *  Created by iotjin on 2020/04/09.
 *  description:  验证码登录
 */
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart';
import 'package:jh_flutter_demo/project/routes/routes_old.dart';

import 'package:jhtoast/jhtoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:jh_flutter_demo/jh_common/jh_form/jh_keyboard_utils.dart';
//import 'package:jh_flutter_demo/jh_common/jh_form/jh_form_Input_cell.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_count_down_btn.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_button.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/base_tabbar.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class CodeLoginPage extends StatefulWidget {
  @override
  _CodeLoginPageState createState() => _CodeLoginPageState();
}

class _CodeLoginPageState extends State<CodeLoginPage> {

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _phone ='';
  var _code = '';

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: backAppBar(context, '', backgroundColor: Colors.transparent),
          body:  KeyboardActions(
            config: JhKeyboardUtils.getKeyboardConfig(context, [_node1,_node2]),
            child: _mainBody(),
          )

      );
  }

  Widget _mainBody(){
    return

          SingleChildScrollView(
            child:
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    '验证码登录',
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 50),

                  SizedBox(height: 30),
                  JhLoginTextField(text:_phone,hintText: "请输入手机号",focusNode:_node1,maxLength: 11,
                      keyboardType:TextInputType.number,
                      inputCallBack: (value)=> _phone=value
                  ),
                  SizedBox(height: 10),

                  JhLoginTextField(hintText: "请输入验证码",focusNode:_node2,maxLength: 6,
                      keyboardType:TextInputType.number,
                      rightWidget:
                      JhCountDownBtn(
                          showBorder: true,
                          getVCode:()async {
                            return true;
                          }
                      ),
                      inputCallBack: (value)=> _code =value
                  ),
                  SizedBox(height: 50),
                  JhButton(text: "登 录",
                      onPressed: _ClickOkBtn
                  ),
                  SizedBox(height: 15),



                ],
              ),

            ),
          );
  }

  void _ClickOkBtn() async {

    print('_phone =$_phone');
    print('_code =$_code');


    var hide =  JhToast.showIOSLoadingText(context,
      msg:"正在登录...",
    );
    Future.delayed(Duration(seconds: 1),(){

//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (context) => (BaseTabBar()
//          )));
      NavigatorUtils.pushReplacement(context, Routes.home);
      hide();

    });


  }

}
