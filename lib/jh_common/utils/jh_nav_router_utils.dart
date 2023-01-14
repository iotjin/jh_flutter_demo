///  jh_monitor_network_utils.dart
///
///  Created by iotjin on 2020/03/27.
///  description:  路由跳转工具类（原生封装）

import 'package:flutter/material.dart';
import '/jh_common/widgets/base_web_view.dart';

/// 更推荐使用jh_nav_utils
class JhNavRouterUtils {
  /// 跳转
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 替换页面 当新的页面进入后，之前的页面将执行dispose方法
  static pushReplacement(BuildContext context, Widget scene) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ));
  }

  /// 指定页面加入到路由中，然后将其他所有的页面全部pop
  static pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ),
        (route) => false);
  }

  ///  跳转 - 带回调参数
  static pushNamedResult(BuildContext context, Widget scene, Function(dynamic) function) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {});
  }

  /// 返回
  static void goBack(BuildContext context) {
    unFocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    unFocus();
    Navigator.pop(context, result);
  }

  /// 跳到WebView页
  static jumpWebViewPage(BuildContext context, String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BaseWebView(title: title, url: url),
      ),
    );

//    Navigator.of(context)
//        .push(new MaterialPageRoute(builder: (_) {
//      return WebViewPage(title:'作者博客', url: 'https://blog.csdn.net/iotjin');
//
//    }));
  }

  static void unFocus() {
    /// 使用下面的方式，会触发不必要的build。
    /// FocusScope.of(context).unFocus();
    /// https://blog.csdn.net/iotjin
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
