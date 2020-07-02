import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/base_web_view.dart';
import 'fluro_navigator.dart';

// 路由跳转工具类
class NavigatorUtils {
  // 跳转
  static void pushNamed(BuildContext context, String routeName) {
    return NavigatorFluroUtils.push(context, routeName);
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
