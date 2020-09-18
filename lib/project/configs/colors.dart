/**
 *  colors.dart
 *
 *  Created by iotjin on 2020/07/06.
 *  description:  颜色 配置
 */

import 'package:flutter/material.dart';

const Color kThemeColor = Color(0xFF3BB815);

class KColor {
  //微信主题色 rgb(59,184,21)
  static Color kWeiXinThemeColor = Color(0xFF3BB815);

  //rgb(50, 179, 116)
  static Color kWeiXinPayColor = Color(0xFF32B374);

  //rgb(0, 174, 91)
  static Color kWeiXinTextColor = Color(0xFF00AE5B);

  //rgb(255, 139, 34)
  static Color kWeiXinTextOrangeColor = Color(0xFFFF8B22);

  static Color kWeiXinTitleColor = Colors.white;

  //微信背景色 rgb(237,237,237)
  static Color kWeiXinBgColor = Color(0xFFEDEDED);

  //深蓝色
  static Color kWeiXinTextBlueColor = Color(0xFF586D98);

  //灰色文字
  static Color kTextGrayColor = Color(0xFF999999);

//  static Color ThemeColor =  Color.fromRGBO(59, 184, 21, 1);
//  static const Color app_main = Color(0xFF4688FA);

  static Color kLineColor = Color(0xFFE6E6E6); //230
  static Color transparent = Colors.transparent;

  static Color appBarGradientStartColor = Color(0xFF2171F5); //渐变 开始色
  static Color appBarGradientEndColor = Color(0xF000A2FC); //结束色

  static const Color appbarStartColor = Color.fromRGBO(38, 131, 190, 1); //渐变开始色
  static const Color appbarEndColor = Color.fromRGBO(52, 202, 190, 1); // 渐变结束色

}

/*

ColorsUtil.hexColor(0x3caafa)//透明度为1
ColorsUtil.hexColor(0x3caafa,alpha: 0.5)//透明度为0.5
* */
class ColorsUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
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

class Colours {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);
}
