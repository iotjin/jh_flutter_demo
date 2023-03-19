///  jh_dialog.dart
///
///  Created by iotjin on 2020/07/28.
///  description:  中间、自定义、全屏弹框

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/Jh_common/jh_form/jh_form_input_cell.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const String _cancelText = '取消';
const String _confirmText = '确认';
const double _titleFontSize = 18.0;
const double _btnFontSize = 18.0;
const Color _cancelTextColor = Color(0xFF999999);

class JhDialog {
  static bool _isShowDialog = false;

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
    if (_isShowDialog) {
      return;
    }
    _isShowDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BaseDialog(
          title: title,
          isBoldTitle: isBoldTitle,
          content: content == ''
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(content, style: const TextStyle(fontSize: 16.0)),
                ),
          leftText: leftText,
          rightText: rightText,
          onCancel: onCancel,
          onConfirm: onConfirm,
          hiddenCancel: hiddenCancel,
          clickBtnPop: clickBtnPop,
        );
      },
    ).then((value) => _isShowDialog = false);
  }

  /// 当clickBtnPop=false时，手动隐藏弹框
  static void hide(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);
    _isShowDialog = false;
  }

  /// 带输入框弹框
  static void showInputDialog(
    BuildContext context, {
    String title = '',
    bool isBoldTitle = false,
    String leftText = _cancelText,
    String rightText = _confirmText,
    final VoidCallback? onCancel,
    final VoidCallback? onConfirm,
    bool hiddenCancel = false,
    bool clickBtnPop = false, // 点击确认按钮是否弹框消失
    String? inputText = '',
    String hintText = '请输入',
    String labelText = '请输入',
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    void Function(String value)? inputCallBack,
    void Function(String value, bool isSubmitted)? inputCompletionCallBack,
  }) {
    JhDialog.showCustomDialog(
      context,
      title: title,
      isBoldTitle: isBoldTitle,
      leftText: leftText,
      rightText: rightText,
      onCancel: onCancel,
      onConfirm: onConfirm,
      hiddenCancel: hiddenCancel,
      clickBtnPop: clickBtnPop,
      content: _InputWidget(
        inputText: inputText,
        hintText: hintText,
        labelText: labelText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        inputCallBack: inputCallBack,
        inputCompletionCallBack: inputCompletionCallBack,
      ),
    );
  }

  /// 自定义弹框
  /// 更新弹窗内容使用StatefulBuilder
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
    if (_isShowDialog) {
      return;
    }
    _isShowDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BaseDialog(
          title: title,
          isBoldTitle: isBoldTitle,
          content: content,
          leftText: leftText,
          rightText: rightText,
          onCancel: onCancel,
          onConfirm: onConfirm,
          hiddenCancel: hiddenCancel,
          clickBtnPop: clickBtnPop,
        );
      },
    ).then((value) => _isShowDialog = false);
  }

  /// 完全自定义弹框
  /// 更新弹窗内容使用StatefulBuilder
  static void showAllCustomDialog(
    BuildContext context, {
    Widget? child,
    bool clickBgHidden = false,
  }) {
    if (_isShowDialog) {
      return;
    }
    _isShowDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _CustomDialog(clickBgHidden: clickBgHidden, child: child);
      },
    ).then((value) => _isShowDialog = false);
  }
}

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    Key? key,
    this.title = '',
    this.isBoldTitle = true,
    this.content,
    this.leftText = _cancelText,
    this.rightText = _confirmText,
    this.onCancel,
    this.onConfirm,
    this.hiddenCancel = false,
    this.clickBtnPop = true,
  }) : super(key: key);

  final String title;
  final bool isBoldTitle;
  final Widget? content;
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
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
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
                  if (onCancel != null) {
                    onCancel?.call();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
        const SizedBox(height: 48.0, width: 0.6, child: VerticalDivider()),
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
          const SizedBox(height: 24),
          dialogTitle,
          content == null ? Container() : Flexible(child: content!),
          const SizedBox(height: 8),
          const Divider(height: 1),
          bottomButton,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 120),
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
  const _DialogButton({
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
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all(textColor)),
          child: Text(text, style: const TextStyle(fontSize: _btnFontSize)),
        ),
      ),
    );
  }
}

class _CustomDialog extends Dialog {
  const _CustomDialog({
    Key? key,
    super.child,
    this.clickBgHidden = false, // 点击背景隐藏，默认不隐藏
  }) : super(key: key);

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

class _InputWidget extends StatelessWidget {
  const _InputWidget({
    Key? key,
    this.inputText = '',
    this.hintText = '请输入',
    this.labelText = '请输入',
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.inputCallBack,
    this.inputCompletionCallBack,
  }) : super(key: key);

  final String? inputText;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? inputCallBack;
  final Function(String value, bool isSubmitted)? inputCompletionCallBack;

  @override
  Widget build(BuildContext context) {
    var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor);
    var bgColor = KColors.dynamicColor(context, KColors.kAlertInputBgColor, KColors.kAlertInputBgDarkColor);

    return Container(
      height: 55,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: lineColor, width: 1)),
      child: JhFormInputCell(
        bgColor: bgColor,
        text: inputText,
        hintText: hintText,
        labelText: labelText,
        keyboardType: keyboardType,
        hiddenLine: true,
        inputFormatters: inputFormatters,
        inputCallBack: inputCallBack,
        inputCompletionCallBack: inputCompletionCallBack,
      ),
    );
  }
}
