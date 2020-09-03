/**
 *  navigator_utils.dart
 *
 *  Created by iotjin on 2020/08/14.
 *  description: 路由跳转工具类
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/base_web_view.dart';
import 'fluro_navigator.dart';

enum JumpType {
  native,
  nativeModal,
  left,
  bottom,
  fadeIn,
}

// 路由跳转工具类
class NavigatorUtils {
  // 跳转
  static void pushNamed(BuildContext context, String routeName,{transition: JumpType.native}) {
    TransitionType type = TransitionType.native;

    if(transition == JumpType.nativeModal ){
      type = TransitionType.nativeModal;
    }
    if(transition == JumpType.left ){
      type = TransitionType.inFromRight;
    }
    if(transition == JumpType.bottom ){
      type = TransitionType.inFromBottom;
    }
    if(transition == JumpType.fadeIn ){
      type = TransitionType.fadeIn;
    }
    return NavigatorFluroUtils.push(context, routeName, transition:type);
  }

  // 跳转 清空栈
  static void pushReplacement(BuildContext context, String routeName) {
    return NavigatorFluroUtils.push(context, routeName,replace: true,clearStack: true);
  }

  // 跳转 - 带回调
  static void pushNamedResult(
      BuildContext context, String routeName, Function(Object) function) {
    NavigatorFluroUtils.pushResult(context, routeName, (result) {
      function(result);
    });
  }

  // 返回
  static void goBack(BuildContext context) {
    NavigatorFluroUtils.goBack(context);
  }

  // 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    NavigatorFluroUtils.goBackWithParams(context, result);
  }

  // 跳到WebView页
  static jumpWebViewPage(BuildContext context, String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BaseWebView(title: title, url: url),
      ),
    );
  }
}
