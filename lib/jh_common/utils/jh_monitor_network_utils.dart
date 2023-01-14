///  jh_monitor_network_utils.dart
///
///  Created by iotjin on 2020/07/02.
///  description:  网络监测

// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';

class JhMonitorNetworkUtils {
  /// 是否有网
  static Future<bool> isNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  /// 获取网络状态：0 无网络，1 手机，2 wifi
  static Future<int> getNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // 网络类型为移动网络
      return 1;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // 网络类型为WIFI
      return 2;
    } else {
      return 0;
    }
  }

  static String? monitorNetwork() {
    Connectivity().onConnectivityChanged.listen((event) {
      print(event);
    });
  }

  /// 定义一个异步生成器
  static Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();

    // 遍历onConnectivityChanged 构成的 Stream<ConnectivityResult>
    await for (ConnectivityResult result in connectivity.onConnectivityChanged) {
      // 状态发生改变后将状态值添加到Stream数据流中
      yield result;
    }
  }
}
