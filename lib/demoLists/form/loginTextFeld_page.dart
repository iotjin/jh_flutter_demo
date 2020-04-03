import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/baseAppBar.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhLoginTextField.dart';
import 'package:flutter/services.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhButton.dart';
import 'package:jhtoast/jhtoast.dart';

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
                JhLoginTextField(hintText: "密码样式",isShowDeleteBtn: true,isPwd: true,),
                JhLoginTextField(hintText: "默认只限制长度20",isShowDeleteBtn: true),
                JhLoginTextField(hintText: "自定义inputFormatters 长度5，a-zA-Z0-9",isShowDeleteBtn: true,
                 inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")) ,
                  LengthLimitingTextInputFormatter(5)]),
                JhLoginTextField(hintText: "限制 长度5，0-9，phone键盘",isShowDeleteBtn: true,
                    keyboardType:TextInputType.phone,
                    inputFormatters:[WhitelistingTextInputFormatter(RegExp("[0-9]")) ,
                      LengthLimitingTextInputFormatter(5)]),

                JhLoginTextField(hintText: "左侧添加按钮",leftIcon: Icon(Icons.perm_identity)),

                JhLoginTextField(text: _name,hintText: "请输入用户名",leftIcon: Icon(Icons.person),isShowDeleteBtn: true,
                  inputCallBack: (value) => _name=value
                ),
                JhLoginTextField(text: _pwd,hintText: "请输入密码",leftIcon: Icon(Icons.lock),isShowDeleteBtn: true,isPwd: true,
                  inputCallBack: (value) => _pwd =value
                ),

                SizedBox(height: 50),
                JhButton(text: "登 录",
                    onPressed:()=> _ClickOkBtn(context)
                ),

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
