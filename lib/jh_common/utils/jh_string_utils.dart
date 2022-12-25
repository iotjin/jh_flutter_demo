///  jh_string_utils.dart
///
///  Created by iotjin on 2020/03/25.
///  description:  字符串工具类

extension StringExtension on String? {
  /// String 空安全处理
  String get jhNullSafe => this ?? '';
}

extension IntExtension on int? {
  /// int类型转String类型整数
  String get jhIntToStr => (this ?? 0).toString();
}

extension NumExtension on num? {
  /// num类型转String类型整数
  String get jhToIntStr => (this ?? 0).toInt().toString();
}

class JhStringUtils {
  /// num类型转String类型整数
  static String toIntStr(num? value) {
    return (value ?? 0).toInt().toString();
  }
}
