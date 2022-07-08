///  jh_count_down_btn.dart
///
///  Created by iotjin on 2020/04/07.
///  description:  倒计时按钮

import 'dart:async';
import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

const int _normalTime = 10; // 默认倒计时时间
const String _normalText = '获取验证码'; // 默认按钮文字
const double _fontSize = 13.0; // 文字大小
const double _borderWidth = 0.8; // 边框宽度
const double _borderRadius = 1.0; // 边框圆角
const Color _bgColor = Colors.transparent; // 默认按钮背景色
const Color _textColor = KColors.kThemeColor; // 默认按钮文字

class JhCountDownBtn extends StatefulWidget {
  const JhCountDownBtn({
    Key? key,
    this.getVCode,
    this.textColor: _textColor,
    this.bgColor: _bgColor,
    this.fontSize: _fontSize,
    this.borderColor: _textColor,
    this.borderRadius: _borderRadius,
    this.showBorder: false,
  }) : super(key: key);

  final Future<bool> Function()? getVCode;
  final Color? textColor;
  final Color? bgColor;
  final double? fontSize;
  final Color? borderColor;
  final double? borderRadius;
  final bool showBorder;

  @override
  _JhCountDownBtnState createState() => _JhCountDownBtnState();
}

class _JhCountDownBtnState extends State<JhCountDownBtn> {
  Timer? _countDownTimer;
  String _btnStr = _normalText;
  int _countDownNum = _normalTime;

  @override
  Widget build(BuildContext context) {
    if (widget.getVCode == null) {
      return Container();
    } else
      return TextButton(
        onPressed: () => _getVCode(),
        child: Text(_btnStr, style: TextStyle(fontSize: widget.fontSize)),
        style: ButtonStyle(
          // 设置按钮大小
          minimumSize: MaterialStateProperty.all(Size(120, 30)),
          // 背景色
          backgroundColor: MaterialStateProperty.all(widget.bgColor),
          // 文字颜色
          foregroundColor: MaterialStateProperty.all(widget.textColor),
          // 边框
          side: widget.showBorder == false
              ? null
              : MaterialStateProperty.all(
                  BorderSide(color: widget.borderColor!, width: _borderWidth),
                ),
          // 圆角
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius!)),
          ),
        ),
      );
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
      _countDownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
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

  /// 释放掉Timer
  @override
  void dispose() {
    _countDownTimer?.cancel();
    _countDownTimer = null;
    super.dispose();
  }
}
