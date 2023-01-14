// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';

class FullScreenSwiperWidget extends StatefulWidget {
  const FullScreenSwiperWidget({Key? key}) : super(key: key);

  @override
  State<FullScreenSwiperWidget> createState() => _FullScreenSwiperWidgetState();
}

class _FullScreenSwiperWidgetState extends State<FullScreenSwiperWidget> {
  final _controller = PageController();
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  final List _imgList = [
    'assets/images/newFeature/newFeature_0.jpeg',
    'assets/images/newFeature/newFeature_1.jpeg',
    'assets/images/newFeature/newFeature_2.jpeg',
    'assets/images/newFeature/newFeature_3.jpeg',
  ];

  final List<Widget> _imgWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var value in _imgList) {
//      print(value);
      _imgWidgets.add(Image.asset(value, fit: BoxFit.fill, width: double.infinity, height: double.infinity));
      // _imgWidgets.add(Image.network(value, fit: BoxFit.fill, width: double.infinity, height: double.infinity));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildWidget
    return Stack(
      children: <Widget>[
        //pageViw
        PageView.builder(
          itemBuilder: (context, index) {
            return _imgWidgets[index];
          },
          itemCount: _imgWidgets.length,
          scrollDirection: Axis.horizontal,
          reverse: false,
          controller: _controller,
//          PageController(
//            // 默认在第几个
//            initialPage: 0,
//            // 占屏幕多少，1为占满整个屏幕
//            viewportFraction: 1,
//            // 是否保存当前 Page 的状态，如果保存，下次回复保存的那个 page，initialPage被忽略，
//            // 如果为 false 。下次总是从 initialPage 开始。
//            keepPage: true,
//          ),
          physics: const BouncingScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            // 监听事件
            print('index=====$index');
          },
        ),
        // 圆点指示器
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: DotsIndicator(
                controller: _controller,
                itemCount: _imgWidgets.length,
                onPageSelected: (int page) {
                  _controller.animateToPage(page, duration: _kDuration, curve: _kCurve);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    super.key,
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.red,
  }) : super(listenable: controller!);

  /// The PageController that this DotsIndicator is representing.
  final PageController? controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller!.page ?? controller!.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedNess;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
