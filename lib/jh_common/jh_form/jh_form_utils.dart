///  jh_form_utils.dart
///
///  Created by iotjin on 2022/07/13.
///  description:  录入限制和校验

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/services.dart';
import '/http/log_utils.dart';

// 手机号
final phone = [number, LengthLimitingTextInputFormatter(11)];
// 密码
final pwd = [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]|[0-9.]')), length16];
// 验证码(6位数字)
final code = [FilteringTextInputFormatter.digitsOnly, length6];

// 数字
final number = FilteringTextInputFormatter.allow(RegExp('[0-9]'));
// 年龄
final age = FilteringTextInputFormatter.allow(RegExp('[1-9]'));
// 字母
final letter = FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));
// 允许中文
final chinese = FilteringTextInputFormatter.allow(RegExp('[\u4e00-\u9fa5]'));
// 小数 | 小数键盘 TextInputType.numberWithOptions(decimal: true)
final decimal = FilteringTextInputFormatter.allow(RegExp('[0-9.]'));
// 金额：10位整数。2位小数
final money = NumLengthInputFormatter(integerLength: 8, decimalLength: 2);
// 两位小数，整数不限
final twoDecimal = FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.)?[0-9]{0,2}'));

// 不允许录入中文
final denyChinese = FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'));
// 限制只能输入汉字或者字母或数字
final test = FilteringTextInputFormatter(RegExp('[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]'), allow: true);

// 长度限制
final length5 = LengthLimitingTextInputFormatter(5);
final length6 = LengthLimitingTextInputFormatter(6);
final length8 = LengthLimitingTextInputFormatter(8);
final length10 = LengthLimitingTextInputFormatter(10);
final length16 = LengthLimitingTextInputFormatter(16);
final length50 = LengthLimitingTextInputFormatter(50);
final length100 = LengthLimitingTextInputFormatter(100);
final length150 = LengthLimitingTextInputFormatter(150);
final length200 = LengthLimitingTextInputFormatter(200);
final length300 = LengthLimitingTextInputFormatter(300);
final length500 = LengthLimitingTextInputFormatter(500);

// 手机号正则
final regularIsPhone = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
final regularIsPhone2 = RegExp(r'^1[3-9][0-9]{9}$');

/// Flutter 用策略模式进行表单验证
/// https://juejin.cn/post/6858173808017145863

class _Strategies {
  /// 是否必填
  String require(value, String message) {
    return (value == null || value == '' || value == 0 || value == false) ? message : '';
  }

  /// 正则匹配
  String pattern(String value, RegExp reg, String message) {
    return reg.hasMatch(value) ? '' : message;
  }

  /// 最小长度
  String minLength(value, int len, String message) {
    if (value is String) {
      return value.length >= len ? '' : message;
    }
    if (value is int || value is double) {
      var number = value.toDouble();
      return number >= len ? '' : message;
    }
    return message;
  }

  /// 最大长度
  String maxLength(value, int len, String message) {
    if (value is String) {
      return value.length <= len ? '' : message;
    }
    if (value is int || value is double) {
      var number = value.toDouble();
      return number <= len ? '' : message;
    }
    return message;
  }
}

/// 定义策略类
class JhValidate extends _Strategies {
  var rules;
  var params;

  List<Function> validateList = [];

  JhValidate(this.rules, this.params) {
    addRule(rules);
  }

  /// 添加规则
  void addRule(rule) {
    var strategiesArr = {
      'require': require,
      'pattern': pattern,
      'minLength': minLength,
      'maxLength': maxLength,
    };
    rule.forEach((keyIndex, ruleValue) {
      var value = params[keyIndex];
      var iterator = rules[keyIndex];
      iterator.forEach((item) {
        item.forEach((key, item2) {
          if (strategiesArr.containsKey(key)) {
            if (key == 'require' && item2 == true) {
              validateList.add(() {
                return strategiesArr[key]!(value, item['message']);
              });
            } else {
              validateList.add(() {
                return strategiesArr[key]!(value, item[key], item['message']);
              });
            }
          }
        });
      });
    });
  }

  /// 校验
  check() {
    for (var index = 0; index < validateList.length; index++) {
      var message = validateList[index]();
      if (message != '') {
        LogUtils.print_('object: ${validateList[index]()}');
        LogUtils.print_('object: ${validateList[index]}');
        return validateList[index]();
      }
    }
  }
}

/// 限制输入整数位数和小数位数
/// inputFormatters: [NumLengthInputFormatter(integerLength: 8, decimalLength: 2)]
class NumLengthInputFormatter extends TextInputFormatter {
  NumLengthInputFormatter({
    this.integerLength = 8,
    this.decimalLength = 2,
    this.allowInputDecimal = true,
  });

  final int integerLength;
  final int decimalLength;
  final bool allowInputDecimal;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (newValue.text.contains('.')) {
      int pointIndex = newValue.text.indexOf('.');
      String beforePoint = newValue.text.substring(0, pointIndex);
      // print('$beforePoint');
      // 小数点前内容大于integerLength
      if (beforePoint.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      } else {
        // 小数点前内容小于等于integerLength
        String afterPoint = newValue.text.substring(pointIndex + 1, newValue.text.length);
        if (afterPoint.length > decimalLength) {
          value = oldValue.text;
          selectionIndex = oldValue.selection.end;
        }
      }
    } else {
      if (newValue.text.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
