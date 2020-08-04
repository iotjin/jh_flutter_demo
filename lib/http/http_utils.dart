/**
 *  http_utils.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  项目接口请求 管理类
 */

import 'package:jh_flutter_demo/jh_common/widgets/jh_progress_hud.dart';

import 'apis.dart';
import 'dio_utils.dart';
import 'log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

class HttpUtils {
  //登录
  static void login<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
//    DioUtils.request(Method.POST, APIs.login, parameters,
//        success: success, fail: fail);
    post(APIs.login, parameters, success: success, fail: fail);
  }

  //分页加载数据
  static void getNewPageList<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
    post(APIs.getPage, parameters, success: success, fail: fail);
  }

  //分页加载分组数据
  static void getNewPageGroupList<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    post(APIs.getGroupPage, parameters, success: success, fail: fail);
  }

  //GET
  static void GetRequest<T>(
    APIType apiType,
    parameters, {
    Success success,
    Fail fail,
  }) {
    post(APITypeValues[apiType], parameters, success: success, fail: fail);
  }

  //POST
  static void PostRequest<T>(
    APIType apiType,
    parameters, {
    Success success,
    Fail fail,
  }) {
    post(APITypeValues[apiType], parameters, success: success, fail: fail);
  }

  /********************************* 分割线 ********************************/

  //get 请求
  static void get<T>(
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    _request(Method.GET, url, parameters, success: success, fail: fail);
  }

  //post 请求
  static void post<T>(
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    _request(Method.POST, url, parameters, success: success, fail: fail);
  }

  //_request 请求
  static void _request<T>(
    Method method,
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    /// restful 请求处理
    /// /base/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /base/search/hist/27
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
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
