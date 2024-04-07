///  base_web_view.dart
///
///  Created by iotjin on 2020/03/27.
///  description:  WebView基类

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/jh_common/utils/jh_nav_router_utils.dart';
import '/base_appbar.dart';

class BaseWebView extends StatefulWidget {
  const BaseWebView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  State<BaseWebView> createState() => _BaseWebViewState();
}

class _BaseWebViewState extends State<BaseWebView> {
  late final WebViewController _controller;
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (!mounted) {
              return;
            }
            setState(() {
              _progressValue = progress;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return PopScope(
      canPop: false, // false表示拦截物理按键，true不拦截
      onPopInvoked: (didPop) async {
        // 不管canPop是否为true，onPopInvoked都会调用
        if (didPop) return;
        final bool canGoBack = await _controller.canGoBack();
        if (canGoBack) {
          // 网页可以返回时，优先返回上一页
          await _controller.goBack();
          return;
        }
        if (!context.mounted) return;
        JhNavRouterUtils.goBack(context);
      },
      child: Scaffold(
        appBar: BaseAppBar(widget.title),
        body: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
            ),
            if (_progressValue != 100)
              LinearProgressIndicator(
                value: _progressValue / 100,
                backgroundColor: Colors.transparent,
                minHeight: 2,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
