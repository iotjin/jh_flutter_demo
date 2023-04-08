///  jh_permission_utils.dart
///
///  Created by iotjin on 2023/04/05.
///  description: 封装permission_handler

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '/project/configs/project_config.dart';
import '/jh_common/widgets/jh_dialog.dart';
import 'jh_device_utils.dart';

class JhPermissionUtils {
  /// 请求权限
  static Future<bool> _requestPermission(Permission permission, String message) async {
    var status = await permission.status;
    if (status.isGranted || status.isLimited) {
      return true;
    }
    if (status.isDenied) {
      PermissionStatus permissionStatus = await permission.request();
      if (permissionStatus.isGranted || permissionStatus.isLimited) {
        return true;
      }
      if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
        _showDialog(message);
        return false;
      }
      return false;
    }
    // 永久拒绝
    if (status.isPermanentlyDenied) {
      _showDialog(message);
      return false;
    }

    // iOS14+部分访问相册
    // bool isLimited = await permission.isLimited;
    // if (isLimited) {
    //   _showDialog('你已设置应用只能访问部分相册资源，请前往设置改为所有');
    //   return false;
    // }
    return false;
  }

  static _showDialog(String message) {
    Future.delayed(const Duration(milliseconds: 200), () {
      BuildContext context = KStrings.navigatorKey.currentContext!;
      JhDialog.show(context, title: '提示', content: message, clickBtnPop: false, onConfirm: () {
        Navigator.of(context).pop(false);
        openAppSettings();
      }, onCancel: () {
        Navigator.of(context).pop(false);
      });
    });
  }

  /// 相册 权限检查和请求
  static Future<bool> photos({String message = '暂无相册权限，请前往设置开启权限'}) async {
    Permission permission = Permission.photos;
    if (JhDeviceUtils.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        permission = Permission.storage;
      }
    }
    bool isGranted = await _requestPermission(permission, message);
    return isGranted;
  }

  /// 相机 权限检查和请求
  static Future<bool> camera({String message = '暂无相机权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.camera, message);
    return isGranted;
  }

  /// 麦克风 权限检查和请求
  static Future<bool> microphone({String message = '暂无麦克风权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.microphone, message);
    return isGranted;
  }

  /// 手机存储 权限检查和请求
  static Future<bool> storage({String message = '暂无手机存储权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.storage, message);
    return isGranted;
  }
}

// // 相机权限
// var isGrantedCamera = await Permission.camera.request().isGranted;
// if (!isGrantedCamera) {
//   JhProgressHUD.showText('暂无相机权限,请前往设置开启权限');
//   return;
// }
//
// // 麦克风权限
// var isGrantedMicrophone = await Permission.microphone.request().isGranted;
// if (!isGrantedMicrophone) {
//   JhProgressHUD.showText('暂无麦克风权限,请前往设置开启权限');
//   return;
// }
