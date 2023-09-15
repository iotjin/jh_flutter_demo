///  jh_string_utils.dart
///
///  Created by iotjin on 2020/03/25.
///  description:  字符串工具类

class JhStringUtils {
  /// num类型转String类型整数
  static String toIntStr(num? value) {
    return (value ?? 0).toInt().toString();
  }

  /// String类型转num类型，为空转成0
  static num toNum(String? value) {
    return num.tryParse(value ?? '') ?? 0;
    // if (value == null || value.length <= 0) {
    //   return 0;
    // } else {
    //   return num.parse(value);
    // }
  }
}
