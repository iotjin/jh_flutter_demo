///  jh_scrollview.dart
///
///  Created by iotjin on 2023/01/28.
///  description: 可滚动视图

import 'package:flutter/material.dart';

/// web端同时使用 Scrollbar、SingleChildScrollView控制台报错: 添加ScrollController
/// https://stackoverflow.com/questions/69853729/flutter-the-scrollbars-scrollcontroller-has-no-scrollposition-attached
class JhScrollView extends StatefulWidget {
  const JhScrollView({
    Key? key,
    required this.child,
    this.controller,
  }) : super(key: key);
  final Widget child;

  final ScrollController? controller;

  @override
  State<JhScrollView> createState() => _JhScrollViewState();
}

class _JhScrollViewState extends State<JhScrollView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: _body(),
      ),
    );
  }

  _body() {
    return widget.child;
  }
}
