///  jh_monitor_network_utils.dart
///
///  Created by iotjin on 2020/07/02.
///  description:  网络监测

// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class JhMonitorNetworkUtils {
  /// 是否有网
  static Future<bool> isNetwork() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  /// 获取网络状态：0 无网络，1 手机，2 wifi，3 其他（以太网、VPN、蓝牙等）
  static Future<int> getNetworkStatus() async {
    final results = await Connectivity().checkConnectivity();
    if (!results.any((r) => r != ConnectivityResult.none)) {
      return 0;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      // 网络类型为移动网络
      return 1;
    }
    if (results.contains(ConnectivityResult.wifi)) {
      // 网络类型为WIFI
      return 2;
    }
    // 以太网、VPN、蓝牙、卫星等
    return 3;
  }

  /// 监听网络变化，返回 [StreamSubscription] 供调用方 cancel，避免泄漏
  static StreamSubscription<List<ConnectivityResult>> monitorNetwork({
    void Function(List<ConnectivityResult>)? onChanged,
  }) {
    return Connectivity().onConnectivityChanged.listen((results) {
      onChanged?.call(results);
      print(results);
    });
  }

  /// 定义一个异步生成器
  static Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();

    // 遍历onConnectivityChanged 构成的 Stream<ConnectivityResult>
    await for (List<ConnectivityResult> results in connectivity.onConnectivityChanged) {
      // 状态发生改变后将状态值添加到Stream数据流中
      for (ConnectivityResult result in results) {
        yield result;
      }
    }
  }
}
