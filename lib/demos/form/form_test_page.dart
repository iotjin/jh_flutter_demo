import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_form_Input_cell.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_form_select_cell.dart';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class FormTestPage extends StatefulWidget {
  @override
  _FormTestPageState createState() => _FormTestPageState();
}

class _FormTestPageState extends State<FormTestPage> {

  bool _switchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        backAppBar(context, 'FormTest'),
        body:

        Scrollbar(
            child: SingleChildScrollView(child:

         Column(
                children: <Widget>[

                  JhFormInputCell(title: "左标题",hintText: "默认1行,最多5行,100字符,标题垂直居中",),
                  JhFormInputCell(title: "左标题",text: "text赋初值,不可编辑",enabled: false),
                  JhFormInputCell(title: "左标题",hintText: "标题加红星",showRedStar: true,),
                  JhFormInputCell(title: "左标题",hintText: "红色标题",titleStyle:TextStyle(fontSize: 15.0,color: Colors.red,),),
                  JhFormInputCell(title: "左标题",text: "红色文字",textStyle:TextStyle(fontSize: 15.0,color: Colors.red,),),
                  JhFormInputCell(title: "左标题",text: "text靠右",textAlign: TextAlign.right,),
                  JhFormInputCell(title: "左标题",hintText: "限制 长度5，0-9，phone键盘",keyboardType:TextInputType.phone,
                      inputFormatters:[WhitelistingTextInputFormatter(RegExp("[0-9]")) ,
                        LengthLimitingTextInputFormatter(5)]),

                  JhFormInputCell(title: "左标题",hintText: "自定义inputFormatters 长度10，a-zA-Z0-9",
                      inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")) ,
                        LengthLimitingTextInputFormatter(10)]),

                  JhFormSelectCell(title: "左标题"),
                  JhFormSelectCell(title: "左标题",text: "text赋初值"),
                  JhFormSelectCell(title: "左标题",hintText: "标题加红星",showRedStar: true,),
                  JhFormSelectCell(title: "左标题",hintText: "红色标题",titleStyle:TextStyle
                    (fontSize: 15.0,color: Colors.red,),),
                  JhFormSelectCell(title: "左标题",text: "红色文字",textStyle:TextStyle(fontSize: 15.0,color: Colors.red,),),
                  JhFormSelectCell(title: "左标题",text: "text靠右",textAlign: TextAlign.right,),
                  JhFormSelectCell(title: "左标题",hintText:'隐藏箭头',
                    rightWidget: Container(color: Colors.yellow,width: 168,height: 42,),hiddenArrow: true,
                  ),



                ],

            )
            )
        )


    );
  }

}
