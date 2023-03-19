///  jh_alert.dart
///
///  Created by iotjin on 2020/03/07.
///  description:  iOS风格的弹框工具类

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _cancelText = '取消';
const String _confirmText = '确认';
const Color _alertCancelTextColor = Colors.blueAccent;
const Color _alertConfirmTextColor = Colors.blueAccent;

// 取消按钮的index 为 0 ,确认为 1
typedef _ClickCallBack = void Function(int selectIndex, String selectText);

class JhAlert {
  static bool _isShowAlert = false;

  /// Alert
  /// 取消按钮的index 为 0 ,确认为 1
  static void showAlert(
    BuildContext context, {
    String? title,
    String? content,
    String leftText = _cancelText,
    String rightText = _confirmText,
    _ClickCallBack? clickCallback,
  }) {
    if (_isShowAlert) {
      return;
    }
    _isShowAlert = true;

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Offstage(
            offstage: title == null ? true : false,
            child: Text(title ?? ''),
          ),
          content: Offstage(
            offstage: content == null ? true : false,
            child: Container(padding: const EdgeInsets.only(top: 10), child: Text(content ?? '')),
          ),
          actions: <Widget>[
            // CupertinoButton(
            //   child: Text(leftText),
            //   onPressed: () {
            //     clickCallback?.call(0, leftText);
            //     Navigator.pop(context); // Navigator.of(context).pop('点击了取消');
            //   },
            // ),
            // CupertinoButton(
            //   child: Text(rightText),
            //   onPressed: () {
            //     clickCallback?.call(1, rightText);
            //     Navigator.pop(context); // Navigator.of(context).pop('点击了确认');
            //   },
            // ),

            // 取消
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () {
                  clickCallback?.call(0, leftText);
                  Navigator.pop(context);
                },
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all(_alertCancelTextColor)),
                child: Text(leftText),
              ),
            ),
            // 确认
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () {
                  clickCallback?.call(1, rightText);
                  Navigator.pop(context);
                },
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all(_alertConfirmTextColor)),
                child: Text(rightText),
              ),
            ),
          ],
        );
      },
    ).then((value) => _isShowAlert = false);
  }

  /// ActionSheet
  /// index 从上往下 1，2，3，取消是0
  static void showActionSheet(
    BuildContext context, {
    String? title,
    String? content,
    @required List<String>? otherBtnTitles,
    String? redBtnTitle,
    _ClickCallBack? clickCallback,
  }) {
    if (_isShowAlert) {
      return;
    }
    _isShowAlert = true;

    List<CupertinoActionSheetAction> otherButtons = [];
    for (int i = 1; i < otherBtnTitles!.length + 1; i++) {
      var w = CupertinoActionSheetAction(
        onPressed: () {
          clickCallback?.call(i, otherBtnTitles[i - 1]);
          Navigator.pop(context);
        },
        child: Text(otherBtnTitles[i - 1]),
      );
      otherButtons.add(w);
    }

    if (redBtnTitle != null) {
      var w = CupertinoActionSheetAction(
        onPressed: () {
          clickCallback?.call(otherBtnTitles.length + 1, redBtnTitle);
          Navigator.pop(context);
        },
        isDestructiveAction: true,
        child: Text(redBtnTitle),
      );
      otherButtons.insert(otherBtnTitles.length, w);
    }

    if (title == null) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: otherButtons,
            cancelButton: CupertinoActionSheetAction(
              // 取消按钮
              onPressed: () {
                clickCallback?.call(0, _cancelText);
                Navigator.pop(context);
              },
              child: const Text(_cancelText),
            ),
          );
        },
      ).then((value) => _isShowAlert = false);
    } else {
      if (content != null) {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Offstage(
                offstage: false,
                child: Text(title, style: const TextStyle(fontSize: 20)),
              ),
              message: Text(content),
              actions: otherButtons,
              cancelButton: CupertinoActionSheetAction(
                // 取消按钮
                onPressed: () {
                  clickCallback?.call(0, _cancelText);
                  Navigator.pop(context);
                },
                child: const Text(_cancelText),
              ),
            );
          },
        ).then((value) => _isShowAlert = false);
      } else {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Offstage(
                offstage: false,
                child: Text(title),
              ),
              actions: otherButtons,
              cancelButton: CupertinoActionSheetAction(
                // 取消按钮
                onPressed: () {
                  clickCallback?.call(0, _cancelText);
                  Navigator.pop(context);
                },
                child: const Text(_cancelText),
              ),
            );
          },
        ).then((value) => _isShowAlert = false);
      }
    }
  }
}

//void aa(BuildContext context){
//  showCupertinoModalPopup(
//    context: context,
//    builder: (context) {
//      return CupertinoActionSheet(
//              title:  Text('提示', style: TextStyle(fontSize: 22),), // 标题
//              message: Text('麻烦抽出几分钟对该软件进行评价，谢谢!'), // 提示内容
//              actions:<Widget>[ // 操作按钮集合
//                CupertinoActionSheetAction(
//                  onPressed: (){
//                    Navigator.pop(context);
//                  },
//                  child: Text('给个好评'),
//                ),
//                CupertinoActionSheetAction(
//                  onPressed: (){
//                    Navigator.pop(context);
//                  },
//                  child: Text('我要吐槽'),
//                ),
//              ],
//        cancelButton: CupertinoActionSheetAction( // 取消按钮
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text(_cancelText),
//        ),
//      );
//    },
//  );
//
//}
