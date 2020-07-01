import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:flutter/services.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_button.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_count_down_btn.dart';

class LoginTextFieldTestPage extends StatefulWidget {
  @override
  _LoginTextFieldTestPageState createState() => _LoginTextFieldTestPageState();
}

class _LoginTextFieldTestPageState extends State<LoginTextFieldTestPage> {

  var _name ='';
  var _pwd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      backAppBar(context, 'JhLoginTextField'),
      body:


      Scrollbar(
          child: SingleChildScrollView(child:

          Padding(
            padding: EdgeInsets.all(15),
            child:   Column(
              children: <Widget>[

                JhLoginTextField(text: "text赋初值",hintText: "请输入",),
                JhLoginTextField(hintText: "输入时不显示删除按钮",),
                JhLoginTextField(hintText: "输入时显示删除按钮",isShowDeleteBtn: true,),
                JhLoginTextField(hintText: "密码样式(右侧默认图片)",isShowDeleteBtn: true,isPwd: true,),
                JhLoginTextField(hintText: "默认只限制长度20",isShowDeleteBtn: true),
                JhLoginTextField(hintText: "自定义inputFormatters 长度5，a-zA-Z0-9",isShowDeleteBtn: true,
                 inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")) ,
                  LengthLimitingTextInputFormatter(5)]),
                JhLoginTextField(hintText: "限制 长度5，0-9，phone键盘",isShowDeleteBtn: true,
                    keyboardType:TextInputType.phone,
                    inputFormatters:[WhitelistingTextInputFormatter(RegExp("[0-9]")) ,
                      LengthLimitingTextInputFormatter(5)]),

//                JhLoginTextField(hintText: "左侧添加按钮",leftWidget: Icon(Icons.perm_identity)),

                JhLoginTextField(hintText:'左侧自定义',
                  leftWidget: Container(color: Colors.yellow,width: 50,),),
                JhLoginTextField(hintText:'右侧自定义',rightWidget: Container(color: Colors.yellow,width: 100,height: 45,)),

                Container(
                  padding: EdgeInsets.all(20),
                  child: JhLoginTextField(text: _name,hintText: "请输入用户名",labelText:'用户名',
                    leftWidget: Icon(Icons.person),isShowDeleteBtn: true,isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 0.5,color: Colors.grey),
                    ),

                  ),
                ),


                JhLoginTextField(hintText: "请输入手机号",leftWidget: Container(width: 50,child: Center(child:Text("+86"))),keyboardType:TextInputType.phone, ),
                JhLoginTextField(text: _name,hintText: "请输入用户名",labelText:'用户名',leftWidget: Icon(Icons.person),isShowDeleteBtn: true,
                  inputCallBack: (value) => _name=value
                ),
                JhLoginTextField(text: _pwd,hintText: "请输入密码(添加右侧密码图片)",leftWidget: Icon(Icons.lock),isShowDeleteBtn: true,
                    isPwd: true,pwdClose: 'assets/images/ic_pwd_close.png',pwdOpen: 'assets/images/ic_pwd_open.png',

                  inputCallBack: (value) => _pwd =value
                ),
                JhLoginTextField(hintText: "验证码",maxLength: 6,
                    keyboardType:TextInputType.number,
                    rightWidget:
                    JhCountDownBtn(
                        showBorder: true,
                        getVCode:()async {
                          return true;
                        }
                    ),
                ),
                SizedBox(height: 10),
                JhButton(text: "登 录",
                    onPressed:()=> _ClickOkBtn(context)
                ),
                SizedBox(height: 50),
              ],
            ),
          )
          )
      )


    );
  }

  void _ClickOkBtn(context){

    print('name =$_name');
    print('pwd =$_pwd');

  }


}
