// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_scrollview.dart';
import '/project/routes/jh_nav_utils.dart';
import '/project/routes/app_route_observer.dart';
import '/base_appbar.dart';

class RouteTestPage1 extends StatefulWidget {
  const RouteTestPage1({Key? key}) : super(key: key);

  @override
  State<RouteTestPage1> createState() => _RouteTestPage1State();
}

class _RouteTestPage1State extends State<RouteTestPage1> with RouteAware {
  dynamic _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('页面一初始化');
  }

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
    setState(() {
      _value = '上页面跳转当前页面 - viewWillAppear';
    });
    print('上页面跳转当前页面 - viewWillAppear');
  }

  /// Called when the current route has been popped off.
  /// 当前页面返回上页面 - viewWillDisappear.
  @override
  void didPop() {
    setState(() {
      _value = '当前页面返回上页面 - viewWillDisappear';
    });
    print('当前页面返回上页面 - viewWillDisappear');
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  /// 下页面返回当前页面 - viewWillAppear.
  @override
  void didPopNext() {
    setState(() {
      _value = '下页面返回当前页面 - viewWillAppear';
    });
    print('下页面返回当前页面 - viewWillAppear');
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  /// 当前页面跳转下页面 - viewWillDisappear.
  @override
  void didPushNext() {
    setState(() {
      _value = '当前页面跳转下页面 - viewWillDisappear';
    });
    print('当前页面跳转下页面 - viewWillDisappear');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('监听页面出现与消失'),
      body: _body(context),
    );
  }

  _body(context) {
    var params = {
      'passValue': '123',
      'isBool': true,
      'array': [1, 2, 3],
    };

    return JhScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Text(_value),
          const SizedBox(height: 20),
          const Text('请前往控制台查看全部输出'),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('带参数跳转带回传 - pushNamedResult'),
            onPressed: () {
              params['type'] = '1';

              JhNavUtils.pushNamedResult(context, 'PassValuePage2', params, (returnData) {
                print('回传的值====$returnData');
                if (returnData['isRefresh'] == true) {
                  _requestData();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void _requestData() {
    JhProgressHUD.showLoadingText();
    Future.delayed(const Duration(seconds: 1), () {
      JhProgressHUD.hide();
    });
  }
}
