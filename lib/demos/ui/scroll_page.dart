import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

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

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: baseAppBar(context, 'ScrollPage'),
        body: BaseScrollView(),
        backgroundColor: KColor.kWeiXinBgColor);
  }
}

class BaseScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 1500,
            width: double.infinity,
            color: Colors.yellow,
            child: Text("往下滑动"),
          ),
          RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <InlineSpan>[
                  TextSpan(text: '登录即视为同意'),
                  TextSpan(
                    text: '《xxx服务协议》',
                    style: TextStyle(color: Colors.red),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => print('Tap Here onTap'),
                  ),
                ]),
          ),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          FlatButton(
            child: Text("点击"),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
