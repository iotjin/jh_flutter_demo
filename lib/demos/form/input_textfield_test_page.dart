import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_textfield.dart';
import 'package:flutter/services.dart';

class InputTextFieldTestPage extends StatefulWidget {
  @override
  _InputTextFieldTestPageState createState() => _InputTextFieldTestPageState();
}

class _InputTextFieldTestPageState extends State<InputTextFieldTestPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        backAppBar(context, 'JhTextField'),
        body:


        Scrollbar(
            child: SingleChildScrollView(child:

            Padding(
              padding: EdgeInsets.all(15),
              child:   Column(
                children: <Widget>[

                  JhTextField(hintText: "默认样式，没有边框",),
                  SizedBox(height: 10),
                  JhTextField(text: "text赋初值,不可编辑",enabled: false,),
                  SizedBox(height: 10),
                  JhTextField(hintText: "限制 长度5，0-9，phone键盘",
                      keyboardType:TextInputType.phone,
                      inputFormatters:[WhitelistingTextInputFormatter(RegExp("[0-9]")) ,
                        LengthLimitingTextInputFormatter(5)]),
                  SizedBox(height: 10),
                  JhTextField(hintText: "自定义inputFormatters 长度10，a-zA-Z0-9",
                      inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")) ,
                        LengthLimitingTextInputFormatter(10)]),
                  SizedBox(height: 10),
                  JhTextField(hintText:'左侧自定义，maxLength=15',leftWidget: Container(color: Colors.yellow,width: 100,),maxLength: 15,),
                  SizedBox(height: 10),
                  JhTextField(hintText:'右侧自定义，maxLength=15',rightWidget: Container(color: Colors.yellow,width: 100,),maxLength: 15,),
                  SizedBox(height: 10),
                  JhTextField(hintText: "设置maxLines=5，设置边框",maxLines:5,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  JhTextField(hintText: "默认1行，自动换行，最多5行，100字符",
                    border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.none,
                          ),
                        ),
                  ),

                  SizedBox(height: 10),
                  SizedBox(height: 10),





                ],
              ),
            )
            )
        )


    );
  }

}
