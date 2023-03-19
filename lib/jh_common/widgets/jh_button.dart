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

class JhButton extends StatelessWidget {
  const JhButton({
    Key? key,
    this.text = '',
    this.onPressed, // 传空为disabled状态
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.white; // 默认按钮文字颜色
    var disabledTextColor = textColor.withOpacity(0.6); // disabled按钮文字颜色

    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    // 按钮背景色
    var bgColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    // disabled按钮背景色
    var disabledBgColor =
        KColors.dynamicColor(context, provider.getThemeColor().withOpacity(0.6), KColors.kThemeColor.withOpacity(0.6));

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // 设置按钮大小
        fixedSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        // 背景色
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled状态颜色
              return disabledBgColor;
            }
            // 默认状态颜色
            return bgColor;
          },
        ),
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled状态颜色
              return disabledTextColor;
            }
            // 默认状态颜色
            return textColor;
          },
        ),
        // 边框
        side: MaterialStateProperty.all(
          BorderSide(
              color: bgColor, width: _borderWidth, style: _borderWidth == 0 ? BorderStyle.none : BorderStyle.solid),
        ),
        // 圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: _fontSize)),
    );
  }
}
