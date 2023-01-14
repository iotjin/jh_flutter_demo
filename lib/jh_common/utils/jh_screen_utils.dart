///  jh_screen_utils.dart
///
///  Created by iotjin on 2020/07/04.
///  description:  屏幕信息

import 'dart:ui' as ui show window;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JhScreenUtils {
  static init(BuildContext context) {
    // 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context, designSize: const Size(750, 1334));
  }

  static setWidth(double width) {
    ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    ScreenUtil().setHeight(height);
  }

  static setSp(num fontSize) {
    ScreenUtil().setSp(fontSize);
  }

  // static double get screenWidth => ScreenUtil.screenWidth;
  //
  // static double get screenHeight => ScreenUtil.screenHeight;

  // static double get screenWidthPx => ScreenUtil.screenWidthPx;
  //
  // static double get screenHeightPx => ScreenUtil.screenHeightPx;
  //
  // static double get statusBarHeight => ScreenUtil.statusBarHeight;
  //
  // static double get bottomBarHeight => ScreenUtil.bottomBarHeight;

  // 系统方法获取

  static double get screenWidth {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  static double get screenHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.devicePixelRatio;
  }

  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.textScaleFactor;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

/*

ScreenUtil.pixelRatio       // 设备的像素密度
ScreenUtil.screenWidth      // 设备宽度
ScreenUtil.screenHeight     // 设备高度
ScreenUtil.bottomBarHeight  // 底部安全区距离，适用于全面屏下面有按键的
ScreenUtil.statusBarHeight  // 状态栏高度 刘海屏会更高  单位px
ScreenUtil.textScaleFactory // 系统字体缩放比例

ScreenUtil.getInstance().scaleWidth  // 实际宽度的dp与设计稿px的比例
ScreenUtil.getInstance().scaleHeight // 实际高度的dp与设计稿px的比例


width:ScreenUtil().setWidth(100)
height:ScreenUtil().setHeight(80)

Container(
width: 50.w,
height:200.h
)

fontSize: ScreenUtil().setSp(28)

fontSize: ScreenUtil.getInstance().setSp(24),
fontSize: ScreenUtil(allowFontScaling: true).setSp(24),


print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
print('设备高度:${ScreenUtil.screenHeight}'); //Device height
print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
print('底部安全区距离:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
print('状态栏高度:${ScreenUtil.statusBarHeight}px');
print('实际宽度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleWidth}');
print('实际高度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleHeight}');
print( '宽度和字体相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleWidth * ScreenUtil.pixelRatio}');
print( '高度相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleHeight * ScreenUtil.pixelRatio}');
print('系统的字体缩放比例:${ScreenUtil.textScaleFactor}');

*/

/*
    屏幕宽度高度：MediaQuery.of(context).size.width
    屏幕宽度高度：MediaQuery.of(context).size.height
    屏幕状态栏高度：MediaQueryData.fromWindow(WidgetBinding.instance.window).padding.top。

    MediaQueryData mq = MediaQuery.of(context);
    // 屏幕密度
    pixelRatio = mq.devicePixelRatio;
    // 屏幕宽(注意是dp, 转换px 需要 screenWidth * pixelRatio)
    screenWidth = mq.size.width;
    // 屏幕高(注意是dp)
    screenHeight = mq.size.height;
    // 顶部状态栏, 随着刘海屏会增高
    statusBarHeight = mq padding.top;
    // 底部功能栏, 类似于iPhone XR 底部安全区域
    bottomBarHeight = mq.padding.bottom;

*/
