import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/base_web_view.dart';

/// 路由跳转工具类
class NavigatorRouterUtils {

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
        )
    );
  }

  /// 指定页面加入到路由中，然后将其他所有的页面全部pop
  static pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ), (route) => route == null
    );
  }

  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
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
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
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

}
