// ignore_for_file: avoid_print,unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/jh_common/utils/jh_time_utils.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_picker_tool.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';

final List titleData = [
  'JhBottomSheet-不带标题',
  'JhBottomSheet-带标题',
  'JhBottomSheet-红色',
  'JhPickerTool-单列（字符串数组）',
  'JhPickerTool-单列（对象数组）',
  'JhPickerTool-两列（字符串数组）',
  'JhPickerTool-两列（对象数组）',
  'JhPickerTool-三列（字符串数组）',
  'JhPickerTool-三列（对象数组）',
  'JhPickerTool-时间选择YMD（默认YMD）',
  'JhPickerTool-时间选择YM',
  'JhPickerTool-时间选择YMD_HM',
  'JhPickerTool-时间选择YMD_AP_HM',
  'JhPickerTool-时间选择设置最大最小时间',
];

final stringArr = ['11', '22', '33', '44'];

final dictArr = [
  {'label': '类型一', 'value': '1'},
  {'label': '类型二', 'value': '2'},
  {'label': '类型三', 'value': '3'},
];

final stringArr2 = [
  ['11', '22'],
  ['33', '44'],
];

final dictArr2 = [
  [
    {'label': '大类一', 'value': '1'},
    {'label': '大类二', 'value': '2'},
    {'label': '大类三', 'value': '3'},
  ],
  [
    {'label': '小类一', 'value': '1'},
    {'label': '小类二', 'value': '2'},
  ],
];

final stringArr3 = [
  ['11', '22'],
  ['33', '44'],
  ['55', '66']
];

final dictArr3 = [
  [
    {'label': '大类一', 'value': '1'},
    {'label': '大类二', 'value': '2'},
    {'label': '大类三', 'value': '3'},
  ],
  [
    {'label': '中类一', 'value': '1'},
    {'label': '中型二', 'value': '2'},
    {'label': '中型三', 'value': '3'},
    {'label': '中型四', 'value': '4'},
  ],
  [
    {'label': '小类一', 'value': '1'},
    {'label': '小类二', 'value': '2'},
  ],
];

class BottomSheetTest extends StatelessWidget {
  const BottomSheetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
        title: 'BottomSheetTest',
        dataArr: titleData,
        callBack: (index, str) {
          if (str == 'JhBottomSheet-不带标题') {
            JhBottomSheet.showText(context, dataArr: ['hello', 'world', '123'], clickCallback: (index, text) {
              print(index);
              print(text);
              showText(text);
            });
          }
          if (str == 'JhBottomSheet-带标题') {
            JhBottomSheet.showText(context, dataArr: ['hello', 'world', '123'], title: '请选择',
                clickCallback: (index, text) {
              print(index);
              print(text);
              showText(text);
            });
          }
          if (str == 'JhBottomSheet-红色') {
            JhBottomSheet.showText(context, title: '请选择操作', dataArr: ['保存本地'], redBtnTitle: '删除',
                clickCallback: (index, text) {
              print(index);
              print(text);
              showText(text);
            });
          }

          if (str == 'JhPickerTool-单列（字符串数组）') {
            JhPickerTool.showStringPicker(context, data: stringArr, selectIndex: 1,
                clickCallBack: (selectValue, selectIndex) {
              print(selectValue);
              print(selectIndex);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-单列（对象数组）') {
            JhPickerTool.showStringPicker(context, data: dictArr, title: '请选择类型', labelKey: 'label', selectIndex: 2,
                clickCallBack: (selectValue, selectIndex) {
              print(selectValue);
              print(selectValue['label']);
              print(selectIndex);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-两列（字符串数组）') {
            JhPickerTool.showArrayPicker(context, data: stringArr2, selectIndex: [0, 1],
                clickCallBack: (selectItemArr, selectIndexArr) {
              print(selectItemArr);
              print(selectIndexArr);
              showText(selectItemArr);
            });
          }
          if (str == 'JhPickerTool-两列（对象数组）') {
            JhPickerTool.showArrayPicker(context,
                data: dictArr2,
                title: '请选择类型',
                labelKey: 'label',
                selectIndex: [1, 1], clickCallBack: (selectItemArr, selectIndexArr) {
              print(selectItemArr);
              print(selectIndexArr);
              print(dictArr2[0][selectIndexArr[0]]);
              print(dictArr2[1][selectIndexArr[1]]);
              showText(selectItemArr);
            });
          }

          if (str == 'JhPickerTool-三列（字符串数组）') {
            JhPickerTool.showArrayPicker(context, data: stringArr3, selectIndex: [0, 1, 0],
                clickCallBack: (selectItemArr, selectIndexArr) {
              print(selectItemArr);
              print(selectIndexArr);
              showText(selectItemArr);
            });
          }
          if (str == 'JhPickerTool-三列（对象数组）') {
            JhPickerTool.showArrayPicker(context,
                data: dictArr3,
                title: '请选择类型',
                labelKey: 'label',
                selectIndex: [1, 2, 1], clickCallBack: (selectItemArr, selectIndexArr) {
              print(selectItemArr);
              print(selectIndexArr);
              print(dictArr3[0][selectIndexArr[0]]);
              print(dictArr3[1][selectIndexArr[1]]);
              print(dictArr3[2][selectIndexArr[2]]);
              showText(selectItemArr);
            });
          }
          if (str == 'JhPickerTool-时间选择YMD（默认YMD）') {
            JhPickerTool.showDatePicker(context, clickCallBack: (selectValue, selectIndexArr) {
              print(selectValue);
              print(selectIndexArr);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-时间选择YM') {
            JhPickerTool.showDatePicker(context, dateType: PickerDateType.YM,
                clickCallBack: (selectValue, selectIndexArr) {
              print(selectValue);
              print(selectIndexArr);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-时间选择YMD_HM') {
            JhPickerTool.showDatePicker(context, dateType: PickerDateType.YMD_HM,
                clickCallBack: (selectValue, selectIndexArr) {
              print(selectValue);
              print(selectIndexArr);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-时间选择YMD_AP_HM') {
            JhPickerTool.showDatePicker(context, dateType: PickerDateType.YMD_AP_HM,
                clickCallBack: (selectValue, selectIndexArr) {
              print(selectValue);
              print(selectIndexArr);
              showText(selectValue);
            });
          }
          if (str == 'JhPickerTool-时间选择设置最大最小时间') {
            JhPickerTool.showDatePicker(context,
                title: '请选择时间',
                minTime: DateTime(int.parse(JhTimeUtils.getYear()) - 1, 10, 10),
                maxTime: DateTime(int.parse(JhTimeUtils.getYear()) + 1, 10, 10),
                selectTime: DateTime(int.parse(JhTimeUtils.getYear()), 10, 10),
                clickCallBack: (selectValue, selectIndexArr) {
              print(selectValue);
              print(selectIndexArr);
              showText(selectValue);
            });
          }
        });
  }
}

void showText(text) {
  JhProgressHUD.showText(text.toString());

  // Fluttertoast.showToast(
  //   msg: str.toString(),
  //   gravity: ToastGravity.CENTER,
  //   backgroundColor: Colors.black,
  // );

//  Fluttertoast.showToast(
//      msg: 'This is Center Short Toast',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIos: 1,
//      backgroundColor: Colors.red,
//      textColor: Colors.white,
//      fontSize: 16.0
//  );
}
