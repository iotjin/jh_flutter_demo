/**
 *  jh_nav_fluro_utils.dart
 *
 *  Created by iotjin on 2020/08/14.
 *  description: 路由跳转工具类（基于fluro路由封装）
 */

import 'routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/base_web_view.dart';

enum JumpType {
  native,
  nativeModal,
  left,
  bottom,
  fadeIn,
}

/// 路由跳转工具类
class JhNavFluroUtils {
  // 跳转
  static void pushNamed(BuildContext context, String routeName,
      {transition: JumpType.native}) {
    TransitionType type = TransitionType.native;

    if (transition == JumpType.nativeModal) {
      type = TransitionType.nativeModal;
    }
    if (transition == JumpType.left) {
      type = TransitionType.inFromRight;
    }
    if (transition == JumpType.bottom) {
      type = TransitionType.inFromBottom;
    }
    if (transition == JumpType.fadeIn) {
      type = TransitionType.fadeIn;
    }
    return _NavFluroUtils.push(context, routeName, transition: type);
  }

  // 跳转 清空栈
  static void pushReplacement(BuildContext context, String routeName) {
    return _NavFluroUtils.push(context, routeName,
        replace: true, clearStack: true);
  }

  // 跳转 - 带回调
  static void pushNamedResult(
      BuildContext context, String routeName, Function(Object) function) {
    _NavFluroUtils.pushResult(context, routeName, (result) {
      function(result);
    });
  }

  // 返回
  static void goBack(BuildContext context) {
    _NavFluroUtils.goBack(context);
  }

  // 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    _NavFluroUtils.goBackWithParams(context, result);
  }

  // 跳到WebView页
  static jumpWebViewPage(BuildContext context, String title, String url) {
    _NavFluroUtils.goWebViewPage(context, title, url);
  }

  static void unfocus() {
    _NavFluroUtils.unfocus();
  }
}

/// fluro的路由跳转工具类
class _NavFluroUtils {
  static void push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      transition: TransitionType.native}) {
    unfocus();
    Routes.router.navigateTo(context, path,
        replace: replace, clearStack: clearStack, transition: transition);
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Routes.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((Object? result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  /// 跳到WebView页
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://blog.csdn.net/iotjin
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
