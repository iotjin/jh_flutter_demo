/**
 *  http_utils.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  网络请求工具类
 */

import 'package:jh_flutter_demo/jh_common/widgets/jh_progress_hud.dart';
import 'dio_utils.dart';
import 'log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

class HttpUtils {
  //get 请求
  static void get<T>(
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    _request(Method.GET, url, parameters, success: success, fail: fail);
  }

  //post 请求
  static void post<T>(
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    _request(Method.POST, url, parameters, success: success, fail: fail);
  }

  //_request 请求
  static void _request<T>(
    Method method,
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
//    //参数处理
//    LogUtils.d("--------- parameters ---------");
//    LogUtils.d("$parameters");

    DioUtils.request(method, url, parameters, success: (result) {
//      LogUtils.d("--------- response ---------");
//      LogUtils.d('$result');
//      LogUtils.print_(result);
      if (result['code'] == 200) {
        if (success != null) {
          success(result);
        }
      } else {
        //其他状态，弹出错误提示信息
        JhProgressHUD.showText(result['msg']);
      }
    }, fail: (code, msg) {
      JhProgressHUD.showError(msg);
      if (fail != null) {
        fail(code);
      }
    });
  }
}
