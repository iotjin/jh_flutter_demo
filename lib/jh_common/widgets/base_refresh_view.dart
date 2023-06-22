///  base_refresh_view.dart
///
///  Created by iotjin on 2022/09/22.
///  description: EasyRefresh封装，支持骨架屏、设置header、footer、空数据与网络异常处理

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/http/dio_utils.dart';
import '/http/http_utils.dart';
import '/jh_common/widgets/jh_empty_view.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

/// 默认刷新样式(easy_refresh的Header和Footer样式)
enum RefreshType {
  classic,
  material,
  bezier,
  cupertino,
  delivery,
}

/// 父组件中调用 globalKeyRefresh.currentState.jhRequestData()
/// 初始化调用要延时加载
GlobalKey<BaseRefreshViewState> globalKeyRefresh = GlobalKey();

class BaseRefreshView extends StatefulWidget {
  const BaseRefreshView({
    Key? key,
    required this.data,
    this.limit = 15,
    this.enableShimmer = false,
    this.shimmerView,
    this.headerView,
    this.footerView,
    this.child,
    this.itemBuilder,
    this.separatorBuilder,
    this.onRefresh,
    this.onLoad,
    this.firstRefresh = false,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.footer,
    this.refreshType = RefreshType.classic,
    this.emptyText = '暂无数据',
    this.empty,
    this.controller,
  }) : super(key: key);

  final List data; // 数据
  final int limit; // 分页条数，为了控制上拉加载完成显示状态
  final bool enableShimmer; // 是否使用骨架屏，默认不使用，开启后初始化请求会显示骨架屏(需要设置shimmerView)
  final Widget? shimmerView; // 骨架屏view
  final Widget? headerView; // 头部view(跟随滚动)，设置后子组件要禁止滚动
  final Widget? footerView; // 尾部view(跟随滚动)，设置后子组件要禁止滚动
  final Widget? child; // 自定义子组件, 优先级高于itemBuilder，使用后itemBuilder失效
  final IndexedWidgetBuilder? itemBuilder; // listview子组件内的itemBuilder
  final IndexedWidgetBuilder? separatorBuilder; // listview子组件内的separatorBuilder
  final FutureOr Function()? onRefresh; // 刷新回调(null为不开启下拉刷新)
  final FutureOr Function()? onLoad; // 加载回调(null为不开启上拉加载)
  final bool firstRefresh; // 首次刷新
  final Header? header; // 不传使用默认header，优先级高于refreshType
  final EdgeInsetsGeometry? padding;
  final Footer? footer; // 不传使用默认footer，优先级高于refreshType
  final RefreshType refreshType; // 默认刷新样式(easy_refresh的header、footer样式)
  final String emptyText; // 空视图文字
  final Widget? empty; // 自定义空视图，优先级高于emptyText，设置后emptyText失效
  final EasyRefreshController? controller; // EasyRefresh controller

  @override
  State<BaseRefreshView> createState() => BaseRefreshViewState();
}

class BaseRefreshViewState<T extends BaseRefreshView> extends State<T> {
  bool _isNetWorkError = false;
  bool _isShowShimmer = false;
  EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? _controller;
    _isShowShimmer = widget.enableShimmer;
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
      onRefresh: _isShowShimmer ? null : widget.onRefresh,
      onLoad: widget.data.isEmpty ? null : widget.onLoad,
      child: _listView(),
    );
  }

  _listView() {
    if (_isShowShimmer && widget.shimmerView != null) {
      return widget.shimmerView;
    }

    Widget child;
    if (widget.headerView == null && widget.footerView == null) {
      child = _defaultChild(false);
    } else {
      child = ListView(
        children: <Widget>[
          widget.headerView ?? Container(),
          _defaultChild(true),
          widget.footerView ?? Container(),
        ],
      );
    }

    return child;
  }

  _defaultChild(bool hasHeaderOrFooter) {
    if (widget.data.isEmpty) {
      if (hasHeaderOrFooter) {
        return widget.empty ?? _emptyWidget();
      }
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => widget.empty ?? _emptyWidget(),
      );
    } else {
      // 如果使用自定义子组件，优先自定义组件
      if (widget.child != null) {
        return widget.child;
      }
      return ListView.separated(
        // 取消footer和cell之间的空白
        padding: widget.padding,
        shrinkWrap: hasHeaderOrFooter,
        physics: hasHeaderOrFooter ? const NeverScrollableScrollPhysics() : null,
        itemCount: widget.data.length,
        itemBuilder: widget.itemBuilder!,
        separatorBuilder: widget.separatorBuilder!,
      );
    }
  }

  _emptyWidget() {
    if (_isNetWorkError) {
      return JhEmptyView(
        type: EmptyType.error,
        clickCallBack: () async => _controller.callRefresh(),
      );
    }
    return JhEmptyView(text: widget.emptyText);
  }

  _defaultHeader() {
    switch (widget.refreshType) {
      case RefreshType.material:
        return const MaterialHeader(triggerOffset: 60, clamping: false, showBezierBackground: false);
      case RefreshType.bezier:
        return const BezierHeader(
          triggerOffset: 60,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          // 固定
          clamping: false,
          // 显示小球
          showBalls: false,
          // 弹簧回弹
          springRebound: false,
          spinWidget: SpinKitThreeBounce(size: 35, color: Colors.blue),
          onlySpin: true,
          processedDuration: Duration(milliseconds: 100),
        );
      case RefreshType.cupertino:
        return const CupertinoHeader();
      case RefreshType.delivery:
        return const DeliveryHeader();
      default:
        return const ClassicHeader(
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
  }

  _defaultFooter() {
    switch (widget.refreshType) {
      case RefreshType.material:
        return const MaterialFooter(triggerOffset: 60, clamping: false, showBezierBackground: false);
      case RefreshType.bezier:
        return const BezierFooter(
          triggerOffset: 60,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          // 固定
          clamping: false,
          // 显示小球
          showBalls: false,
          // 弹簧回弹
          springRebound: false,
          spinWidget: SpinKitThreeBounce(size: 35, color: Colors.blue),
          onlySpin: true,
          processedDuration: Duration(milliseconds: 100),
        );
      case RefreshType.cupertino:
        return const CupertinoFooter(position: IndicatorPosition.locator);
      case RefreshType.delivery:
        return const DeliveryFooter();
      default:
        return const ClassicFooter(
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
  }

  /// 网络请求
  void jhRequestData(String url, Map<String, dynamic>? params,
      {Method method = Method.post, String? loadingText, isLoadMore = false, Success? success, Fail? fail}) {
    HttpUtils.request(method, url, params, loadingText: loadingText, success: (res) {
      // TODO: 项目中分页都用的同一个接口，所以上拉加载完成状态判断按同一种方式处理
      var tempData = res['data'];
      setState(() {
        _isShowShimmer = false;
        _isNetWorkError = false;
      });
      _handleRefresh(isLoadMore, tempData);
      success?.call(res);
    }, fail: (code, msg) {
      setState(() {
        _isShowShimmer = false;
        _isNetWorkError = true;
      });
      _handleRefresh(isLoadMore, []);
      fail?.call(code, msg);
    });
  }

  void _handleRefresh(isLoadMore, List tempData) {
    if (widget.controller == null) {
      if (isLoadMore) {
        if (widget.onLoad != null) {
          _controller.finishLoad(tempData.length == widget.limit ? IndicatorResult.success : IndicatorResult.noMore);
        }
      } else {
        if (widget.onRefresh != null) {
          _controller.finishRefresh();
        }
        if (widget.onLoad != null) {
          _controller.resetFooter();
        }
      }
    }
  }
}

/// 设置EasyRefresh的默认样式
// ignore: unused_element
void initEasyRefresh({isChinese = true}) {
  const classicHeaderChinese = ClassicHeader(
    dragText: '下拉刷新',
    armedText: '释放刷新',
    readyText: '加载中...',
    processingText: '加载中...',
    processedText: '加载完成',
    noMoreText: '没有更多',
    failedText: '加载失败',
    messageText: '最后更新于 %T',
  );

  const classicFooterChinese = ClassicFooter(
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

  const classicHeaderEnglish = ClassicHeader(
    dragText: 'Pull to refresh',
    armedText: 'Release ready',
    readyText: 'Refreshing...',
    processingText: 'Refreshing...',
    processedText: 'Succeeded',
    noMoreText: 'No more',
    failedText: 'Failed',
    messageText: 'Last updated at %T',
  );

  const classicFooterEnglish = ClassicFooter(
    dragText: 'Pull to load',
    armedText: 'Release ready',
    readyText: 'Loading...',
    processingText: 'Loading...',
    processedText: 'Succeeded',
    noMoreText: 'No more',
    failedText: 'Failed',
    messageText: 'Last updated at %T',
    showMessage: false, // 隐藏更新时间
  );

  SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
    // 设置EasyRefresh的默认样式
    EasyRefresh.defaultHeaderBuilder = () => isChinese ? classicHeaderChinese : classicHeaderEnglish;
    EasyRefresh.defaultFooterBuilder = () => isChinese ? classicFooterChinese : classicFooterEnglish;
  });
}
