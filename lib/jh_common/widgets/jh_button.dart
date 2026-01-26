///  jh_button.dart
///
///  Created by iotjin on 2020/03/18.
///  description:  登录/提交 按钮

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const double _fontSize = 18.0; // 文字大小
const double _borderWidth = 0.0; // 边框宽度
const double _borderRadius = 5.0; // 边框圆角
const Color _textColor = Colors.white; // 文字颜色

class JhButton extends StatelessWidget {
  const JhButton({
    Key? key,
    this.text = '',
    this.fixedSize,
    this.minimumSize = const Size(double.infinity, 48),
    this.fontSize = _fontSize,
    this.textColor = _textColor,
    this.borderWidth = _borderWidth,
    this.borderRadius = _borderRadius,
    this.fontWeight,
    this.onPressed, // 传空为disabled状态
  }) : super(key: key);

  final String text;
  final Size? fixedSize;
  final Size minimumSize;
  final double fontSize;
  final Color textColor;
  final FontWeight? fontWeight;
  final double borderWidth;
  final double borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // var textColor = Colors.white; // 默认按钮文字颜色
    var disabledTextColor = textColor.withValues(alpha: 0.6); // disabled按钮文字颜色

    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    // 按钮背景色
    var bgColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    // disabled按钮背景色
    var disabledBgColor = KColors.dynamicColor(context, provider.getThemeColor().withValues(alpha: 0.6), KColors.kThemeColor.withValues(alpha: 0.6));

    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          // overflow: TextOverflow.visible,
        ),
      ),
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
        // 设置按钮大小
        fixedSize: WidgetStateProperty.all(fixedSize),
        minimumSize: WidgetStateProperty.all(minimumSize),
        // 背景色
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              // disabled状态颜色
              return disabledBgColor;
            }
            // 默认状态颜色
            return bgColor;
          },
        ),
        // 文字颜色
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              // disabled状态颜色
              return disabledTextColor;
            }
            // 默认状态颜色
            return textColor;
          },
        ),
        // 边框
        side: WidgetStateProperty.all(
          BorderSide(color: bgColor, width: _borderWidth, style: _borderWidth == 0 ? BorderStyle.none : BorderStyle.solid),
        ),
        // 圆角
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        ),
      ),
    );
  }
}
