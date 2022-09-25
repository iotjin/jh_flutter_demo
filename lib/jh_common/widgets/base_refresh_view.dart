///  base_refresh_view.dart
///
///  Created by iotjin on 2022/09/22.
///  description: EasyRefresh封装

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '/http/dio_utils.dart';
import '/http/http_utils.dart';
import '/jh_common/widgets/jh_empty_view.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

/// 父组件中调用 globalKeyRefresh.currentState.jhRequestData()
/// 初始化调用要延时加载
GlobalKey<BaseRefreshViewState> globalKeyRefresh = GlobalKey();

class BaseRefreshView extends StatefulWidget {
  const BaseRefreshView({
    Key? key,
    required this.data,
    this.limit = 15,
    this.itemBuilder,
    this.separatorBuilder,
    this.onRefresh,
    this.onLoad,
    this.firstRefresh = false,
    this.header,
    this.footer,
    this.child,
    this.empty,
    this.controller,
  }) : super(key: key);

  final List data; // 数据
  final int limit; // 分页条数，为了控制上拉加载完成显示状态
  final IndexedWidgetBuilder? itemBuilder; // listview子组件内的itemBuilder
  final IndexedWidgetBuilder? separatorBuilder; // listview子组件内的separatorBuilder
  final FutureOr Function()? onRefresh; // 刷新回调(null为不开启下拉刷新)
  final FutureOr Function()? onLoad; // 加载回调(null为不开启上拉加载)
  final bool firstRefresh; // 首次刷新
  final Header? header; // 不传使用默认header
  final Footer? footer; // 不传使用默认footer
  final Widget? child; // 自定义子组件, 优先级高于itemBuilder,使用后itemBuilder失效
  final Widget? empty; // 空视图
  final EasyRefreshController? controller; // EasyRefresh controller

  @override
  State<BaseRefreshView> createState() => BaseRefreshViewState();
}

class BaseRefreshViewState<T extends BaseRefreshView> extends State<T> {
  bool _isNetWorkError = false;
  EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return EasyRefresh(
      controller: _controller,
      header: widget.header ?? _defaultHeader(),
      footer: widget.footer ?? _defaultFooter(),
      refreshOnStart: widget.firstRefresh,
      onRefresh: widget.onRefresh,
      onLoad: widget.data.length == 0 ? null : widget.onLoad,
      child: widget.child ?? _defaultChild(),
    );
  }

  _defaultChild() {
    if (widget.data.length == 0) {
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => widget.empty ?? _emptyWidget(),
      );
    } else {
      return ListView.separated(
        itemCount: widget.data.length,
        itemBuilder: widget.itemBuilder!,
        separatorBuilder: widget.separatorBuilder!,
      );
    }
  }

  _defaultHeader() {
    return ClassicHeader(
      dragText: '下拉刷新',
      armedText: '释放刷新',
      readyText: '加载中...',
      processingText: '加载中...',
      processedText: '加载完成',
      noMoreText: '没有更多',
      failedText: '加载失败',
      messageText: '最后更新于 %T',
    );
  }

  _defaultFooter() {
    return ClassicFooter(
      dragText: '上拉加载',
      armedText: '释放刷新',
      readyText: '加载中...',
      processingText: '加载中...',
      processedText: '加载完成',
      noMoreText: '没有更多',
      failedText: '加载失败',
      messageText: '最后更新于 %T',
      showMessage: false, // 隐藏更新时间
    );
  }

  _emptyWidget() {
    if (_isNetWorkError) {
      return JhEmptyView(
        type: EmptyType.error,
        clickCallBack: () async => _controller.callRefresh(),
      );
    }
    return JhEmptyView();
  }

  /// 网络请求
  void jhRequestData(String url, Map<String, dynamic>? params,
      {Method method = Method.post, String? loadingText, isLoadMore = false, Success? success, Fail? fail}) {
    HttpUtils.request(method, url, params, loadingText: loadingText, success: (res) {
      setState(() {
        _isNetWorkError = false;
      });
      _handleRefresh(isLoadMore);
      success?.call(res);
    }, fail: (code, msg) {
      setState(() {
        _isNetWorkError = true;
      });
      _handleRefresh(isLoadMore);
      fail?.call(code, msg);
    });
  }

  void _handleRefresh(isLoadMore) {
    if (widget.controller == null) {
      if (isLoadMore) {
        if (widget.onLoad != null) {
          _controller.finishLoad(widget.data.length == widget.limit ? IndicatorResult.success : IndicatorResult.noMore);
        }
      } else {
        // if (widget.onRefresh != null) {
        //   _controller.finishRefresh();
        // }
        if (widget.onLoad != null) {
          _controller.resetFooter();
        }
      }
    }
  }

  /// 设置EasyRefresh的默认样式
  // ignore: unused_element
  void _initEasyRefresh() {
    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
            dragText: 'Pull to refresh',
            armedText: 'Release ready',
            readyText: 'Refreshing...',
            processingText: 'Refreshing...',
            processedText: 'Succeeded',
            noMoreText: 'No more',
            failedText: 'Failed',
            messageText: 'Last updated at %T',
          );
      EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
            dragText: 'Pull to load',
            armedText: 'Release ready',
            readyText: 'Loading...',
            processingText: 'Loading...',
            processedText: 'Succeeded',
            noMoreText: 'No more',
            failedText: 'Failed',
            messageText: 'Last updated at %T',
          );
    });
  }
}
