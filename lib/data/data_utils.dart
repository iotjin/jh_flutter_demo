/**
 *  data_utils.dart
 *
 *  Created by iotjin on 2021/04/01.
 *  description: 项目数据请求 管理类
 */

import 'package:jh_flutter_demo/jh_common/widgets/jh_progress_hud.dart';

import '../data/apis.dart';
import '../http/http_utils.dart';
import '../http/dio_utils.dart';
import '../http/log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

class DataUtils {
  //登录
  static void login<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
//    DioUtils.request(Method.POST, APIs.login, parameters,
//        success: success, fail: fail);
    HttpUtils.post(APIs.login, parameters, success: success, fail: fail);
  }

  //分页加载数据
  static void getPageList<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
    HttpUtils.get(APIs.getPage, parameters, success: success, fail: fail);
  }

  //分页加载分组数据
  static void getPageGroupList<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
    HttpUtils.get(APIs.getGroupPage, parameters, success: success, fail: fail);
  }
}
