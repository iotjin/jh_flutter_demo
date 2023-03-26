///  jh_shake_animation_view.dart
///
///  Created by iotjin on 2023/03/25.
///  description: 抖动(位移)动画，支持上下/左右抖动，默认左右抖动

import 'package:flutter/material.dart';

enum ShakeDirection {
  horizontal,
  vertical,
}

class JhShakeAnimationView extends StatefulWidget {
  const JhShakeAnimationView({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.direction = ShakeDirection.horizontal,
    this.begin = -5,
    this.end = 5,
    this.isAnimating = false,
    this.onCompleted,
  }) : super(key: key);

  final Widget child; // 点击child自身触发动画(方式一)
  final Duration duration;
  final ShakeDirection direction;
  final double begin;
  final double end;
  final bool isAnimating; // 为true触发动画(方式二)
  final Function? onCompleted;

  @override
  State<JhShakeAnimationView> createState() => _JhShakeAnimationViewState();
}

class _JhShakeAnimationViewState extends State<JhShakeAnimationView> with SingleTickerProviderStateMixin {
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
      TweenSequenceItem(tween: Tween(begin: 0, end: widget.begin), weight: 1),
      TweenSequenceItem(tween: Tween(begin: widget.begin, end: widget.end), weight: 1),
      TweenSequenceItem(tween: Tween(begin: widget.end, end: 0), weight: 1),
    ]).animate(_animationController);
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
          var x = widget.direction == ShakeDirection.horizontal ? _animation.value : 0.0;
          var y = widget.direction == ShakeDirection.vertical ? _animation.value : 0.0;
          return Transform.translate(
            offset: Offset(x, y),
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant JhShakeAnimationView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      _startAnimation();
    }
  }
}
