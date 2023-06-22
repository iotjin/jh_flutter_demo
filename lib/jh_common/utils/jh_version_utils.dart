///  jh_version_utils.dart
///
///  Created by iotjin on 2023/04/02.
///  description:

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import 'jh_device_utils.dart';
import '/project/configs/project_config.dart';

class JhVersionUtils {
  /// 跳转AppStore
  static Future<void> jumpAppStore({String? url}) async {
    // 这是微信的地址，到时候换成自己的应用的地址
    final tempURL = url ?? 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8';
    final Uri uri = Uri.parse(tempURL);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      JhProgressHUD.showText('跳转失败！');
    }
  }

  /// 安卓检查更新
  /// 返回是否有新版本、安卓apk下载地址和版本号
  static Future androidCheckUpdate() async {
    var api = 'https://api.github.com/repos/iotjin/jh_flutter_demo/releases/latest';
    var dio = Dio();
    var response = await dio.get(api);
    Map data = response.data;
    if (data.isNotEmpty) {
      String url = data['assets'][0]['browser_download_url'];
      String tagName = data['tag_name'];
      String version = tagName.substring(1);
      String appVersion = await JhDeviceUtils.version();
      bool hasNewVersion = JhVersionUtils.hasNewVersion(appVersion, version);
      return {'hasNewVersion': hasNewVersion, 'url': url, 'tagName': tagName};
    }
    return {'hasNewVersion': false};
  }

  /// 版本比较，是否有新版本
  /// appVersion：项目当前版本
  /// version：要比较的版本(比如从服务器获取的最新版本)
  static bool hasNewVersion(String appVersion, String version) {
    // compareTo比较时如果某一位为10以上判断错误
    // print(appVersion.compareTo(version)); // 字符串 比较大小, 0:相同、1:大于、-1:小于
    // return appVersion.compareTo(version) < 0 ? true : false;
    return compareVersions(appVersion, version) < 0 ? true : false;
  }

  /// 版本比较
  ///  1：version1 > version2
  /// -1：version1 < version2
  ///  0：version1 = version2
  static int compareVersions(String version1, String version2) {
    List<String> v1Segments = version1.split('.');
    List<String> v2Segments = version2.split('.');
    final minLength = v1Segments.length < v2Segments.length ? v1Segments.length : v2Segments.length;
    for (int i = 0; i < minLength; i++) {
      final v1 = int.parse(v1Segments[i]);
      final v2 = int.parse(v2Segments[i]);
      if (v1 > v2) {
        return 1;
      } else if (v1 < v2) {
        return -1;
      }
    }
    if (v1Segments.length > v2Segments.length) {
      return 1;
    } else if (v1Segments.length < v2Segments.length) {
      return -1;
    } else {
      return 0;
    }
  }

  /// 打开手机文档中的apk文件
  /// 需要用release版本，debug版使用需要在build.gradle配置debug使用release签名，否则安装不上
  static Future<OpenResult> openAPK(String path) async {
    final result = await OpenFilex.open(path);
    debugPrint('打开apk result: ${result.type}');
    debugPrint(result.message);
    return result;
    // 打开apk
    // var path = '/storage/emulated/0/Android/data/com.jh.jh_flutter_demo/files/Download/jh_flutter_demo.apk';
    // OpenFilex.open(path).then((result) {
    //   debugPrint('打开apk result: ${result.type}');
    //   debugPrint(result.message);
    // });

    // 另一个三方库
    // OpenFile.open(path);
  }
}
