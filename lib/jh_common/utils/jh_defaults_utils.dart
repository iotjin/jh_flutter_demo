/**
 *  jh_defaults_utils.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  数据存储 ,封装第三方
 */

import 'package:flustars/flustars.dart';

class JhDefaultsUtils{

  static saveBool(String key,bool value){
    SpUtil.putBool(key, value);
  }
  static getBoolWithKey(String key){
    return SpUtil.getBool(key);
  }

  static saveModel(String key,Object model){
    SpUtil.putObject(key, model);
  }

  static getModelWithKey(String key){
    Map<String, dynamic> json = SpUtil.getObject(key);
    return json;
  }

}