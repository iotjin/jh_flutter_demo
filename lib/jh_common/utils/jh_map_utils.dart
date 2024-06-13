///  jh_map_utils.dart
///
///  Created by iotjin on 2023/05/06.
///  description: 跳转三方地图APP导航

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import 'jh_device_utils.dart';

class JhMapUtils {
  /// 跳转其他App
  static Future<void> jumpApp({String? url, String message = '跳转失败！'}) async {
    final Uri uri = Uri.parse(url ?? '');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint(message);
      // JhProgressHUD.showText(message);
    }
  }

  /// 判断地图是否有安装
  static Future<bool> isInstallMap(String url) async {
    // var url = Uri.parse(Uri.encodeFull(url));
    // final Uri uri = Uri.parse(url);
    bool canLaunch = await canLaunchUrl(Uri.parse(url));
    debugPrint('canLaunch: $canLaunch');
    return canLaunch;
  }

  /// 跳转高德导航 - 路径规划
  /// 高德地图官方文档 - Android: https://lbs.amap.com/api/amap-mobile/guide/android/route
  /// 高德地图官方文档 - iOS: https://lbs.amap.com/api/amap-mobile/guide/ios/route
  static void openAMapNavi({
    double? sLatitude, // 起点纬度
    double? sLongitude, // 起点经度
    String sName = '', // 起点名称
    required double dLatitude, // 终点纬度
    required double dLongitude, // 终点经度
    String dName = '', // 终点名称
    String dev = '0', // 起终点是否偏移。0:lat和lon是已经加密后的,不需要国测加密;1:需要国测加密，可为空，但起点或终点不为空时，不能为空
    String t = '0', // t = 0 驾车；    t = 1 公交；    t = 2 步行；    t = 3 骑行（骑行仅在V788以上版本支持）
    String message = '您没有安装高德地图，请先安装高德地图！',
  }) async {
    if (!JhDeviceUtils.isMobile) {
      return;
    }
    var type = JhDeviceUtils.isIOS ? 'iosamap://path?sourceApplication=applicationName&' : 'amapuri://route/plan/?';
    var url = '${type}sid=&slat=${sLatitude ?? ''}&slon=${sLongitude ?? ''}&sname=$sName&dlat=$dLatitude&dlon=$dLongitude&dname=$dName&dev=$dev&t=$t';
    if (!await isInstallMap(url)) {
      JhProgressHUD.showText(message);
      return;
    }
    await launchUrl(Uri.parse(url));
  }

  /// 跳转高德导航
  /// 高德地图官方文档: https://lbs.amap.com/api/amap-mobile/guide/android/navigation
  static void openAMapNavi2({
    required double latitude,
    required double longitude,
    String poiName = '',
    String dev = '0', // 是否偏移(0:lat 和 lon 是已经加密后的,不需要国测加密; 1:需要国测加密)
    String message = '您没有安装高德地图，请先安装高德地图！',
  }) async {
    var device = JhDeviceUtils.isAndroid ? 'android' : 'ios';
    var url = '${device}amap://navi?sourceApplication=amap&poiname=$poiName&lat=$latitude&lon=$longitude&dev=$dev';
    if (!await isInstallMap(url)) {
      JhProgressHUD.showText(message);
      return;
    }
    await launchUrl(Uri.parse(url));
  }

  /// 跳转百度导航 - 路径规划
  /// 百度地图官方文档: https://lbsyun.baidu.com/index.php?title=uri/api/android
  static void openBaiduMapNavi({
    double? sLatitude, // 起点纬度
    double? sLongitude, // 起点经度
    String sName = '', // 起点名称
    required double dLatitude, // 终点纬度
    required double dLongitude, // 终点经度
    String dName = '', // 终点名称
    String mode = 'driving', // 导航模式，可选transit（公交）、driving（驾车）、walking（步行）和riding（骑行）默认:driving
    String coordType = 'gcj02', // 坐标类型，必选参数。coord_type= bd09ll 允许的值为：bd09ll（百度经纬度坐标） bd09mc（百度墨卡托坐标） gcj02（经国测局加密的坐标） wgs84（gps获取的原始坐标）
    String message = '您没有安装百度地图，请先安装百度地图！',
  }) async {
    var url =
        'baidumap://map/direction?origin=name:$sName|latlng:$sLatitude,$sLongitude&destination=name:$dName|latlng:$dLatitude,$dLongitude&mode=$mode&coord_type=$coordType';
    if (!await isInstallMap(url)) {
      JhProgressHUD.showText(message);
      return;
    }
    await launchUrl(Uri.parse(url));
  }

  /// 跳转腾讯导航
  /// 腾讯地图官方文档: https://lbs.qq.com/webApi/uriV1/uriGuide/uriMobileRoute
  static void openTencentMapNavi({
    double? sLatitude, // 起点纬度
    double? sLongitude, // 起点经度
    String sName = '', // 起点名称
    required double dLatitude, // 终点纬度
    required double dLongitude, // 终点经度
    String dName = '', // 终点名称
    String type = 'drive', // 路线规划方式参数：  公交：bus  驾车：drive  步行：walk  骑行：bike
    String referer = 'OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77', // 请填写开发者key，
    String message = '您没有安装腾讯地图，请先安装腾讯地图！',
  }) async {
    // 起点坐标，格式：lat,lng （纬度在前，经度在后，逗号分隔）  功能参数值：CurrentLocation ：使用定位点作为起点坐标
    var formInfo = (sLatitude == null || sLongitude == null) ? 'from=$sName&CurrentLocation' : 'from=$sName&fromcoord=$sLatitude,$sLongitude';
    var url = 'qqmap://map/routeplan?type=$type&$formInfo&to=$dName&tocoord=$dLatitude,$dLongitude&referer=$referer';
    if (!await isInstallMap(url)) {
      JhProgressHUD.showText(message);
      return;
    }
    await launchUrl(Uri.parse(url));
  }

  static const double earthRadius = 6378.137; //地球半径

  //计算两点间距离
  static double distance(double lat1, double lng1, double lat2, double lng2) {
    double radLat1 = _rad(lat1);
    double radLat2 = _rad(lat2);
    double a = radLat1 - radLat2;
    double b = _rad(lng1) - _rad(lng2);
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    s *= earthRadius;
    s = (s * 10000).round() / 10000;
    return s;
  }

  static double _rad(double d) {
    return d * pi / 180.0; //角度转换成弧度
  }
}
