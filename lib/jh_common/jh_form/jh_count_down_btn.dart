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
const String _resendAfterText = '重新获取'; // 重新获取文字
const int _normalTime = 10; // 默认倒计时时间
const double _fontSize = 13.0; // 文字大小
const double _borderWidth = 0.8; // 边框宽度
const double _borderRadius = 1.0; // 边框圆角

class JhCountDownBtn extends StatefulWidget {
  const JhCountDownBtn({
    Key? key,
    this.getVCode,
    this.getCodeText = _normalText,
    this.resendAfterText = _resendAfterText,
    this.countDownSeconds = _normalTime,
    this.textColor,
    this.bgColor,
    this.fontSize = _fontSize,
    this.borderColor,
    this.borderRadius = _borderRadius,
    this.showBorder = false,
  }) : super(key: key);

  final Future<bool> Function()? getVCode;
  final String getCodeText;
  final String resendAfterText;
  final int countDownSeconds;
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
  late String _btnStr;
  late int _countDownNum;

  bool get _isCountingDown => _countDownTimer != null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _btnStr = widget.getCodeText;
    _countDownNum = widget.countDownSeconds;
  }

  @override
  void didUpdateWidget(covariant JhCountDownBtn oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isCountingDown) {
      if (widget.getCodeText != oldWidget.getCodeText) {
        _btnStr = widget.getCodeText;
      }
      if (widget.countDownSeconds != oldWidget.countDownSeconds) {
        _countDownNum = widget.countDownSeconds;
      }
    }
  }

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
    final provider = Provider.of<ThemeProvider>(context, listen: false);
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
        onPressed: _isCountingDown ? null : () => _getVCode(),
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          // 设置按钮大小
          fixedSize: WidgetStateProperty.all(const Size(120, 32)),
          minimumSize: WidgetStateProperty.all(const Size(120, 32)),
          // 背景色
          backgroundColor: WidgetStateProperty.all(bgColor),
          // 文字颜色
          foregroundColor: WidgetStateProperty.all(textColor),
          // 边框
          side: widget.showBorder == false ? null : WidgetStateProperty.all(BorderSide(color: borderColor, width: _borderWidth)),
          // 圆角
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius!))),
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
      _countDownNum = widget.countDownSeconds;
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      // _btnStr = '重新获取(${_countDownNum--}s)';
      _btnStr = '${widget.resendAfterText}(${_countDownNum--}s)';
      _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_countDownNum > 0) {
            // _btnStr = '重新获取(${_countDownNum--}s)';
            _btnStr = '${widget.resendAfterText}(${_countDownNum--}s)';
          } else {
            // _btnStr = _normalText;
            _btnStr = widget.getCodeText;
            _countDownNum = widget.countDownSeconds;
            _countDownTimer?.cancel();
            _countDownTimer = null;
          }
        });
      });
    });
  }
}
