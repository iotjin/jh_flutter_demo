import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class BaseWebView extends StatefulWidget {

  const BaseWebView({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  _BaseWebViewState createState() => _BaseWebViewState();
}

class _BaseWebViewState extends State<BaseWebView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              if (snapshot.hasData) {
                bool canGoBack = await snapshot.data.canGoBack();
                if (canGoBack) {
                  // 网页可以返回时，优先返回上一页
                  snapshot.data.goBack();
                  return Future.value(false);
                }
                return Future.value(true);
              }
              return Future.value(true);
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title,style: TextStyle(fontSize: 18.0,color: Colors.white)),
                ),
                body: WebView(
                  //要显示的url
                  initialUrl: widget.url,
                  //JS执行模式 是否允许JS执行
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                )
            ),
          );
        }
    );
  }

}
