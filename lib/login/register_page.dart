import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhButton.dart';
import 'package:jh_flutter_demo/baseTabBar.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhForm.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/configs/colors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  bool pwdShow = false; //密码是否显示明文
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _nameController.text = "";
    if (_nameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

          appBar:  AppBar(
            title: Text("账号注册",style: TextStyle(color: Colors.white,fontSize:18),),
            backgroundColor: KColor.kWeiXinThemeColor,
//            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

//                SizedBox(height: 50),
                TextFormField(
                  focusNode: _node1,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    hintStyle: TextStyle(fontSize: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 0.8
                        )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:  Colors.grey,
                            width: 0.5
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  focusNode: _node2,
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: "密码",
                      hintText: "请输入密码",
                      hintStyle: TextStyle(fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.8
                          )
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:  Colors.grey,
                              width: 0.5
                          )
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                            pwdShow ?  Icons.visibility :Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            pwdShow = !pwdShow;
                          });
                        },
                      )),
                  obscureText: !pwdShow,

                ),
                SizedBox(height: 50),
                JhButton(text: "注 册",
                    onPressed: _ClickOkBtn
                )
              ],
            ),

          ),
        )

      ],
    );


  }


  void _ClickOkBtn() async {

//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, "BaseTabBar");




    var hide =  JhToast.showLoadingText_iOS(context,
      msg:"正在注册...",
    );
    Future.delayed(Duration(seconds: 1),(){

      Navigator.pop(context);
      hide();

    });


  }


}


