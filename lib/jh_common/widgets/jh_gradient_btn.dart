///  jh_gradient_btn.dart
///
///  Created by iotjin on 2020/02/07.
///  description:  渐变色按钮

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

const double _fontSize = 20.0; // 文字大小
const double _borderRadius = 5.0; // 边框圆角
const Color _textColor = Colors.white; // 默认按钮文字颜色
const Color startColor = KColors.kGradientStartColor; // 默认渐变开始色
const Color endColor = KColors.kGradientEndColor; // 默认渐变结束色

class JhGradientBtn extends StatelessWidget {
  const JhGradientBtn({
    Key? key,
    required this.text,
    this.width = 150,
    this.height = 50,
    this.onTap,
  }) : super(key: key);

  final String text;
  final double? width;
  final double? height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              startColor, // 渐变 开始色
              endColor, // 结束色
            ],
          ),
        ),
        child: Center(child: Text(text, style: const TextStyle(fontSize: _fontSize, color: _textColor))),
      ),
    );
  }
}
