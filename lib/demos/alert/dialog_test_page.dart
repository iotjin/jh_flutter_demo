// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/jh_common/widgets/jh_picker_tool.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/configs/colors.dart';

class DialogTestPage extends StatefulWidget {
  const DialogTestPage({Key? key}) : super(key: key);

  @override
  State<DialogTestPage> createState() => _DialogTestPageState();
}

class _DialogTestPageState extends State<DialogTestPage> {
  final List titleData = [
    'JhDialog-标题',
    'JhDialog-标题不加粗',
    'JhDialog-标题内容',
    'JhDialog-内容',
    'JhDialog-标题内容只有确定',
    'JhDialog-修改按钮文字',
    'JhDialog-点击按钮弹框不消失',
    'JhDialog-拦截取消按钮点击事件',
    'JhDialog-录入框',
    'JhDialog-自定义内容',
    'JhDialog-自定义内容2',
    'JhDialog-自定义内容3-录入框',
    'JhDialog-自定义内容4-选择类型更新数据',
    'JhDialog-自定义内容5-选择类型更新数据2',
    'JhDialog-完全自定义',
    'JhDialog-完全自定义-外部点击事件',
  ];

  final dictArr = [
    {'label': '类型一', 'value': '1'},
    {'label': '类型二', 'value': '2'},
    {'label': '类型三', 'value': '3'},
  ];
  var _selectItem = {};

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'JhDialog',
      dataArr: titleData,
      callBack: (index, str) {
        if (str == 'JhDialog-标题') {
          JhDialog.show(context, title: '提示', onConfirm: () {
            JhToast.showText(context, msg: '点击确定');
          });
        }
        if (str == 'JhDialog-标题不加粗') {
          JhDialog.show(context, title: '提示', isBoldTitle: false);
        }
        if (str == 'JhDialog-标题内容') {
          JhDialog.show(context, title: '提示', content: '您确定要退出登录吗？');
        }
        if (str == 'JhDialog-内容') {
          JhDialog.show(context, content: '确认要退出吗？');
        }
        if (str == 'JhDialog-标题内容只有确定') {
          JhDialog.show(context, title: '警告', content: '您的账号在异地登录，请重新登录！', rightText: '好的', hiddenCancel: true);
        }
        if (str == 'JhDialog-修改按钮文字') {
          JhDialog.show(context, title: '提示', content: '您需要同意相关协议才能使用！', leftText: '不同意', rightText: '同意');
        }
        if (str == 'JhDialog-点击按钮弹框不消失') {
          JhDialog.show(context, title: '提示', content: '点击取消按钮弹框消失，点击确认按钮延时3秒后弹框消失', clickBtnPop: false, onConfirm: () {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
          });
        }
        if (str == 'JhDialog-拦截取消按钮点击事件') {
          JhDialog.show(context, title: '提示', content: '点击取消按钮弹框不消失，点击确认按钮弹框消失', onConfirm: () {
            JhToast.showText(context, msg: '点击确定');
          }, onCancel: () {
            JhToast.showText(context, msg: '点击取消');
          });
        }
        if (str == 'JhDialog-录入框') {
          var inputValue = '';
          JhDialog.showInputDialog(
            context,
            title: '提示',
            inputText: inputValue,
            hintText: 'number',
            labelText: 'number',
            keyboardType: TextInputType.number,
            inputFormatters: [number, length5],
            inputCallBack: (value) => inputValue = value,
            onConfirm: () {
              if (inputValue.isEmpty) {
                JhProgressHUD.showText('Please input number');
                return;
              }
              // 手动隐藏弹框
              JhDialog.hide(context);
              JhProgressHUD.showText('number: $inputValue');
              print('inputValue: $inputValue');
            },
          );
        }

        if (str == 'JhDialog-自定义内容') {
          JhDialog.showCustomDialog(context, content: Container(height: 200, color: Colors.red));
        }
        if (str == 'JhDialog-自定义内容2') {
          JhDialog.showCustomDialog(context, title: '提示', content: Container(height: 200, color: Colors.red));
        }
        if (str == 'JhDialog-自定义内容3-录入框') {
          _showInputDialog();
        }
        if (str == 'JhDialog-自定义内容4-选择类型更新数据') {
          var params = {
            'id': '123',
            'type': '456',
          };
          _showSelectDialog(params);
        }
        if (str == 'JhDialog-自定义内容5-选择类型更新数据2') {
          var params = {
            'id': '123',
            'type': '456',
          };
          _showSelectDialog2(params);
        }
        if (str == 'JhDialog-完全自定义') {
          JhDialog.showAllCustomDialog(
            context,
            clickBgHidden: true,
            child: Center(
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
                child: const Center(child: Text('这是完全自定义的弹框，点击背景隐藏')),
              ),
            ),
          );
        }
        if (str == 'JhDialog-完全自定义-外部点击事件') {
          JhDialog.showAllCustomDialog(
            context,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print('这是完全自定义的弹框，点击红色部分隐藏');
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
                child: const Center(child: Text('这是完全自定义的弹框，点击红色部分隐藏')),
              ),
            ),
          );
        }
      },
    );
  }

  _showInputDialog() async {
    var inputValue = '';
    JhDialog.showCustomDialog(
      context,
      title: '请输入数字',
      isBoldTitle: false,
      clickBtnPop: false,
      content: StatefulBuilder(builder: (context, state) {
        var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor);
        var bgColor = KColors.dynamicColor(context, KColors.kAlertInputBgColor, KColors.kAlertInputBgDarkColor);

        return Container(
          height: 50,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: lineColor, width: 1),
          ),
          child: JhFormInputCell(
            bgColor: Colors.transparent,
            text: inputValue,
            hiddenLine: true,
            labelText: 'number',
            keyboardType: TextInputType.number,
            inputFormatters: [number, length100],
            inputCallBack: (value) => inputValue = value,
          ),
        );
      }),
      onCancel: () => JhDialog.hide(context),
      onConfirm: () {
        if (inputValue.isEmpty) {
          JhProgressHUD.showText('Please input number');
          return;
        }

        JhDialog.hide(context);
        JhProgressHUD.showText('number: $inputValue');
        print('inputValue: $inputValue');
      },
    );
  }

  _showSelectDialog(params) async {
    JhDialog.showCustomDialog(
      context,
      title: '请选择类型',
      isBoldTitle: false,
      clickBtnPop: false,
      content: StatefulBuilder(builder: (context, state) {
        var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.transparent);
        return Container(
          height: 56,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: lineColor, width: 1)),
          child: Column(
            children: [
              JhFormSelectCell(
                showRedStar: true,
                hiddenLine: true,
                text: _selectItem['label'],
                labelText: '类型',
                clickCallBack: () => _showPicker(state),
              ),
            ],
          ),
        );
      }),
      onConfirm: () => _jumpPage(params, true),
      onCancel: () => JhDialog.hide(context),
    );
  }

  _showSelectDialog2(params) async {
    var title = '请选择类型';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, state) {
            var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.transparent);

            return BaseDialog(
              title: title,
              isBoldTitle: false,
              clickBtnPop: false,
              content: Container(
                height: 56,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: lineColor, width: 1)),
                child: Column(children: [
                  JhFormSelectCell(
                    showRedStar: true,
                    hiddenLine: true,
                    text: _selectItem['label'],
                    labelText: '类型',
                    clickCallBack: () {
                      _showPicker(state);
                    },
                  ),
                ]),
              ),
              onConfirm: () => _jumpPage(params, true),
              onCancel: () {
                state(() {
                  _selectItem = {};
                });
                JhDialog.hide(context);
              },
            );
          },
        );
      },
    );
  }

  _showPicker(state) {
    JhPickerTool.showStringPicker(context, data: dictArr, title: '请选择类型', labelKey: 'label', selectIndex: 1,
        clickCallBack: (selectValue, selectIndex) {
      print(selectValue);
      print(selectValue['label']);
      print(selectIndex);
      state(() {
        _selectItem = selectValue;
      });
    });
  }

  _jumpPage(params, isShowDialog) {
    if (_selectItem.isEmpty) {
      JhProgressHUD.showText('请选择类型');
      return;
    }

    JhDialog.hide(context);
    JhProgressHUD.showText('验证通过，进行其他操作');
    print('params: $params');
  }
}
