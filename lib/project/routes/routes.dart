///  routes.dart
///
///  Created by iotjin on 2020/03/18.
///  description: 路由管理

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_init.dart';
import 'not_found_page.dart';
import '/jh_common/widgets/base_web_view.dart';
import '/project/base_tabbar.dart';
import '/project/login/login_router.dart';
import '/project/main_router.dart';
import '/demos/demos_router.dart';

class Routes {
  static String pHome = '/home';
  static String pWebViewPage = '/webView';
  static String pDemoListPage = 'DemoListPage';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return const NotFoundPage();
    });

    router.define(pHome,
        handler: Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>const BaseTabBar()));

    router.define(pWebViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return BaseWebView(title: title, url: url);
    }));

    _listRouter.clear();

    // 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(DemosRouter());
    _listRouter.add(MainRouter());

    /// 初始化路由
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }

    _listRouter.forEach(initRouter);
  }
}
