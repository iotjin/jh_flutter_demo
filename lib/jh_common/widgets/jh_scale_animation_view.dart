///  jh_scale_animation_view.dart
///
///  Created by iotjin on 2023/03/25.
///  description: 缩放动画，默认放大再还原

import 'package:flutter/material.dart';

class JhScaleAnimationView extends StatefulWidget {
  const JhScaleAnimationView({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.begin = 1.0,
    this.end = 1.1,
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
  State<JhScaleAnimationView> createState() => _JhScaleAnimationViewState();
}

class _JhScaleAnimationViewState extends State<JhScaleAnimationView> with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          widget.onCompleted?.call();
        }
      });
    _startAnimation();
  }

  _startAnimation([isClick = false]) {
    if (widget.isAnimating || isClick) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startAnimation(true),
      child: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant JhScaleAnimationView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      _startAnimation();
    }
  }
}
