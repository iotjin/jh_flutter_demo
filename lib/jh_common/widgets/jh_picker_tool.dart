///  jh_picker_tool.dart
///
///  Created by iotjin on 2020/02/17.
///  description:  底部选择器 包含日期，单列、多列文本

// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '/project/configs/colors.dart';

const String _titleNormalText = '请选择';
const String _cancelText = '取消';
const String _confirmText = '确定';
const String _yearSuffix = '年';
const String _monthSuffix = '月';
const String _daySuffix = '日';
const List<String> _strAMPM = ['上午', '下午'];
const double _kPickerHeight = 216.0;
const double _kItemHeight = 50.0;
const double _kHeaderLineHeight = 0.25;
const double _kHeaderRadius = 10.0;
const double _kTitleFontSize = 18.0;
const double _kBtnFontSize = 17.0;
const double _textFontSize = 18.0;
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
  string,
  array,
  date,
}

class JhPickerTool {
  static bool _isShowPicker = false;

  /// 单列
  /// 单列选择器返回选中行对象和index
  static void showStringPicker<T>(
    BuildContext context, {
    required List data,
    String? title,
    String? labelKey, // 对象数组的文字字段
    int selectIndex = 0,
    _ClickCallBack? clickCallBack,
  }) {
    if (_isShowPicker || data.isEmpty) {
      return;
    }
    _isShowPicker = true;

    showModalBottomSheet(
      context: context,
      // 设置圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kHeaderRadius),
          topRight: Radius.circular(_kHeaderRadius),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return BasePickerView(
          data: data,
          title: title,
          selecteds: [selectIndex],
          pickerType: PickerType.string,
          adapter: labelKey != null
              ? PickerDataAdapter(pickerData: data.map((e) => e[labelKey]).toList())
              : PickerDataAdapter(pickerData: data),
          clickCallBack: clickCallBack,
        );
      },
    ).then((value) => _isShowPicker = false);
  }

  /// 多列
  /// 多列选择器返回选中行对象数组和index数组
  static void showArrayPicker<T>(
    BuildContext context, {
    required List data,
    String? title,
    String? labelKey, // 对象数组的文字字段
    List<int>? selectIndex,
    _ClickCallBack? clickCallBack,
  }) {
    if (_isShowPicker || data.isEmpty) {
      return;
    }
    _isShowPicker = true;

    showModalBottomSheet(
      context: context,
      // 设置圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kHeaderRadius),
          topRight: Radius.circular(_kHeaderRadius),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return BasePickerView(
          data: data,
          title: title,
          selecteds: selectIndex,
          pickerType: PickerType.array,
          adapter: labelKey != null
              ? PickerDataAdapter(
                  pickerData: data.map((e) {
                    return e.map((e2) => e2[labelKey]).toList();
                  }).toList(),
                  isArray: true)
              : PickerDataAdapter(pickerData: data, isArray: true),
          clickCallBack: clickCallBack,
        );
      },
    ).then((value) => _isShowPicker = false);
  }

  /// 日期选择器
  /// 时间选择器返回选中行时间（时间格式：2022-07-03 15:00:46）和index数组
  static void showDatePicker(
    BuildContext context, {
    String? title,
    PickerDateType? dateType,
    DateTime? maxTime,
    DateTime? minTime,
    DateTime? selectTime,
    int? yearBegin = 1900,
    int? yearEnd = 2100,
    int? minHour = 0,
    int? maxHour = 23,
    _ClickCallBack? clickCallBack,
  }) {
    if (_isShowPicker) {
      return;
    }
    _isShowPicker = true;

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

    showModalBottomSheet(
      context: context,
      // 设置圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kHeaderRadius),
          topRight: Radius.circular(_kHeaderRadius),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return BasePickerView(
          title: title,
          pickerType: PickerType.date,
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
      },
    ).then((value) => _isShowPicker = false);
  }
}

/// 自定义picker
class BasePickerView extends StatefulWidget {
  const BasePickerView({
    Key? key,
    this.data,
    this.title,
    this.selecteds,
    this.pickerType,
    required this.adapter,
    this.clickCallBack,
  }) : super(key: key);

  final List? data;
  final String? title;
  final List<int>? selecteds;
  final PickerType? pickerType;
  final PickerAdapter adapter;
  final _ClickCallBack? clickCallBack;

  @override
  State<BasePickerView> createState() => BasePickerViewState();
}

class BasePickerViewState extends State<BasePickerView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    var bgColor = KColors.dynamicColor(context, KColors.kPickerBgColor, KColors.kPickerBgDarkColor);
    var headerColor = KColors.dynamicColor(context, KColors.kPickerHeaderColor, KColors.kPickerHeaderDarkColor);
    var headerLineColor =
        KColors.dynamicColor(context, KColors.kPickerHeaderLineColor, KColors.kPickerHeaderLineDarkColor);
    var titleColor = KColors.dynamicColor(context, KColors.kPickerTitleColor, KColors.kPickerTitleDarkColor);
    var btnColor = KColors.dynamicColor(context, KColors.kPickerBtnColor, KColors.kPickerBtnDarkColor);
    var selectTextColor = KColors.dynamicColor(context, KColors.kPickerTextColor, KColors.kPickerTextDarkColor);
    var selectItemBgColor = Colors.grey.withOpacity(0.15);

    var picker = Picker(
      adapter: widget.adapter,
      selecteds: widget.selecteds,
      height: _kPickerHeight,
      itemExtent: _kItemHeight,
      title: Text(widget.title ?? _titleNormalText, style: TextStyle(color: titleColor, fontSize: _kTitleFontSize)),
      cancelText: _cancelText,
      cancelTextStyle: TextStyle(color: btnColor, fontSize: _kBtnFontSize),
      confirmText: _confirmText,
      confirmTextStyle: TextStyle(color: btnColor, fontSize: _kBtnFontSize),
      textAlign: TextAlign.center,
      textStyle: TextStyle(color: selectTextColor, fontSize: _textFontSize),
      selectedTextStyle: TextStyle(color: selectTextColor, fontSize: _selectTextFontSize),
      selectionOverlay: Container(height: _kItemHeight, color: selectItemBgColor),
      backgroundColor: bgColor,
      headerDecoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: headerLineColor, width: _kHeaderLineHeight)),
      ),
      onConfirm: (Picker picker, List selectIndexArr) {
        if (widget.pickerType == PickerType.string) {
          var selectIndex = selectIndexArr[0];
          widget.clickCallBack?.call(widget.data![selectIndex], selectIndex);
        }
        if (widget.pickerType == PickerType.array) {
          var selectItemArr = [];
          for (int i = 0; i < selectIndexArr.length; i++) {
            int j = selectIndexArr[i];
            selectItemArr.add(widget.data![i][j]);
          }
          widget.clickCallBack?.call(selectItemArr, selectIndexArr);
        }
        if (widget.pickerType == PickerType.date) {
          // var time = (picker.adapter as DateTimePickerAdapter).value;
          widget.clickCallBack?.call(picker.adapter.text.split('.')[0], selectIndexArr);
        }
      },
    );

    return Material(
      color: headerColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(_kHeaderRadius),
        topRight: Radius.circular(_kHeaderRadius),
      ),
      child: Container(padding: const EdgeInsets.only(top: 5), child: picker.makePicker()),
    );
  }
}
