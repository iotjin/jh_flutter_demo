///  jh_pulse_animation_view2.dart
///
///  Created by iotjin on 2023/03/25.
///  description: 跳动动画，先放大再缩小再还原

import 'package:flutter/material.dart';

class JhPulseAnimationView2 extends StatefulWidget {
  JhPulseAnimationView2({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 0),
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  @override
  State<JhPulseAnimationView2> createState() => _JhPulseAnimationView2State();
}

/// State class, where the magic happens
class _JhPulseAnimationView2State extends State<JhPulseAnimationView2> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationInc;
  late Animation<double> animationDec;
  late Animation<double> animationInc2;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);

    animationInc = Tween<double>(begin: 1, end: 1.1)
        .animate(CurvedAnimation(parent: controller!, curve: const Interval(0, 0.33, curve: Curves.easeOut)));
    animationDec = Tween<double>(begin: 1.1, end: 0.9)
        .animate(CurvedAnimation(parent: controller!, curve: const Interval(0.33, 0.67, curve: Curves.easeInOut)));
    animationInc2 = Tween<double>(begin: 0.9, end: 1)
        .animate(CurvedAnimation(parent: controller!, curve: const Interval(0.67, 1, curve: Curves.easeIn)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }
    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    /// If FALSE, animate everything back to the original state
    if (!widget.animate) {
      controller?.animateBack(0);
    }

    return AnimatedBuilder(
      animation: controller!,
      builder: (BuildContext context, Widget? child) {
        double value = controller!.value;
        if (value > 0.67) {
          value = animationInc2.value;
        } else if (value > 0.33) {
          value = animationDec.value;
        } else {
          value = animationInc.value;
        }
        return Transform.scale(
          scale: value,
          child: widget.child,
        );
      },
    );
  }
}
