///  jh_dialog.dart
///
///  Created by iotjin on 2020/07/28.
///  description:  中间、自定义、全屏弹框

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const String _cancelText = '取消';
const String _confirmText = '确认';
const double _titleFontSize = 18.0;
const double _btnFontSize = 18.0;
const Color _cancelTextColor = Color(0xFF999999);

class JhDialog {
  /// 中间弹框
  static void show(
    BuildContext context, {
    String title = '',
    bool isBoldTitle = true,
    String content = '',
    String leftText = _cancelText,
    String rightText = _confirmText,
    final VoidCallback? onCancel,
    final VoidCallback? onConfirm,
    bool hiddenCancel = false,
    bool clickBtnPop = true, // 点击确认按钮是否弹框消失
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _BaseDialog(
            title: title,
            isBoldTitle: isBoldTitle,
            widget: content == ''
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(content, style: TextStyle(fontSize: 16.0)),
                  ),
            leftText: leftText,
            rightText: rightText,
            onCancel: onCancel,
            onConfirm: onConfirm,
            hiddenCancel: hiddenCancel,
            clickBtnPop: clickBtnPop,
          );
        });
  }

  /// 当clickBtnPop=false时，手动隐藏弹框
  static void hide(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);
  }

  /// 自定义弹框
  static void showCustomDialog(
    BuildContext context, {
    String title = '',
    bool isBoldTitle = true,
    Widget? content,
    String leftText = _cancelText,
    String rightText = _confirmText,
    final VoidCallback? onCancel,
    final VoidCallback? onConfirm,
    bool hiddenCancel = false,
    bool clickBtnPop = true, // 点击确认按钮是否弹框消失
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _BaseDialog(
            title: title,
            isBoldTitle: isBoldTitle,
            widget: content,
            leftText: leftText,
            rightText: rightText,
            onCancel: onCancel,
            onConfirm: onConfirm,
            hiddenCancel: hiddenCancel,
            clickBtnPop: clickBtnPop,
          );
        });
  }

  /// 完全自定义弹框
  static void showAllCustomDialog(
    BuildContext context, {
    Widget? child,
    bool clickBgHidden = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _CustomDialog(child: child!, clickBgHidden: clickBgHidden);
      },
    );
  }
}

class _BaseDialog extends StatelessWidget {
  _BaseDialog({
    Key? key,
    this.title = '',
    this.isBoldTitle = true,
    this.widget,
    this.leftText = _cancelText,
    this.rightText = _confirmText,
    this.onCancel,
    this.onConfirm,
    this.hiddenCancel = false,
    this.clickBtnPop = true,
  }) : super(key: key);

  final String title;
  final bool isBoldTitle;
  final Widget? widget;
  final String leftText;
  final String rightText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool hiddenCancel;
  final bool clickBtnPop;

  @override
  Widget build(BuildContext context) {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var confirmTextColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    Widget dialogTitle = Offstage(
      offstage: title == '',
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: _titleFontSize, fontWeight: isBoldTitle ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );

    Widget bottomButton = Row(
      children: <Widget>[
        hiddenCancel
            ? Container()
            : _DialogButton(
                text: leftText,
                textColor: _cancelTextColor,
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
              ),
        SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: rightText,
          textColor: confirmTextColor,
          onPressed: () {
            if (clickBtnPop == true) {
              Navigator.pop(context);
            }
            onConfirm?.call();
          },
        ),
      ],
    );

    Widget body = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          dialogTitle,
          widget == null ? Container() : Flexible(child: widget!),
          SizedBox(height: 8),
          Divider(height: 1),
          bottomButton,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 270.0,
            child: body,
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  _DialogButton({
    Key? key,
    this.text = '',
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(fontSize: _btnFontSize)),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(textColor),
          ),
        ),
      ),
    );
  }
}

class _CustomDialog extends Dialog {
  _CustomDialog({
    Key? key,
    this.child,
    this.clickBgHidden = false, // 点击背景隐藏，默认不隐藏
  }) : super(key: key);

  final Widget? child;
  final bool clickBgHidden;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (clickBgHidden == true) {
                Navigator.pop(context);
              }
            },
          ),
          // 内容
          Center(child: child)
        ],
      ),
    );
  }
}
