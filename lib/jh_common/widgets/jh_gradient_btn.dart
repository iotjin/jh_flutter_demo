/**
 *  jh_gradient_btn.dart
 *
 *  Created by iotjin on 2020/02/07.
 *  description:  渐变色按钮
 */

import 'package:flutter/material.dart';

const Color startColor = Color(0xFF2683BE); // 默认appBar 渐变开始色
const Color endColor = Color(0xFF34CABE); // 默认appBar 渐变结束色

class JhGradientBtn extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final GestureTapCallback? onTap;

  JhGradientBtn({
    required this.text,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: this.width == null ? 150 : this.width,
        height: this.height == null ? 50 : this.height,
        child: Center(
            child: Text(this.text,
                style: TextStyle(fontSize: 20, color: Colors.white))),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              startColor, // 渐变 开始色
              endColor, // 结束色
            ],
          ),
        ),
      ),
      onTap: this.onTap,
    );
  }
}
