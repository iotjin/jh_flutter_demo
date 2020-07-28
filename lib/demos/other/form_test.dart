import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_picker_tool.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_form.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


class FormTest extends StatefulWidget {
  @override
  _FormTestState createState() => _FormTestState();
}

class _FormTestState extends State<FormTest> {

  var _phone ="123456";
  var selectTextStr="";

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();
  final FocusNode _node3 = FocusNode();
  final FocusNode _node4 = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return

      GestureDetector(
          behavior: HitTestBehavior.translucent,//事件穿透
          onTap: () {// 点击空白收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child:
          Scaffold(
//              resizeToAvoidBottomPadding: true, //输入框抵住键盘
              appBar: AppBar(
                  title: Text('FormTest')
              ),
              body:
              KeyboardActions(
                config: jhForm.getKeyboardConfig(context, [_node1,_node2,_node3,_node4]),
                child: _mainBody(),
              )
          )

      );


  }






  _mainBody(){

    double _space = 5;
    return   Scrollbar(
        child:
        SingleChildScrollView(child:
        Column(
          children: <Widget>[
            SizedBox(height: _space),
            jhForm.inputText(
                title: "联系人", hintText: "这是提示文字",focusNode: _node1, space: 100),
            SizedBox(height: _space),
            jhForm.inputText(
                title: "联系电话",
                inputInfo: _phone,
                hintText: "请输入电话号码",
                focusNode: _node2,
//                    space: 100,
                keyboardType: TextInputType.number,
                inputCallBack: (value) {
                  _phone = value;
                  print("callback" + value);
                }
            ),

            SizedBox(height: _space,),
            jhForm.textView(
                inputInfo: "这是默认值",
                hintText: "这是提示文字",
                focusNode: _node3,
                showRedStar: true,
                inputCallBack: (value) {
                  print("textView" + value);
                }
            ),
            SizedBox(height: _space,),
            jhForm.textView(
                focusNode: _node4,
                inputCallBack: (value) {
                  print("textView2" + value);
                }
            ),
            SizedBox(height: _space,),
            jhForm.selectText(
                title: "选择样式",
                selectInfo: selectTextStr,
//                  hintText: "请选择0",
                clickCallBack: () {
                  JhPickerTool.showStringPicker(context,
                      data: ["1", "2", "3"],
                      clickCallBack: (index, str) {
                        setState(() {
                          selectTextStr = str;
                        });
                      }
                  );
                }
            ),


            SizedBox(height: _space,),
            RaisedButton(
                child: Text("确认"),
                onPressed: () {
                  print("确认" + _phone);
                  print("确认" + selectTextStr);
                }
            ),
          ],
        ),
        )
    );
  }


}


