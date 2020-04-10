import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/configs/strings.dart';
import 'package:jh_flutter_demo/baseAppBar.dart';

import 'package:jh_flutter_demo/routes/routes.dart' as Luyou;

class OnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
//      AppBar(
//        title: Text(KString.oneTabTitle,style:TextStyle (color: KColor.kWeiXinTitleColor)),
//        elevation: 0.0,
//      ),

      baseAppBar(context, KString.oneTabTitle,leftItem: Container(),
      rightImgPath:'assets/images/ic_nav_add.png',
        rightItemCallBack: (){

        }
      ),

      body:
      Column(children: <Widget>[

        RaisedButton(
          child: Text("跳转"),
          onPressed: () {
            Navigator.pushNamed(context, Luyou.demoListsPage);
          },
        ),

      ],)


    );
  }


}



