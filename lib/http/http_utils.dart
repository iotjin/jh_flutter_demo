/**
 *  http_utils.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  网络请求工具类（dio二次封装）
 */

import 'package:dio/dio.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import 'apis.dart';
import 'dio_utils.dart';
import 'intercept.dart';
import 'log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

// 日志开关
const bool isOpenLog = true;
const bool isOpenAllLog = false;

class HttpUtils {
  /// dio main函数初始化
  static void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());

    /// 刷新Token
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!LogUtils.inProduction && isOpenAllLog) {
      interceptors.add(LoggingInterceptor()); // 调试打开
    }
    configDio(
      baseUrl: APIs.apiPrefix,
      interceptors: interceptors,
    );
  }

  /// get 请求
  static void get<T>(
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    _request(Method.get, url, parameters, success: success, fail: fail);
  }

  /// post 请求
  static void post<T>(
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    _request(Method.post, url, parameters, success: success, fail: fail);
  }

  /// _request 请求
  static void _request<T>(
    Method method,
    String url,
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    // 参数处理（如果需要加密等统一参数）
    if (!LogUtils.inProduction && isOpenLog) {
      print("---------- HttpUtils parameters ----------");
      print(parameters);
    }

    var data;
    var queryParameters;
    if (method == Method.get) {
      queryParameters = parameters;
    }
    if (method == Method.post) {
      data = parameters;
    }

    DioUtils.instance.request(method, url,
        data: data, queryParameters: queryParameters, onSuccess: (result) {
      if (!LogUtils.inProduction && isOpenLog) {
        print("---------- HttpUtils response ----------");
        print(result);
      }
      if (result['code'] == 200) {
        if (success != null) {
          success(result);
        }
      } else {
        // 其他状态，弹出错误提示信息
        JhProgressHUD.showText(result['msg']);
      }
    }, onError: (code, msg) {
      JhProgressHUD.showError(msg);
      if (fail != null) {
        fail(code);
      }
    });
  }
}
