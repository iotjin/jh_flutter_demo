///  intercept.dart
///
///  Created by iotjin on 2020/07/08.
///  description:  拦截器

import 'package:dio/dio.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import 'apis.dart';
import 'dio_utils.dart';
import 'error_handle.dart';
import 'log_utils.dart';

// default token
const String defaultToken = '';
const String kRefreshTokenUrl = APIs.refreshToken;

String getToken() {
  var token = JhStorageUtils.getString('accessToken') ?? defaultToken;
  return token;
}

void setToken(accessToken) {
  JhStorageUtils.saveString('accessToken', accessToken);
}

String getRefreshToken() {
  var refreshToken = JhStorageUtils.getString('refreshToken') ?? '';
  return refreshToken;
}

void setRefreshToken(refreshToken) {
  JhStorageUtils.saveString('refreshToken', refreshToken);
}

/// 统一添加身份验证请求头（根据项目自行处理）
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path != APIs.login) {
      final String accessToken = getToken();
      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    super.onRequest(options, handler);
  }
}

/// 刷新Token（根据项目自行处理）
class TokenInterceptor extends QueuedInterceptor {
  Dio? _tokenDio;

  Future<Map<String, dynamic>?> refreshTokenRequest() async {
    var params = {'accessToken': getToken(), 'refreshToken': getRefreshToken()};
    try {
      _tokenDio ??= Dio();
      _tokenDio!.options = DioUtils.instance.dio.options;
      _tokenDio!.options.headers['Authorization'] = 'Bearer ${getToken()}';
      final Response<dynamic> response = await _tokenDio!.post<dynamic>(kRefreshTokenUrl, data: params);
      var res = response.data as dynamic;
      if (res['code'] == ExceptionHandle.success) {
        return response.data;
      }
      // if (response.statusCode == ExceptionHandle.success) {
      //   return response.data;
      // }
    } catch (e) {
      LogUtils.e('---------- 刷新Token失败！----------');
    }
    return null;
  }

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    // 401代表token过期
    if (response.statusCode == ExceptionHandle.unauthorized) {
      LogUtils.d('---------- 自动刷新Token ----------');

      var res = await refreshTokenRequest(); // 获取新的accessToken
      if (res != null) {
        var accessToken = res['accessToken'];
        LogUtils.e('---------- NewToken: $accessToken ----------');

        // 保存token
        setToken(accessToken);
        setRefreshToken(res['refreshToken']);

        // 重新请求失败接口
        final RequestOptions request = response.requestOptions;
        request.headers['Authorization'] = 'Bearer $accessToken';

        final Options options = Options(
          headers: request.headers,
          method: request.method,
        );

        try {
          LogUtils.e('---------- 重新请求接口 ----------');

          /// 避免重复执行拦截器，使用tokenDio
          final Response<dynamic> response = await _tokenDio!.request<dynamic>(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: options,
            onReceiveProgress: request.onReceiveProgress,
          );
          return handler.next(response);
        } on DioError catch (e) {
          return handler.reject(e);
        }
      }
    }
    super.onResponse(response, handler);
  }
}

/// 打印日志
class LoggingInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    LogUtils.d('-------------------- Start --------------------');
    if (options.queryParameters.isEmpty) {
      LogUtils.d('RequestUrl: ${options.baseUrl}${options.path}');
    } else {
      LogUtils.d('RequestUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
    }
    LogUtils.d('RequestMethod: ${options.method}');
    LogUtils.d('RequestHeaders:${options.headers}');
    LogUtils.d('RequestContentType: ${options.contentType}');
    LogUtils.d('RequestData: ${options.data.toString()}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success) {
      LogUtils.d('ResponseCode: ${response.statusCode}');
    } else {
      LogUtils.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    LogUtils.d('返回数据：${response.data}');
    LogUtils.d('-------------------- End: $duration 毫秒 --------------------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtils.d('-------------------- Error --------------------');
    super.onError(err, handler);
  }
}
