/**
 *  jh_storage_utils.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  aes 数据存储 ,封装第三方
 */

import 'dart:convert' as convert;

import 'package:flustars/flustars.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_encrypt_utils.dart';

// aes 加密存储
class JhStorageUtils {
  //存 String
  static Future<bool> saveString(String key, String value) {
    key = JhEncryptUtils.aesEncrypt(key);
    value = JhEncryptUtils.aesEncrypt(value);
    return SpUtil.putString(key, value);
  }

  //取 String
  static String getStringWithKey(String key) {
    key = JhEncryptUtils.aesEncrypt(key);
    var enValue = SpUtil.getString(key);
    if (enValue.length > 0) {
      return JhEncryptUtils.aesDecrypt(enValue);
    }
    return enValue;
  }

  //存 bool
  static Future<bool> saveBool(String key, bool value) {
    var newValue = value == true ? "TRUE" : "FALSE";
    return saveString(key, newValue);
  }

  //取 bool
  static bool getBoolWithKey(String key) {
    var value = getStringWithKey(key);
    return value == "TRUE" ? true : false;
  }

  //存 int
  static Future<bool> saveInt(String key, int value) {
    var newValue = value.toString();
    return saveString(key, newValue);
  }

  //取 int
  static int getIntWithKey(String key) {
    var value = getStringWithKey(key);
    value = value == '' ? '0' : value;
    return int.parse(value);
  }

  //存 double
  static Future<bool> saveDouble(String key, double value) {
    var newValue = value.toString();
    return saveString(key, newValue);
  }

  //取 double
  static double getDoubleWithKey(String key) {
    var value = getStringWithKey(key);
    value = value == '' ? '0' : value;
    return double.parse(value);
  }

  //存 Model
  static Future<bool> saveModel(String key, Object model) {
    String jsonString = convert.jsonEncode(model);
    return saveString(key, jsonString);
  }

  //取 Model
  static Map getModelWithKey(String key) {
    var jsonString = getStringWithKey(key);
    return (jsonString == null || jsonString.isEmpty)
        ? null
        : convert.jsonDecode(jsonString);
  }

  //移除
  static Future<bool> removeWithKey(String key) {
    key = JhEncryptUtils.aesEncrypt(key);
    return SpUtil.remove(key);
  }
}

//不使用aes加密
class JhStorageNoAESUtils {
  //存 String
  static Future<bool> saveString(String key, String value) {
    return SpUtil.putString(key, value);
  }

  //取 String
  static String getStringWithKey(String key) {
    return SpUtil.getString(key);
  }

  //存 bool
  static Future<bool> saveBool(String key, bool value) {
    return SpUtil.putBool(key, value);
  }

  //取 bool
  static bool getBoolWithKey(String key) {
    return SpUtil.getBool(key);
  }

  //存 int
  static Future<bool> saveInt(String key, int value) {
    return SpUtil.putInt(key, value);
  }

  //取 int
  static int getIntWithKey(String key) {
    return SpUtil.getInt(key);
  }

  //存 double
  static Future<bool> saveDouble(String key, double value) {
    return SpUtil.putDouble(key, value);
  }

  //取 double
  static double getDoubleWithKey(String key) {
    return SpUtil.getDouble(key);
  }

  //存 Model
  static Future<bool> saveModel(String key, Object model) {
    return SpUtil.putObject(key, model);
  }

  //取 Model
  static Map getModelWithKey(String key) {
    Map<String, dynamic> json = SpUtil.getObject(key);
    return json;
  }

  //移除
  static Future<bool> removeWithKey(String key) {
    return SpUtil.remove(key);
  }
}
