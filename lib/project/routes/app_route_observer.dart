///  app_route_observer.dart
///
///  Created by iotjin on 2020/11/07.
///  description: 通过路由监听页面出现或消失

import 'package:flutter/material.dart';

class AppRouteObserver {
  /// 创建路由监听（这是实际上的路由监听器）
  static final RouteObserver<ModalRoute<void>> _routeObserver = RouteObserver<ModalRoute<void>>();

  /// 这是个单例
  static final AppRouteObserver _appRouteObserver = AppRouteObserver._internal();

  AppRouteObserver._internal();

  /// 通过单例的get方法获取路由监听器
  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }

  factory AppRouteObserver() {
    return _appRouteObserver;
  }
}

/// Flutter 如何监听当前页面 push显示/消失 pop消失/显示 https://www.jianshu.com/p/d0897a870caa

/** 使用：

    1、添加到MaterialApp的navigatorObservers中

    MaterialApp(
    .....
    navigatorObservers: [ AppRouteObserver().routeObserver ],
    ...
    )

    2、需要监听的页面进行订阅 with RouteAware
    3、添加路由订阅、取消路由订阅，和对应的监听方法（didPush、didPop、didPopNext、didPushNext）

    class _xxxPageState extends State<xxx> with RouteAware {
    ...

    @override
    void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    /// 路由订阅
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
    }

    @override
    void dispose() {
    // TODO: implement dispose
    /// 取消路由订阅
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
    }

    /// Called when the current route has been pushed.
    /// 上页面跳转当前页面 - viewWillAppear.
    @override
    void didPush() {
    print('上页面跳转当前页面 - viewWillAppear');
    }

    /// Called when the current route has been popped off.
    /// 当前页面返回上页面 - viewWillDisappear.
    @override
    void didPop() {
    print('当前页面返回上页面 - viewWillDisappear');
    }

    /// Called when the top route has been popped off, and the current route
    /// shows up.
    /// 下页面返回当前页面 - viewWillAppear.
    @override
    void didPopNext() {
    print('下页面返回当前页面 - viewWillAppear');
    }

    /// Called when a new route has been pushed, and the current route is no
    /// longer visible.
    /// 当前页面跳转下页面 - viewWillDisappear.
    @override
    void didPushNext() {
    print('当前页面跳转下页面 - viewWillDisappear');
    }

 */
