///  jh_common_utils.dart
///
///  Created by iotjin on 2020/07/28.
///  description:  设备信息工具类

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class JhDeviceUtils {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isMobile2 =>
      defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  /// Platform不能在web端使用
  static bool get isWeb => kIsWeb;

  static bool get isWindows => isWeb ? false : Platform.isWindows;

  static bool get isLinux => isWeb ? false : Platform.isLinux;

  static bool get isMacOS => isWeb ? false : Platform.isMacOS;

  static bool get isAndroid => isWeb ? false : Platform.isAndroid;

  static bool get isFuchsia => isWeb ? false : Platform.isFuchsia;

  static bool get isIOS => isWeb ? false : Platform.isIOS;

  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  static Future<String> appName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.appName;
  }

  static Future<String> packageName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.packageName;
  }

  static Future<String> version() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.version;
  }

  static Future<String> buildNumber() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildNumber;
  }

  static Future<String> buildSignature() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildSignature;
  }

  static Future<String?> installerStore() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.installerStore;
  }

/* 使用

  void _getPackageInfo() async {
    PackageInfo packageInfo = await JhDeviceUtils.getPackageInfo();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String buildSignature = packageInfo.buildSignature;
    String installerStore = packageInfo.installerStore ?? 'not available';
    print('packageInfo：');
    print('appName $appName');
    print('packageName $packageName');
    print('version $version');
    print('buildNumber $buildNumber');
    print('buildSignature $buildSignature');
    print('installerStore $installerStore');
  }

 void _getPackageInfo() async {
    String version = await JhDeviceUtils.version();
    print('app version = ：$version');
    setState(() {
      _currentVersion = version;
    });
  }

  void _getPackageInfo() {
    JhDeviceUtils.version().then((version) {
      print('app version = ：$version');
      setState(() {
        _currentVersion = version;
      });
    });
  }

*/

}
