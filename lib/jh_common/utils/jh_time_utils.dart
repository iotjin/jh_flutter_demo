///  jh_time_utils.dart
///
///  Created by iotjin on 2020/03/25.
///  description:  时间工具类

// ignore_for_file: constant_identifier_names

import 'package:date_format/date_format.dart';

const YMD = [yyyy, '-', mm, '-', dd];
const YMDzh = [yyyy, '年', mm, '月', dd, '日 '];
const YMDHMS = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss];
const YMDHMSzh = [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn, ':', ss];

const weekText = ['一', '二', '三', '四', '五', '六', '日'];

class JhTimeUtils {
  /// 获取当前时间戳（默认13位）
  static int getTimeStamp({isMicroseconds = false}) {
    DateTime currentTime = DateTime.now();
    return timeToTimeStamp(currentTime.toString());
  }

  /// 将某个格式时间转化成时间戳（默认13位）
  static int timeToTimeStamp(String time, {isMicroseconds = false}) {
    DateTime dateTime = DateTime.parse(_handleTime(time));
    int timeStamp = dateTime.millisecondsSinceEpoch; // 当前13位毫秒时间戳
    if (isMicroseconds) {
      timeStamp = dateTime.microsecondsSinceEpoch; // 当前16位微秒时间戳
    }
    return timeStamp;
  }

  /// 将某个格式时间转化为指定格式时间
  /// 支持格式：2022-07-03 14:59:31.202990 | 2019-02-02 | 2019-02-02 00:00:00
  /// 支持格式：2019/2/2 | 2019/02/02 |2019/2/2 00:00:00 |2019/02/02 00:00:00
  /// 支持格式：2019年2月2日 | 2019年02月02日 | 2019年2月2日 10:09:05 | 2019年02月02日 10:09:05
  /// 默认返回格式：2019-02-02 00:00:00
  static String timeToTime(String time, [List<String>? formats]) {
    DateTime dateTime = DateTime.parse(_handleTime(time));
    return dateTimeToTime(dateTime, formats);
  }

  /// 将某个DateTime格式时间转化为指定格式时间
  static String dateTimeToTime(DateTime date, [List<String>? formats]) {
    if (formats != null) {
      return formatDate(date, formats);
    } else {
      formats = YMDHMS;
      return formatDate(date, formats);
    }
  }

  /// 获取当前年
  /// 2019
  static String getYear() {
    return dateTimeToTime(DateTime.now(), [yyyy]);
  }

  /// 获取当前月
  /// 02
  static String getMonth() {
    return dateTimeToTime(DateTime.now(), [mm]);
  }

  /// 获取当前日
  /// 02
  static String getDay() {
    return dateTimeToTime(DateTime.now(), [dd]);
  }

  /// 获取当前周
  /// 日 或 7
  static String getWeek([isChinese = true]) {
    int week = DateTime.now().weekday;
    if (isChinese) {
      return weekText[week - 1];
    }
    return week.toString();
  }

  /// 获取当前时间
  /// 默认返回格式：2019-02-02 00:00:00
  static String getCurrentTime([List<String>? formats]) {
    return dateTimeToTime(DateTime.now(), formats);
  }

  /// 将某个格式时间转化为多久前
  static String formatTimeAgo(time) {
    DateTime dateTime = DateTime.parse(_handleTime(time));
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()}周前';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}天前';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  /// 处理传入的字符串时间
  /// 将2019年2月2日 | 2019年02月02日 10:09:05 | 2019/2/2 |2019/02/02 00:00:00
  /// 转换成 2019-02-02 00:00:00
  static String _handleTime(String time) {
    if (time.contains('-')) {
      return time;
    }
    time = time.replaceAll(RegExp(r'/'), '-');
    time = time.replaceAll(RegExp(r'年'), '-');
    time = time.replaceAll(RegExp(r'月'), '-');
    time = time.replaceAll(RegExp(r'日'), '');
    if (time.contains(':')) {
      // 带时分秒
      var tempArr = time.split(' ')[0].split('-');
      var year = tempArr[0];
      var month = tempArr[1];
      var day = tempArr[2];
      if (month.length < 2) {
        month = '0$month';
      }
      if (day.length < 2) {
        day = '0$day';
      }
      return '$year-$month-$day ${time.split(' ')[1]}';
    } else {
      var tempArr = time.split('-');
      var year = tempArr[0];
      var month = tempArr[1];
      var day = tempArr[2];
      if (month.length < 2) {
        month = '0$month';
      }
      if (day.length < 2) {
        day = '0$day';
      }
      return '$year-$month-$day';
    }
  }
}
