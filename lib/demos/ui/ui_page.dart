// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/widgets/jh_scrollview.dart';

/*
1.22 版本前的按钮	       主题	          1.22 版本后的按钮	  主题
FlatButton（扁平按钮）	   ButtonTheme	  TextButton	        TextButtonTheme
OutlineButton（边框按钮）  ButtonTheme	  OutlinedButton	    OutlinedButtonTheme
RaisedButton（背景色按钮） ButtonTheme	  ElevatedButton	    ElevatedButtonTheme

const ButtonStyle({
  this.textStyle, // 字体
  this.backgroundColor, // 背景色
  this.foregroundColor, // 前景色，文字颜色
  this.overlayColor, // 高亮色(水波纹颜色)，按钮处于focused, hovered, or pressed时的颜色
  this.shadowColor, // 阴影颜色
  this.elevation, // 阴影值
  this.padding, // padding
  this.minimumSize, // 最小尺寸
  this.side, // 边框
  this.shape, // 形状
  this.mouseCursor, // 鼠标指针的光标进入或悬停在此按钮的[InkWell]上时。
  this.visualDensity, // 按钮布局的紧凑程度
  this.tapTargetSize, // 响应触摸的区域
  this.animationDuration, // [shape]和[elevation]的动画更改的持续时间。
  this.enableFeedback, // 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
});

* */

class UIPage extends StatefulWidget {
  const UIPage({Key? key}) : super(key: key);

  @override
  State<UIPage> createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UITest', style: TextStyle(color: Colors.white)),
        elevation: 0.0,
      ),
      body: _body(),
    );
  }

  _body() {
    return JhScrollView(
      child: Column(
        children: <Widget>[
          testBtn,
          textSection,
          testImage,
          testContainer,
          testText,
          testImage,
          testText,
          testPositioned,
          // 绝对定位
          testContainer,
          // Container
          textListView,
          textListView0,
          Container(
            height: 1500,
            width: double.infinity,
            color: Colors.yellow,
            child: const Text('往下滑动'),
          ),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
          const Text('data'),
        ],
      ),
    );
  }
}

List<String> bottomData = ['1111', '2222', '3333333333333333333', '4444'];

Widget textListView = ListView(
  shrinkWrap: true, // 是否根据子组件的总长度来设置ListView的长度，默认值为false
  physics: const NeverScrollableScrollPhysics(), // 禁止滑动
  children: <Widget>[
    Text(bottomData[0], style: const TextStyle(color: Colors.black, fontSize: 18.0)),
    Text(bottomData[1], style: const TextStyle(color: Colors.black, fontSize: 18.0)),
    Text(bottomData[2], style: const TextStyle(color: Colors.black, fontSize: 18.0)),
  ],
);

Widget testBtn = Column(children: <Widget>[
  Container(
    color: Colors.yellow,
    width: 100,
    height: 40,
    child: TextButton(
      onPressed: () {},
      style: ButtonStyle(
        // 背景色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          // 设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.yellow;
          }
          // 默认不使用背景颜色
          return Colors.blue[700];
        }),
        // 文字颜色
        foregroundColor: MaterialStateProperty.all(Colors.white),
        // 高亮颜色
        overlayColor: MaterialStateProperty.all(Colors.green),
        shadowColor: MaterialStateProperty.all(Colors.orange),
        // 边框
        side: MaterialStateProperty.all(const BorderSide(color: Colors.red, width: 1)),
        // 圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: const Text('Submit', style: TextStyle(fontSize: 15.0)),
    ),
  ),
  // 扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
  TextButton(
    child: const Text('扁平按钮(TextButton)', style: TextStyle(color: Colors.black)),
    onPressed: () {},
  ),
  TextButton.icon(
    icon: const Icon(Icons.send),
    label: const Text('扁平按钮,带图标'),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue),
//      backgroundColor: MaterialStateProperty.resolveWith((states) {
//        // 设置按下时的背景颜色
//        if (states.contains(MaterialState.pressed)) {
//          return Colors.yellow;
//        }
//        // 默认不使用背景颜色
//        return null;
//      }),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            // 按下时的颜色
            return Colors.red;
          }
          // 默认状态使用灰色
          return Colors.black;
        },
      ),
      // 设置水波纹颜色
      overlayColor: MaterialStateProperty.all(Colors.purpleAccent),
      // 设置按钮大小
      fixedSize: MaterialStateProperty.all(const Size(150, 80)),
      minimumSize: MaterialStateProperty.all(const Size(150, 80)),
      // 设置边框
      side: MaterialStateProperty.all(const BorderSide(color: Colors.red, width: 1)),
      // 设置按钮形状
//      shape: MaterialStateProperty.all(StadiumBorder(
//        side: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid),
//      )),
      // 设置按钮圆角
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    onPressed: () {},
  ),
  // FlatButton(
  //   child: Text('扁平按钮(FlatButton、Flutter1.22废弃)'),
  //   onPressed: () {},
  // ),
  // 带边框的按钮、Flutter1.22 之后新增
  // 默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，
  OutlinedButton(
    child: const Text('带边框的按钮（OutlinedButton）'),
    onPressed: () {},
  ),
  // 废弃
  // OutlineButton(
  //   child: Text('带边框的按钮(OutlineButton、Flutter1.22废弃)'),
  //   onPressed: () {},
  // ),
  // '漂浮'按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
  ElevatedButton(
    child: const Text('凸起的按钮(ElevatedButton)'),
    onPressed: () {},
  ),
  IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
  // RaisedButton.icon(
  //   icon: Icon(Icons.send),
  //   label: Text('带图标的按钮(RaisedButton、Flutter1.22废弃)'),
  //   onPressed: () {},
  // ),
]);

Widget testText = Container(
  color: Colors.yellow,
  width: 200,
  height: 300,
  child: const Text(
    '这是测试文本',
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Color(0xFF999999),
    ),
  ),
);

Widget testImage = Container(
  color: Colors.yellow,
//  width: 400,
//  height: 400,
  child: Image(
//        image: AssetImage('assets/images/touxiang.jpeg'),
    image: JhImageUtils.getAssetImage('picture/tubiao'),
    width: 50,
    height: 50,
//      fit: BoxFit.cover,
//    fit: BoxFit.contain,
  ),

//  child: Image.network(
//      'https://pics4.baidu.com/feed/2cf5e0fe9925bc3182c54af16fbe80b7ca1370a2.jpeg?token=f1baf830f16d6b912bdb19ab7318374c&s=B28AA7E95272AFCE02793003030090C2',
//      width: 100.0,
////    fit: BoxFit.fitHeight,
////    height: 100
//    )
);

// Container 练习
Widget testContainer = Container(
  width: 200,
  height: 200,

//  margin: EdgeInsets.all(10),
  margin: const EdgeInsets.only(left: 10, top: 10),
// margin: EdgeInsets.fromLTRB(left, top, right, bottom),
//  EdgeInsets.symmetric(horizontal: val1, vertical: val2): // 用于设置水平/垂直方向上的值；
  constraints: const BoxConstraints(
//      minWidth: double.infinity, // 宽度尽可能大
      minWidth: 300,
      minHeight: 50.0 //最小高度为50像素
      ),

  alignment: Alignment.topRight,
  // 子组件将以何种方式进行排列
  color: Colors.yellow,
  child: const Text('这是文字'),
);

// 绝对定位
Widget testPositioned = Container(
  height: 100,
  color: Colors.yellow,
  child: Stack(
    children: <Widget>[
      Positioned(
        left: 10,
        top: 10,
        child: Container(width: 10, height: 10, color: Colors.red),
      ),
      Positioned(
        right: 10,
        top: 10,
        child: Container(width: 10, height: 10, color: Colors.red),
      ),
      Positioned(
        left: 10,
        bottom: 10,
        child: Container(width: 10, height: 10, color: Colors.red),
      ),
      Positioned(
        right: 10,
        bottom: 10,
        child: Container(width: 10, height: 10, color: Colors.red),
      ),
    ],
  ),
);

Widget textSection = Container(
//  padding: const EdgeInsets.all(32),

  alignment: Alignment.topCenter,
//    Alignment.topCenter
//  constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), // 卡片大小

  child: const Text(
//    '这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字',
    '这是一段文字',
    style: TextStyle(
//      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
      backgroundColor: Colors.blue,
      fontSize: 30,
    ),
//    textAlign: TextAlign.center,
  ),
);

Widget textListView0 = Container(
  color: Colors.red,
  constraints: const BoxConstraints(
    maxHeight: 100,
  ),
//  margin: EdgeInsets.only(bottom: 20),
  child: ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(), // 禁止滑动
    padding: const EdgeInsets.all(20.0),
    children: const <Widget>[
      Text(
        '1313133',
        style: TextStyle(
          color: Colors.blue,
          height: 20,
          fontSize: 18.0,
        ),
      ),
      Text('Domestic life was never quite my style'),
      Text('When you smile, you knock me out, I fall apart'),
      Text('And I thought I was so smart'),
    ],
  ),
);
