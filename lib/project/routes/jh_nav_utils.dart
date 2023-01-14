///  jh_nav_utils.dart
///
///  Created by iotjin on 2020/08/14.
///  description: 路由跳转工具类（基于fluro路由封装）

// ignore_for_file: avoid_print

import 'dart:convert';
import 'routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

enum JumpType {
  native,
  nativeModal,
  left,
  bottom,
  fadeIn,
}

/// 路由跳转工具类
class JhNavUtils {
  /// 跳转
  static void pushNamed(BuildContext context, String routeName, {Object? arguments, transition = JumpType.native}) {
    var path = routeName;
    // 对象或对象数组传值可以通过arguments字段进行传值，然后在router.define那里处理、设置页面接收
    if (arguments != null) {
      String jsonStr = Uri.encodeComponent(jsonEncode(arguments));
      path = '$routeName?jumpParams=$jsonStr';
    }

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
    return _NavFluroUtils.push(context, path, transition: type);
  }

  /// 跳转 清空栈
  static void pushReplacement(BuildContext context, String routeName) {
    return _NavFluroUtils.push(context, routeName, replace: true, clearStack: true);
  }

  /// 跳转 - 带回调参数
  static void pushNamedResult(BuildContext context, String routeName, Object? arguments, Function(dynamic) function) {
    var path = routeName;
    // 对象或对象数组传值可以通过arguments字段进行传值，然后在router.define那里处理、设置页面接收
    if (arguments != null) {
      String jsonStr = Uri.encodeComponent(jsonEncode(arguments));
      path = '$routeName?jumpParams=$jsonStr';
    }
    _NavFluroUtils.pushResult(context, path, (result) {
      function(result);
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    _NavFluroUtils.goBack(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    _NavFluroUtils.goBackWithParams(context, result);
  }

  /// 跳到WebView页
  static jumpWebViewPage(BuildContext context, String title, String url) {
    _NavFluroUtils.goWebViewPage(context, title, url);
  }

  static void unFocus() {
    _NavFluroUtils.unFocus();
  }
}

/// fluro的路由跳转工具类
class _NavFluroUtils {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, transition = TransitionType.native}) {
    unFocus();
    Routes.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: transition);
  }

  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    unFocus();
    Routes.router
        .navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native)
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
    unFocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unFocus();
    Navigator.pop<Object>(context, result);
  }

  /// 跳到WebView页
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.pWebViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unFocus() {
    /// 使用下面的方式，会触发不必要的build。
    /// FocusScope.of(context).unFocus();
    /// https://blog.csdn.net/iotjin
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/*

// 跳转传值

var jumpParams = {'a': 123};
var jumpParams2 = [{'a': 123},{'b': 456}];
JhNavUtils.pushNamed(context, 'TestPage', arguments: jumpParams2);

router.define('TestPage', handler: Handler(handlerFunc: (_, params) {
  var jumpParams = params['jumpParams']!.first;
  return TestPage(jsonDecode(jumpParams));
}));

const TestPage(this.jumpParams, {Key? key}) : super(key: key);
final dynamic jumpParams;


// 跳转传值带回调刷新

var params = dataArr[index];
JhNavUtils.pushNamedResult(context, 'TestPage', params, (returnData) {
  if (returnData['isRefresh'] == true) {
    requestData();
  }
});

JhNavUtils.goBackWithParams(context, {'isRefresh': true});

// 多级返回

Navigator.of(context)
  ..pop()
  ..pop();

JhNavUtils.goBack(context);
JhNavUtils.goBack(context);
JhNavUtils.goBackWithParams(context, {'isRefresh': true});

*/
