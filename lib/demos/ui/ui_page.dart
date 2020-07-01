import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart' as Luyou;
import 'package:jh_flutter_demo/jh_common/utils/jh_image_utils.dart';

class UIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UITest",style:TextStyle (color:  Colors.white)),
        elevation: 0.0,
      ),

     body: BaseScrollView()
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




          testBtn,
          FlatButton( //即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
            child: Text("扁平按钮"),
            onPressed: () {},
          ),
          RaisedButton(//即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
            child: Text("漂浮按钮"),
            onPressed: () {},
          ),

          OutlineButton( //OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，
            child: Text("带边框的按钮"),
            onPressed: () {},
          ),

          RaisedButton.icon(
            icon: Icon(Icons.send),
            label: Text("带图标的按钮"),
            onPressed: () {},
          ),

          textSection,
          testImage,
          testContainer,
          testText,
          testImage,
          testText,
          testPositioned,  //绝对定位
          testContainer ,//Container
          textListView,
          textListView0,

          Container(height: 1500,width:double.infinity,color: Colors.yellow,child: Text("往下滑动"),),
          Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),
          Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),Text("data"),

            ],
          ),

          )
      );

  }
}








List<String> bottomData = ["1111", "2222", "3333333333333333333", "4444"];


Widget textListView = Container(
  child: ListView(
    shrinkWrap: true,//是否根据子组件的总长度来设置ListView的长度，默认值为false
    physics: const NeverScrollableScrollPhysics(),// 禁止滑动
    children: <Widget>[
      Text(bottomData[0], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
      Text(bottomData[1], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
      Text(bottomData[2], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
    ],
  ),
);


Widget testBtn =Container(
    color: Colors.yellow,
    width: 100,
    height: 40,

//     child: FlatButton( //即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
//      child: Text("扁平按钮"),
//      onPressed: () {},
//    ),
//  child: RaisedButton(//即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
//    child: Text("漂浮按钮"),
//    onPressed: () {},
//  ),

//    child: OutlineButton( //OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，
//      child: Text("带边框的按钮"),
//      onPressed: () {},
//    )

//    child: RaisedButton.icon(
//      icon: Icon(Icons.send),
//      label: Text("带图标的按钮"),
//      onPressed: () {},
//    ),


    child:FlatButton(
      color: Colors.blue,
      highlightColor: Colors.blue[700],
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Text("Submit"),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {},
    )

);



Widget testText = Container(
  color: Colors.yellow,
  width: 200,
  height: 300,
  child: Text(
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

//        image: AssetImage("assets/images/touxiang.jpeg"),
    image: JhImageUtils.getAssetImage('tubiao'),
    width: 50,
    height: 50,
//      fit: BoxFit.cover,
//    fit: BoxFit.contain,
  ),

//  child: Image.network(
//      "https://pics4.baidu.com/feed/2cf5e0fe9925bc3182c54af16fbe80b7ca1370a2.jpeg?token=f1baf830f16d6b912bdb19ab7318374c&s=B28AA7E95272AFCE02793003030090C2",
//      width: 100.0,
////    fit: BoxFit.fitHeight,
////    height: 100
//    )

);



//Container 练习
Widget testContainer = Container(
  width: 200,
  height: 200,

//  margin: EdgeInsets.all(10),
  margin: EdgeInsets.only(left: 10,top: 10),
// margin: EdgeInsets.fromLTRB(left, top, right, bottom),
//  EdgeInsets.symmetric(horizontal: val1, vertical: val2): //用于设置水平/垂直方向上的值；
  constraints: BoxConstraints(
//      minWidth: double.infinity, //宽度尽可能大
      minWidth: 300,
      minHeight: 50.0 //最小高度为50像素
  ),

  alignment: Alignment.topRight, //子组件将以何种方式进行排列
  color: Colors.yellow,
  child: Text("这是文字"),
);



//绝对定位
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

  alignment:Alignment.topCenter,
//    Alignment.topCenter
//  constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小

  child: Text(
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
  constraints: BoxConstraints(
    maxHeight: 100,
  ),
//  margin: EdgeInsets.only(bottom: 20),
  child: ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),// 禁止滑动
    padding: const EdgeInsets.all(20.0),
    children: <Widget>[
      Text('1313133',
        style: TextStyle(
          color: Colors.blue,
          height: 20,
          fontSize: 18.0,
        ),
      ),
      const Text('Domestic life was never quite my style'),
      const Text('When you smile, you knock me out, I fall apart'),
      const Text('And I thought I was so smart'),
    ],
  ),
);
