///  jh_scale_animation_view2.dart
///
///  Created by iotjin on 2023/03/25.
///  description: 缩放动画，默认缩小再还原

import 'package:flutter/material.dart';

class JhScaleAnimationView2 extends StatefulWidget {
  const JhScaleAnimationView2({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.begin = 1.0,
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
  State<JhScaleAnimationView2> createState() => _JhScaleAnimationView2State();
}

class _JhScaleAnimationView2State extends State<JhScaleAnimationView2> with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(_animationController);
    _startAnimation();
  }

  _startAnimation([isClick = false]) {
    if (widget.isAnimating || isClick) {
      _animationController.forward().then((value) {
        _animationController.reverse().then((value) {
          widget.onCompleted?.call();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startAnimation(true),
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant JhScaleAnimationView2 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      _startAnimation();
    }
  }
}
