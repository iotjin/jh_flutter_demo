import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import 'router_init.dart';
import '404.dart';
import 'package:jh_flutter_demo/jh_common/widgets/base_web_view.dart';
import 'package:jh_flutter_demo/project/base_tabbar.dart';
import 'package:jh_flutter_demo/demos/demos_router.dart';
import 'package:jh_flutter_demo/project/login/login_router.dart';
import 'package:jh_flutter_demo/project/main_router.dart';






final String home = '/';


final String demoListsPage = 'DemoListsPage';



class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跳转错误'),
        centerTitle: true,
      ),
    );
  }
}


class Routes {

  static String home = '/home';
  static String webViewPage = '/webview';

  static final List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          debugPrint('未找到目标页');
          return PageNotFound();
        });

    router.define(home, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => BaseTabBar()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return BaseWebView(title: title, url: url);
    }));

    _listRouter.clear();
    // 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(DemosRouter());
    _listRouter.add(MainRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
