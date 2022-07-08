///  jh_button.dart
///
///  Created by iotjin on 2020/03/18.
///  description:  登录/提交 按钮

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

const double _fontSize = 18.0; // 文字大小
const double _borderWidth = 0.0; // 边框宽度
const double _borderRadius = 0.0; // 边框圆角
const Color _bgColor = KColors.kThemeColor; // 默认按钮背景色
const Color _disabledBgColor = Color(0xa03BB815); // disabled按钮背景色
const Color _textColor = Colors.white; // 默认按钮文字颜色
const Color _disabledTextColor = Colors.white54; // disabled按钮文字颜色

class JhButton extends StatelessWidget {
  const JhButton({
    Key? key,
    this.text: '',
    this.onPressed, // 传空为disabled状态
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: _fontSize)),
      style: ButtonStyle(
        // 设置按钮大小
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
        // 背景色
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled状态颜色
              return _disabledBgColor;
            }
            // 默认状态颜色
            return _bgColor;
          },
        ),
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled状态颜色
              return _disabledTextColor;
            }
            // 默认状态颜色
            return _textColor;
          },
        ),
        // 边框
        side: MaterialStateProperty.all(
          BorderSide(color: _bgColor, width: _borderWidth),
        ),
        // 圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        ),
      ),
    );
  }
}
