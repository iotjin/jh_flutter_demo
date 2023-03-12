///  jh_swiper_view.dart
///
///  Created by iotjin on 2023/03/12.
///  description:  轮播图(全屏、缩放)

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'jh_network_image.dart';

/// 点击回调，返回当前索引和所有图片数组
typedef _ClickCallBack = void Function(int index, dynamic imgArr);

/// 页面切换回调，返回当前索引和所有图片数组
typedef _OnPageChanged = void Function(int index, dynamic imgArr);

class JhSwiperView extends StatefulWidget {
  const JhSwiperView({
    Key? key,
    required this.data,
    this.scrollDirection = Axis.horizontal,
    this.height,
    this.aspectRatio = 2.0,
    this.viewportFraction = 0.8,
    this.enlargeCenterPage = true,
    this.loop = true,
    this.autoPlay = true,
    this.autoPlayInterval = 3,
    this.initialPage = 0,
    this.options,
    this.margin = const EdgeInsets.all(0),
    this.radius = 10,
    this.isShowIndicator = false,
    this.isLastHiddenIndicator = false,
    this.indicatorBottomMargin = 10,
    this.itemBuilder,
    this.clickCallBack,
    this.onPageChanged,
  }) : super(key: key);

  final List data; // 图片数组(本地或网络图片路径)
  final Axis scrollDirection; // 滚动方向
  final double? height; // 高度
  final double aspectRatio; // 纵横比，默认2.0，carousel_slider默认 16 / 9,
  final double viewportFraction; // 视窗比例
  final bool enlargeCenterPage; // 放大中心页
  final bool loop; // 无限轮播
  final bool autoPlay; // 自动翻页
  final int autoPlayInterval; // 自动翻页时间：3秒
  final int initialPage; // 默认索引
  final CarouselOptions? options; // 自定义配置，使用后上面的默认配置失效
  final EdgeInsetsGeometry margin; // 四周外边距
  final double radius; // 圆角
  final bool isShowIndicator; // 是否显示底部指示器
  final bool isLastHiddenIndicator; // 如果切换到最后一个，是否隐藏指示器，默认不隐藏
  final double indicatorBottomMargin; // 指示器离底部的距离
  final IndexedWidgetBuilder? itemBuilder; // 自定义样式，使用后默认样式失效
  final _ClickCallBack? clickCallBack;
  final _OnPageChanged? onPageChanged;

  @override
  State<JhSwiperView> createState() => _JhSwiperViewState();
}

class _JhSwiperViewState extends State<JhSwiperView> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  _body(context) {
    var swiperView = CarouselSlider(
      // items: widget.data.map((item) => _itemWidget(item)).toList(),
      items: widget.data.map((item) {
        if (widget.itemBuilder != null) {
          return widget.itemBuilder!(context, _currentIndex);
        } else {
          return _itemWidget(item);
        }
      }).toList(),
      carouselController: _controller,
      options: widget.options ?? _getOptions(),
    );

    if (widget.isShowIndicator) {
      return Stack(
        children: <Widget>[
          // swiperView
          swiperView,
          // 圆点指示器
          Positioned(bottom: 0.0, left: 0.0, right: 0.0, child: _dotsIndicator()),
        ],
      );
    } else {
      return swiperView;
    }
  }

  _getOptions() {
    return CarouselOptions(
      height: widget.height,
      scrollDirection: widget.scrollDirection,
      aspectRatio: widget.aspectRatio,
      viewportFraction: widget.viewportFraction,
      enlargeCenterPage: widget.enlargeCenterPage,
      initialPage: widget.initialPage,
      enableInfiniteScroll: widget.loop,
      autoPlay: widget.autoPlay,
      autoPlayInterval: Duration(seconds: widget.autoPlayInterval),
      onPageChanged: (index, reason) {
        setState(() {
          _currentIndex = index;
          widget.onPageChanged?.call(_currentIndex, widget.data);
        });
      },
    );
  }

  Widget _itemWidget(imgURL) {
    Widget imageWidget =
        imgURL.startsWith('http') ? JhNetworkImage(imgURL, fit: BoxFit.fill) : Image.asset(imgURL, fit: BoxFit.fill);

    return GestureDetector(
      onTap: () => widget.clickCallBack?.call(_currentIndex, widget.data),
      child: Container(
        margin: widget.margin,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: imageWidget,
        ),
      ),
    );
  }

  _dotsIndicator() {
    var size = 8.0;
    var activeSize = 10.0;
    var color = Colors.grey;
    var activeColor = Colors.white;

    var dotsIndicator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.data.asMap().entries.map((entry) {
        var isActive = _currentIndex == entry.key;
        var isLast = _currentIndex == widget.data.length - 1;
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: isActive ? activeSize : size,
            height: isActive ? activeSize : size,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (widget.data.length == 1 || (isLast && widget.isLastHiddenIndicator == true))
                  ? Colors.transparent
                  : (isActive ? activeColor : color),
            ),
          ),
        );
      }).toList(),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: widget.indicatorBottomMargin),
          child: dotsIndicator,
        )
      ],
    );
  }
}
