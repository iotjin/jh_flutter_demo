///  jh_utc_time_utils.dart
///
///  Created by iotjin on 2020/03/25.
///  description:  utc时间工具类

import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class JhUTCTimeUtils {
  /// utc时间转本地时间
  /// utcTime: 2023-07-18T02:04:27.9268823
  /// 返回格式：10:04 18/07/2023
  static String utcToLocalTime(String utcTime, [List<String>? formats]) {
    // DateTime dateTime0 = DateTime.parse('2023-07-18T02:04:27.9268823');
    // // 计算本地时区的时间偏移（以分钟为单位）
    // int offset = DateTime.now().timeZoneOffset.inMinutes;
    // DateTime dateTime2 = dateTime0.add(Duration(minutes: offset));
    // print('dateTime2: ${dateTime2}');

    DateTime utcDateTime = DateTime.parse(utcTime);
    // local time
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(utcDateTime.toString(), true).toLocal();
    // print('local: ${dateTime}');
    return formatDate(dateTime, [HH, ':', nn, ' ', dd, '/', mm, '/', yyyy]);
  }

  /// utc时间转本地时间
  /// utcTime: 2023-07-18T02:04:27.9268823
  /// 返回格式：18/07/2023
  static String utcToLocalDateSlash(String utcTime, [List<String>? formats]) {
    DateTime utcDateTime = DateTime.parse(utcTime);
    // local time
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(utcDateTime.toString(), true).toLocal();
    // print('local: ${dateTime}');
    return formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
  }
}
