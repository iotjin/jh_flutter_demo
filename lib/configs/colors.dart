/* 颜色 配置
* */

import 'package:flutter/material.dart';

const Color kThemeColor = Color(0xFF3BB815);

class KColor {

  static Color kWeiXinThemeColor = Color(0xFF3BB815); //微信主题色  //rgb(59,184,21)

  static Color kWeiXinTitleColor = Colors.white;

//  static Color ThemeColor =  Color.fromRGBO(59, 184, 21, 1);
//  static const Color app_main = Color(0xFF4688FA);

  static Color  kLineColor = Color(0xFFE6E6E6);//230
  static Color transparent = Colors.transparent;

  static Color appBarGradientStartColor = Color(0xFF2171F5); //渐变 开始色
  static Color appBarGradientEndColor = Color(0xF000A2FC); //结束色

  
}


/*

ColorsUtil.hexColor(0x3caafa)//透明度为1
ColorsUtil.hexColor(0x3caafa,alpha: 0.5)//透明度为0.5
* */
class ColorsUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex,{double alpha = 1}){
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
        (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0,
        alpha);
  }
}

/*

如Web开发中的色值通常是一个字符串如"#dc380d"，它是一个RGB值，我们可以通过下面这些方法将其转为Color类：

Color(0xffdc380d); //如果颜色固定可以直接使用整数值
//颜色是一个字符串变量
var c = "dc380d";
Color(int.parse(c,radix:16)|0xFF000000) //通过位运算符将Alpha设置为FF
Color(int.parse(c,radix:16)).withAlpha(255)  //通过方法将Alpha设置为FF


* */