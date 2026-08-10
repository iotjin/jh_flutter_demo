///  mock_interceptor.dart
///
///  description: Dio 本地 Mock 拦截器

import 'package:dio/dio.dart';
import '../apis.dart';
import 'mock_data.dart';

class MockInterceptor extends Interceptor {
  /// 给独立创建的 Dio 挂载本地 Mock（Demo 页自行 new Dio 时使用）
  static void attachIfNeeded(Dio dio) {
    if (kEnableLocalMock) {
      dio.interceptors.add(MockInterceptor());
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final result = MockData.resolve(
      options.path,
      method: options.method,
      data: options.data,
      queryParameters: options.queryParameters,
    );

    if (result == null) {
      handler.next(options);
      return;
    }

    handler.resolve(
      Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
        statusMessage: 'OK',
        data: result,
      ),
    );
  }
}
