///  jh_count_down_btn.dart
///
///  Created by iotjin on 2020/04/07.
///  description:  倒计时按钮

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const String _normalText = '获取验证码'; // 默认按钮文字
const int _normalTime = 10; // 默认倒计时时间
const double _fontSize = 13.0; // 文字大小
const double _borderWidth = 0.8; // 边框宽度
const double _borderRadius = 1.0; // 边框圆角

class JhCountDownBtn extends StatefulWidget {
  const JhCountDownBtn({
    Key? key,
    this.getVCode,
    this.textColor,
    this.bgColor,
    this.fontSize = _fontSize,
    this.borderColor,
    this.borderRadius = _borderRadius,
    this.showBorder = false,
  }) : super(key: key);

  final Future<bool> Function()? getVCode;
  final Color? textColor;
  final Color? bgColor;
  final double? fontSize;
  final Color? borderColor;
  final double? borderRadius;
  final bool showBorder;

  @override
  State<JhCountDownBtn> createState() => _JhCountDownBtnState();
}

class _JhCountDownBtnState extends State<JhCountDownBtn> {
  Timer? _countDownTimer;
  String _btnStr = _normalText;
  int _countDownNum = _normalTime;

  /// 释放掉Timer
  @override
  void dispose() {
    _countDownTimer?.cancel();
    _countDownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var bgColor = Colors.transparent;
    var textColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var borderColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    // 设置的颜色优先级高于暗黑模式
    bgColor = widget.bgColor ?? bgColor;
    textColor = widget.textColor ?? textColor;
    borderColor = widget.borderColor ?? borderColor;

    if (widget.getVCode == null) {
      return Container();
    } else {
      return TextButton(
        onPressed: () => _getVCode(),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          // 设置按钮大小
          fixedSize: MaterialStateProperty.all(const Size(120, 32)),
          minimumSize: MaterialStateProperty.all(const Size(120, 32)),
          // 背景色
          backgroundColor: MaterialStateProperty.all(bgColor),
          // 文字颜色
          foregroundColor: MaterialStateProperty.all(textColor),
          // 边框
          side: widget.showBorder == false
              ? null
              : MaterialStateProperty.all(BorderSide(color: borderColor, width: _borderWidth)),
          // 圆角
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius!))),
        ),
        child: Text(_btnStr, style: TextStyle(fontSize: widget.fontSize)),
      );
    }
  }

  Future _getVCode() async {
    if (widget.getVCode != null) {
      bool isSuccess = await widget.getVCode!();
      if (isSuccess) {
        startCountdown();
      }
    }
  }

  /// 开始倒计时
  void startCountdown() {
    setState(() {
      if (_countDownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _btnStr = '重新获取(${_countDownNum--}s)';
      _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_countDownNum > 0) {
            _btnStr = '重新获取(${_countDownNum--}s)';
          } else {
            _btnStr = _normalText;
            _countDownNum = _normalTime;
            _countDownTimer?.cancel();
            _countDownTimer = null;
          }
        });
      });
    });
  }
}
