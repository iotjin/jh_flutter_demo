/**
 *  jh_defaults_utils.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  数据存储 ,封装第三方
 */

import 'package:flustars/flustars.dart';

class JhDefaultsUtils {
  static Future<bool> saveString(String key, String value) {
    return SpUtil.putString(key, value);
  }

  static String getStringWithKey(String key) {
    return SpUtil.getString(key);
  }

  static Future<bool> saveBool(String key, bool value) {
    return SpUtil.putBool(key, value);
  }

  static bool getBoolWithKey(String key) {
    return SpUtil.getBool(key);
  }

  static Future<bool> saveModel(String key, Object model) {
    return SpUtil.putObject(key, model);
  }

  static getModelWithKey(String key) {
    Map<String, dynamic> json = SpUtil.getObject(key);
    return json;
  }

  static Future<bool> removeWithKey(String key) {
    return SpUtil.remove(key);
  }
}
