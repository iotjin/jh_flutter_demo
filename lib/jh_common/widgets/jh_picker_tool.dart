///  jh_picker_tool.dart
///
///  Created by iotjin on 2020/02/17.
///  description:  底部选择器 包含日期，单列、多列文本

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '/project/configs/colors.dart';

const String _titleNormalText = '请选择';
const String _cancelText = '取消';
const String _confirmText = '确定';
const String _yearSuffix = '年';
const String _monthSuffix = '月';
const String _daySuffix = '日';
const List<String> _strAMPM = ["上午", "下午"];
const double _kPickerHeight = 216.0;
const double _kItemHeight = 50.0;
const double _kHeaderLineHeight = 0.25;
const double _kHeaderRadius = 10.0;
const double _kTitleFontSize = 18.0;
const double _kBtnFontSize = 17.0;
const double _selectTextFontSize = 20.0;

/// 选择回调
/// 单列选择器返回选中行对象和index
/// 多列选择器返回选中行对象数组和index数组
/// 时间选择器返回选中行时间（时间格式：2022-07-03 15:00:46）和index数组
typedef _ClickCallBack = void Function(dynamic selectValue, dynamic selectIndexArr);

enum PickerDateType {
  YMD, // y, m, d
  YM, // y ,m
  YMD_HM, // y, m, d, hh, mm
  YMD_AP_HM, // y, m, d, ap, hh, mm
}

enum PickerType {
  String,
  Array,
  Date,
}

class JhPickerTool {
  /// 单列
  static void showStringPicker<T>(
    BuildContext context, {
    required List data,
    String? title,
    String? labelKey, // 对象数组的文字字段
    int selectIndex = 0,
    @required _ClickCallBack? clickCallBack,
  }) {
    if (data.length <= 0) {
      return;
    }
    _showPicker(
      context,
      data: data,
      title: title,
      selecteds: [selectIndex],
      pickerType: PickerType.String,
      adapter: labelKey != null
          ? PickerDataAdapter(pickerdata: data.map((e) => e[labelKey]).toList())
          : PickerDataAdapter(pickerdata: data),
      clickCallBack: clickCallBack,
    );
  }

  /// 多列
  static void showArrayPicker<T>(
    BuildContext context, {
    required List data,
    String? title,
    String? labelKey, // 对象数组的文字字段
    List<int>? selectIndex,
    required _ClickCallBack clickCallBack,
  }) {
    if (data.length <= 0) {
      return;
    }
    _showPicker(
      context,
      data: data,
      title: title,
      selecteds: selectIndex,
      pickerType: PickerType.Array,
      adapter: labelKey != null
          ? PickerDataAdapter(
              pickerdata: data.map((e) {
                return e.map((e2) => e2[labelKey]).toList();
              }).toList(),
              isArray: true)
          : PickerDataAdapter(pickerdata: data, isArray: true),
      clickCallBack: clickCallBack,
    );
  }

  /// 日期选择器
  static void showDatePicker(
    BuildContext context, {
    String? title,
    PickerDateType? dateType,
    DateTime? maxTime,
    DateTime? minTime,
    DateTime? selectTime,
    int? yearBegin: 1900,
    int? yearEnd: 2100,
    int? minHour: 0,
    int? maxHour: 23,
    required _ClickCallBack clickCallBack,
  }) {
    int timeType;
    if (dateType == PickerDateType.YM) {
      timeType = PickerDateTimeType.kYM;
    } else if (dateType == PickerDateType.YMD_HM) {
      timeType = PickerDateTimeType.kYMDHM;
    } else if (dateType == PickerDateType.YMD_AP_HM) {
      timeType = PickerDateTimeType.kYMD_AP_HM;
    } else {
      timeType = PickerDateTimeType.kYMD;
    }

    _showPicker(
      context,
      title: title,
      pickerType: PickerType.Date,
      adapter: DateTimePickerAdapter(
        type: timeType,
        isNumberMonth: true,
        yearSuffix: _yearSuffix,
        monthSuffix: _monthSuffix,
        daySuffix: _daySuffix,
        strAMPM: _strAMPM,
        maxValue: maxTime,
        minValue: minTime,
        value: selectTime ?? DateTime.now(),
        minHour: minHour,
        maxHour: maxHour,
        yearBegin: yearBegin,
        yearEnd: yearEnd,
      ),
      clickCallBack: clickCallBack,
    );
  }
}

/// 自定义picker
_showPicker(
  context, {
  List? data,
  String? title,
  List<int>? selecteds,
  PickerType? pickerType,
  required PickerAdapter adapter,
  _ClickCallBack? clickCallBack,
}) {
  // 默认颜色
  var isDark = Theme.of(context).brightness == Brightness.dark;
  var _bgColor = isDark ? KColors.kPickerBgDarkColor : KColors.kPickerBgColor;
  var _headerColor = isDark ? KColors.kPickerHeaderDarkColor : KColors.kPickerHeaderColor;
  var _kHeaderLineColor = isDark ? KColors.kPickerHeaderLineDarkColor : KColors.kPickerHeaderLineColor;
  var _titleColor = isDark ? KColors.kPickerTitleDarkColor : KColors.kPickerTitleColor;
  var _btnColor = isDark ? KColors.kPickerBtnDarkColor : KColors.kPickerBtnColor;
  var _selectTextColor = isDark ? KColors.kPickerTextDarkColor : KColors.kPickerTextColor;
  var _selectItemBgColor = Colors.grey.withOpacity(0.15);

  var picker = Picker(
      adapter: adapter,
      selecteds: selecteds,
      height: _kPickerHeight,
      itemExtent: _kItemHeight,
      title: Text(title ?? _titleNormalText, style: TextStyle(color: _titleColor, fontSize: _kTitleFontSize)),
      cancelText: _cancelText,
      cancelTextStyle: TextStyle(color: _btnColor, fontSize: _kBtnFontSize),
      confirmText: _confirmText,
      confirmTextStyle: TextStyle(color: _btnColor, fontSize: _kBtnFontSize),
      textAlign: TextAlign.center,
      selectedTextStyle: TextStyle(color: _selectTextColor, fontSize: _selectTextFontSize),
      selectionOverlay: Container(height: _kItemHeight, color: _selectItemBgColor),
      backgroundColor: _bgColor,
      headerDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _kHeaderLineColor, width: _kHeaderLineHeight),
        ),
      ),
      onConfirm: (Picker picker, List selectIndexArr) {
        if (pickerType == PickerType.String) {
          var selectIndex = selectIndexArr[0];
          clickCallBack?.call(data![selectIndex], selectIndex);
        }
        if (pickerType == PickerType.Array) {
          var selectItemArr = [];
          for (int i = 0; i < selectIndexArr.length; i++) {
            int j = selectIndexArr[i];
            selectItemArr.add(data![i][j]);
          }
          clickCallBack?.call(selectItemArr, selectIndexArr);
        }
        if (pickerType == PickerType.Date) {
          // var time = (picker.adapter as DateTimePickerAdapter).value;
          clickCallBack?.call(picker.adapter.text.split('.')[0], selectIndexArr);
        }
      });

  picker.showModal(context, backgroundColor: Colors.transparent, builder: (context, view) {
    return Material(
        color: _headerColor,
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(_kHeaderRadius), topRight: Radius.circular(_kHeaderRadius)),
        child: Container(
          padding: EdgeInsets.only(top: 5),
          child: view,
        ));
  });
}
