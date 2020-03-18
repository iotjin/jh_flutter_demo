import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/configs/strings.dart';
import 'package:jh_flutter_demo/baseAppBar.dart';


class FourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(context, KString.fourTabTitle,
        leftItem: Container(),
        rightImgPath:"assets/images/set.png",

        rightItemCallBack: (){
        
          Navigator.pushNamed(context, "SetPage");

        }
      ),
      body: Container(),
    );
  }
}

