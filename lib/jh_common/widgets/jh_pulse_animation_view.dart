///  jh_pulse_animation_view.dart
///
///  Created by iotjin on 2023/03/25.
///  description: 跳动动画，先放大再缩小再还原

import 'package:flutter/material.dart';

class JhPulseAnimationView extends StatefulWidget {
  const JhPulseAnimationView({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.begin = 1.1,
    this.end = 0.9,
    this.isAnimating = false,
    this.onCompleted,
  }) : super(key: key);

  final Widget child; // 点击child自身触发动画(方式一)
  final Duration duration;
  final double begin;
  final double end;
  final bool isAnimating; // 为true触发动画(方式二)
  final Function? onCompleted;

  @override
  State<JhPulseAnimationView> createState() => _JhPulseAnimationViewState();
}

class _JhPulseAnimationViewState extends State<JhPulseAnimationView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  _init() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: widget.begin), weight: 1),
      TweenSequenceItem(tween: Tween(begin: widget.begin, end: widget.end), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: widget.end, end: 1), weight: 1),
    ]).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _startAnimation();
  }

  _startAnimation([isClick = false]) {
    if (widget.isAnimating || isClick) {
      _animationController.forward().then((value) {
        _animationController.reset();
        widget.onCompleted?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startAnimation(true),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _animation.value,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant JhPulseAnimationView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      _startAnimation();
    }
  }
}

/*

Flutter的 AnimationStatus 枚举类型定义了动画的四种状态(begin: 0.0, end: 1.0时)：

  1. dismissed：动画已经停止，并且值已经回到初始状态。即动画的值为0.0。
  2. forward：动画正在正向播放。即动画的值从0.0逐渐增加到1.0。（正向运行）
  3. reverse：动画正在反向播放。即动画的值从1.0逐渐减少到0.0。（反向运行）
  4. completed：动画已经停止，并且值已经达到最终状态。即动画的值为1.0。


  动画的控制方法：
    forward：正向执行动画。
    reverse：反向执行动画。
    repeat：反复执行动画。
    reset：重置动画。


Flutter中常见的 Curve 类型有以下几种：
    https://cubic-bezier.com/

    Curves.linear：线性动画曲线，即匀速运动，适用于需要匀速移动的场景。
    Curves.ease：默认的缓动动画曲线，适用于大部分场景。
    Curves.easeIn：快速进入动画曲线，适用于需要快速进入的场景，如按钮点击等。
    Curves.easeOut：快速退出动画曲线，适用于需要快速退出的场景，如弹窗关闭等。
    Curves.easeInOut：快速进入并快速退出动画曲线，适用于需要快速进入并快速退出的场景，如页面切换等。
    Curves.fastLinearToSlowEaseIn：快速匀速运动然后慢速进入动画曲线，适用于需要快速匀速运动然后慢速进入的场景，如列表滚动等。
    Curves.bounceIn：弹性进入动画曲线，适用于需要弹性进入的场景，如弹窗出现等。
    Curves.bounceOut：弹性退出动画曲线，适用于需要弹性退出的场景，如弹窗关闭等。
    Curves.elasticIn：弹性进入动画曲线，适用于需要弹性进入的场景，如下拉刷新等。
    Curves.elasticOut：弹性退出动画曲线，适用于需要弹性退出的场景，如列表滑动到底部等。

    不同的 Curve 类型适用于不同的场景，根据具体的需求来选择合适的 Curve 类型可以让动画效果更加自然和流畅。
    例如，如果需要实现一个快速进入的按钮点击效果，可以选择 Curves.easeIn；
    如果需要实现一个缓慢的列表滚动效果，可以选择 Curves.fastLinearToSlowEaseIn；
    如果需要实现一个弹性出现的弹窗效果，可以选择 Curves.bounceIn 等。


    AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isAnimating ? 200 : 100,
      height: isAnimating ? 200 : 100,
      color: Colors.red,
    )

* */
