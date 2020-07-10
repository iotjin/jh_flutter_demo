import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/configs/strings.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart' as Luyou;
import 'package:jh_flutter_demo/base_appbar.dart';


const Color bgColor = Colors.black87;
const double radius = 3.0;


/*
--enable-software-rendering

* Flutter中的Offstage与Visibility都可以将子widget进行隐藏，
* 不同的是Visibility可以设置隐藏之后是否还占据原来的控件、设置隐藏后是否响应事件，
* Offstage隐藏后之前所占的空间就会消失。
*
* 一、Offstage

    Offstage中控制显示隐藏的重要属性是offstage，默认为true。当offstage 为true时，其child控件是隐藏的。

二、Visibility
*
Visibility构造器
*
const Visibility({
    Key key,
    @required this.child,
    this.replacement = const SizedBox.shrink(), // 不可见时显示的组件，只有maintainState=false才会显示。
    this.visible = true, // 是否可见
    this.maintainState = false, // 隐藏后是否位置组件状态
    this.maintainAnimation = false, // 隐藏后是否维持子组件中的动画
    this.maintainSize = false, // 隐藏后所占空间是否释放
    this.maintainSemantics = false,
    this.maintainInteractivity = false, // 隐藏后是否能够照常响应事件
  })

*
* */

class TwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        baseAppBar(context, KString.twoTabTitle,),
      body: BaseScrollView(),

    );
  }
}

class BaseScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      Scrollbar(
        child: SingleChildScrollView(child:
        Column(
          children: <Widget>[
            Container(height: 1500,width:double.infinity,color: Colors.yellow,child: Text("往下滑动"),),
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <InlineSpan>[
                    TextSpan(text: '登录即视为同意'),
                    TextSpan(
                      text: '《xxx服务协议》',
                      style: TextStyle(color: Colors.red),
                      recognizer: new TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                    ),
                  ]),
            ),

            Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),
            Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),
            FlatButton(
              child: Text("点击"),
              onPressed: (){
                MessageDialog(title: "title", message: "Mess", onCloseEvent: (){
                  print("object");
                });

              },
            ),


          ],
        ),

        )
    );

  }
}



// ignore: must_be_immutable
class MessageDialog extends Dialog {
  String title;
  String message;
  String negativeText;
  String positiveText;
  Function onCloseEvent;
  Function onPositivePressEvent;

  MessageDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(25.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10),
                    child: new Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        new Center(
                          child: new Text(
                            title,
                            style: new TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: this.onCloseEvent,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new Icon(
                              Icons.close,
                              color: Color(0xffe0e0e0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  new Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    constraints: BoxConstraints(minHeight: 100.0),
                    child: Center(
                      child: new Text(
                        message,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton());
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton());
    return Container(
      child: new Flex(
        direction: Axis.horizontal,
        children: widgets,
      ),
    );
  }

  Widget _buildBottomCancelButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onCloseEvent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
          child: Text(
            negativeText,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: onPositivePressEvent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
          child: Text(
            positiveText,
            style: TextStyle(
              color: Color(Colors.teal.value),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
