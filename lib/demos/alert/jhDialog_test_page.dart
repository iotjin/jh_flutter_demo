import 'package:flutter/material.dart';

import 'package:jhtoast/jhtoast.dart';

import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_dialog.dart';

class JhDialogTestPage extends StatelessWidget {
  final List titleData = [
    "JhDialog-标题",
    "JhDialog-标题内容",
    "JhDialog-内容",
    "JhDialog-标题内容只有确定",
    "JhDialog-修改按钮文字",
    "JhDialog-自定义内容",
    "JhDialog-自定义内容2",
    "JhDialog-完全自定义",
    "JhDialog-完全自定义-外部点击事件",
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "JhDialog",
      dataArr: titleData,
      callBack: (index, str) {
        if (index == 0) {
          JhDialog.show(context, title: "提示", onConfirm: () {
            print('点击确定');
            JhToast.showText(context, msg: '点击确定');
          }, onCancel: () {
            JhToast.showText(context, msg: '点击取消');
          });
        }
        if (index == 1) {
          JhDialog.show(context, title: "提示", content: '您确定要退出登录吗？');
        }
        if (index == 2) {
          JhDialog.show(context, content: '确认要退出吗？');
        }
        if (index == 3) {
          JhDialog.show(context,
              title: "警告",
              content: '您的账号在异地登录，请重新登录！',
              rightText: '好的',
              hiddenCancel: true);
        }
        if (index == 4) {
          JhDialog.show(context,
              title: "提示",
              content: '您需要同意相关协议才能使用！',
              leftText: '不同意',
              rightText: '同意');
        }

        if (index == 5) {
          JhDialog.showCustomDialog(context,
              content: Container(height: 200, color: Colors.red));
        }
        if (index == 6) {
          JhDialog.showCustomDialog(context,
              title: '提示', content: Container(height: 200, color: Colors.red));
        }
        if (index == 7) {
          JhDialog.showAllCustomDialog(
            context,
            clickBgHidden: true,
            child: Center(
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
                child: Center(
                  child: Text('这是完全自定义的弹框，点击背景隐藏'),
                ),
              ),
            ),
          );
        }
        if (index == 8) {
          JhDialog.showAllCustomDialog(context,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print("这是完全自定义的弹框，点击红色部分隐藏");
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.red,
                  child: Center(
                    child: Text('这是完全自定义的弹框，点击红色部分隐藏'),
                  ),
                ),
              ));
        }
      },
    );
  }
}
