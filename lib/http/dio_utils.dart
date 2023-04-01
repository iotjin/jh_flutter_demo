///  dio_utils.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  dio工具类

import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '/jh_common/utils/jh_device_utils.dart';
import 'apis.dart';
import 'error_handle.dart';
import 'log_utils.dart';

/// 默认dio配置
String _baseUrl = APIs.apiPrefix;
Duration _connectTimeout = const Duration(seconds: 15);
Duration _receiveTimeout = const Duration(seconds: 15);
Duration _sendTimeout = const Duration(seconds: 10);
List<Interceptor> _interceptors = [];

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);

/// 初始化Dio配置
void configDio({
  Duration? connectTimeout,
  Duration? receiveTimeout,
  Duration? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    // 全局属性：请求前缀、连接超时时间、响应超时时间
    final BaseOptions options = BaseOptions(
      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 “Headers.formUrlEncodedContentType”,  这样[Dio]就会自动编码请求体.
      /// contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交

      responseType: ResponseType.json,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: _baseUrl,
      headers: _httpHeaders,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
    );

    _dio = Dio(options);

    /// Fiddler抓包代理配置
    // dio.httpClientAdapter = IOHttpClientAdapter()
    //   ..onHttpClientCreate = (client) {
    //     // Config the client.
    //     client.findProxy = (uri) {
    //       // Forward all request to proxy "localhost:8888".
    //       return 'PROXY localhost:8888';
    //     };
    //     // 抓Https包设置
    //     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   };

    /// 测试环境忽略证书校验
    var isTest = !LogUtils.inProduction || APIs.apiPrefix.startsWith('https://192');
    if (isTest && JhDeviceUtils.isMobile) {
      dio.httpClientAdapter = IOHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        };
    }

    /// 添加拦截器
    void addInterceptor(Interceptor interceptor) {
      _dio.interceptors.add(interceptor);
    }

    _interceptors.forEach(addInterceptor);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  Future request<T>(
    Method method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback? onSuccess,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      // 没有网络
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        _onError(ExceptionHandle.net_error, '网络异常，请检查你的网络！', onError);
        return;
      }
      final Response response = await _dio.request<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(_methodValues[method], options),
        cancelToken: cancelToken,
      );
      onSuccess?.call(response.data);
    } on DioError catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    }
  }
}

Options _checkOptions(String? method, Options? options) {
  options ??= Options();
  options.method = method;
  return options;
}

void _cancelLogPrint(dynamic e, String url) {
  if (e is DioError && CancelToken.isCancel(e)) {
    LogUtils.e('取消请求接口： $url');
  }
}

void _onError(int? code, String msg, NetErrorCallback? onError) {
  if (code == null) {
    code = ExceptionHandle.unknown_error;
    msg = '未知异常';
  }
  LogUtils.e('接口请求异常： code: $code, mag: $msg');
  onError?.call(code, msg);
}

/// 自定义Header
Map<String, dynamic> _httpHeaders = {
  'Accept': 'application/json,*/*',
  'Content-Type': 'application/json',
};

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

/// 使用：_methodValues[Method.post]
const _methodValues = {
  Method.get: 'get',
  Method.post: 'post',
  Method.delete: 'delete',
  Method.put: 'put',
  Method.patch: 'patch',
  Method.head: 'head',
};
