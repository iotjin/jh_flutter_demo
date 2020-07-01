/** 
 *  jh_picker_tool.dart
 *
 *  Created by iotjin on 2020/02/17.
 *  description:  底部选择器 包含日期，单列、多列文本
 */
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:date_format/date_format.dart';

const double _kPickerHeight = 216.0;
const double _kItemHeight = 40.0;
const Color _kBtnColor = Color(0xFF323232);//50
const Color _kTitleColor = Color(0xFF787878);//120
const double _kTextFontSize = 17.0;

typedef _StringClickCallBack = void Function(int selectIndex,Object selectStr);
typedef _ArrayClickCallBack = void Function( List<int> selecteds,List<dynamic> strData);
typedef _DateClickCallBack = void Function(dynamic selectDateStr,dynamic selectDate);


  enum DateType {
     YMD,        // y, m, d
      YM,        // y ,m
     YMD_HM,     // y, m, d, hh, mm
     YMD_AP_HM,  // y, m, d, ap, hh, mm
  }

class JhPickerTool {

      /** 单列*/
    static void showStringPicker<T>(
        BuildContext context, {
          @required List<T> data,
          String title,
          int normalIndex,
          PickerDataAdapter adapter,
          @required _StringClickCallBack clickCallBack,
        }) {

        openModalPicker(context,
            adapter: adapter ??  PickerDataAdapter( pickerdata: data, isArray: false),
            clickCallBack:(Picker picker, List<int> selecteds){
              //          print(picker.adapter.text);
            clickCallBack(selecteds[0],data[selecteds[0]]);
           },
        selecteds: [normalIndex??0] ,
            title: title);
        }

        /** 多列 */
      static void showArrayPicker<T>(
          BuildContext context, {
            @required List<T> data,
            String title,
            List<int> normalIndex,
            PickerDataAdapter adapter,
            @required _ArrayClickCallBack clickCallBack,
          }) {
        openModalPicker(context,
            adapter: adapter ??  PickerDataAdapter( pickerdata: data, isArray: true),
            clickCallBack:(Picker picker, List<int> selecteds){
            clickCallBack(selecteds,picker.getSelectedValues());
            },
            selecteds: normalIndex,
            title: title);

      }


        static void openModalPicker(
            BuildContext context, {
              @required PickerAdapter adapter,
              String title,
              List<int> selecteds,
              @required PickerConfirmCallback clickCallBack,
            }) {
          new Picker(
            adapter: adapter,
            title: new Text(title ?? "请选择",style:TextStyle(color: _kTitleColor,fontSize: _kTextFontSize)),
            selecteds: selecteds,
            cancelText: '取消',
            confirmText: '确定',
            cancelTextStyle: TextStyle(color: _kBtnColor,fontSize: _kTextFontSize),
            confirmTextStyle: TextStyle(color: _kBtnColor,fontSize: _kTextFontSize),
            textAlign: TextAlign.right,
            itemExtent: _kItemHeight,
            height: _kPickerHeight,
            selectedTextStyle: TextStyle(color: Colors.black),
            onConfirm:clickCallBack
          ).showModal(context);
        }


     /** 日期选择器*/
      static void showDatePicker(
          BuildContext context, {
          DateType dateType,
          String title,
          DateTime maxValue,
          DateTime minValue,
          DateTime value,
          DateTimePickerAdapter adapter,
          @required _DateClickCallBack clickCallback,
          }) {

        int timeType;
        if(dateType == DateType.YM){
          timeType =  PickerDateTimeType.kYM;
        }else if(dateType == DateType.YMD_HM){
          timeType =  PickerDateTimeType.kYMDHM;
        }else if(dateType == DateType.YMD_AP_HM){
          timeType =  PickerDateTimeType.kYMD_AP_HM;
        }else{
          timeType =  PickerDateTimeType.kYMD;
        }

        openModalPicker(context,
        adapter: adapter ??
        DateTimePickerAdapter(
        type: timeType,
        isNumberMonth: true,
        yearSuffix: "年",
        monthSuffix: "月",
        daySuffix: "日",
        strAMPM: const["上午", "下午"],
        maxValue: maxValue ,
        minValue: minValue,
        value: value ?? DateTime.now(),
        ),
        title: title,
        clickCallBack:(Picker picker, List<int> selecteds){

          var time = (picker.adapter as DateTimePickerAdapter).value;
          var timeStr;
          if(dateType == DateType.YM){
            timeStr =time.year.toString()+"年"+time.month.toString()+"月";
          }else if(dateType == DateType.YMD_HM){
            timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日"+time.hour.toString()+"时"+time.minute.toString()+"分";
          }else if(dateType == DateType.YMD_AP_HM){
          var str = formatDate(time, [am])=="AM" ? "上午":"下午";
          timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日"+str+time.hour.toString()+"时"+time.minute.toString()+"分";
          }else{
            timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日";
          }
//          print(formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd]));
             clickCallback(timeStr,picker.adapter.text);

          }

          );

        }








}

