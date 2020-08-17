/**
 *  jh_dialog.dart
 *
 *  Created by iotjin on 2020/07/28.
 *  description:  全屏弹框
 */

import 'package:flutter/material.dart';

class JhDialog {
  //中间弹框
  static void show(
    @required BuildContext context, {
    String title,
    String content,
    String leftText: "取消",
    String rightText: "确认",
    final VoidCallback onCancel,
    final VoidCallback onConfirm,
    bool hiddenCancel: false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BaseDialog(
              title: title,
              content: content == null
                  ? null
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(content, style: TextStyle(fontSize: 16.0)),
                    ),
              leftText: leftText,
              rightText: rightText,
              onCancel: onCancel,
              onConfirm: onConfirm,
              hiddenCancel: hiddenCancel);
        });
  }

  //自定义弹框
  static void showCustomDialog(
    @required BuildContext context, {
    String title,
    Widget content,
    String leftText: "取消",
    String rightText: "确认",
    final VoidCallback onCancel,
    final VoidCallback onConfirm,
    bool hiddenCancel: false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BaseDialog(
              title: title,
              content: content,
              leftText: leftText,
              rightText: rightText,
              onCancel: onCancel,
              onConfirm: onConfirm,
              hiddenCancel: hiddenCancel);
        });
  }

  //完全自定义弹框
  static void showAllCustomDialog(
    @required BuildContext context, {
    Widget child,
    bool clickBgHidden: false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(child: child, clickBgHidden: clickBgHidden);
        });
  }
}

class BaseDialog extends StatelessWidget {
  BaseDialog({
    Key key,
    this.title,
    this.content,
    this.leftText: "取消",
    this.rightText: "确认",
    this.onCancel,
    this.onConfirm,
    this.hiddenCancel: false,
  }) : super(key: key);

  final String title;
  final Widget content;
  final String leftText;
  final String rightText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final bool hiddenCancel;

  @override
  Widget build(BuildContext context) {
    Widget dialogTitle = Offstage(
      offstage: title == null || title == '' ? true : false,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          title == null ? "" : title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

    Widget bottomButton = Row(
      children: <Widget>[
        hiddenCancel
            ? Container()
            : _DialogButton(
                text: leftText,
                textColor: Color(0xFF999999),
                onPressed: () {
                  Navigator.pop(context);
                  if (onCancel != null) {
                    onCancel();
                  }
                },
              ),
        SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: rightText,
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pop(context);
            if (onConfirm != null) {
              onConfirm();
            }
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
          content == null ? Container() : Flexible(child: content),
          SizedBox(height: 8),
          Divider(height: 1),
          bottomButton,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
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
    Key key,
    this.text: '',
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: FlatButton(
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0),
          ),
          textColor: textColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class CustomDialog extends Dialog {
  CustomDialog({
    Key key,
    this.child,
    this.clickBgHidden: false, //点击背景隐藏，默认不隐藏
  }) : super(key: key);

  final Widget child;
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
          //内容
          Center(child: child)
//          child
        ],
      ),
    );
  }
}
