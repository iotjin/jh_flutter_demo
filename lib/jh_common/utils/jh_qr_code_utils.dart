/**
 *  jh_qr_code_utils.dart
 *
 *  Created by iotjin on 2020/07/01.
 *  description:  二维码工具类
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/jh_progress_hud.dart';

class JhQrCodeUtils {
  // 调起二维码扫描页
  static Future<String> scan() async {
    try {
      const ScanOptions options = ScanOptions(
        strings: {
          'cancel': '取消',
          'flash_on': '开启闪光灯',
          'flash_off': '关闭闪光灯',
        },
      );
      final ScanResult result = await BarcodeScanner.scan(options: options);
      return result.rawContent;
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == BarcodeScanner.cameraAccessDenied) {
          JhProgressHUD.showText('没有相机权限！');
        }
      }
    }
    return null;
  }

  // 生成二维码（中间带图片）
  static Widget createQRCode(String data, double size,
      {Color backgroundColor,
      Color foregroundColor,
      EdgeInsets padding,
      ImageProvider image,
      Size imageSize}) {
    return QrImage(
      data: data,
      size: size,
      backgroundColor:
          backgroundColor == null ? Color(0x00FFFFFF) : backgroundColor,
      foregroundColor:
          foregroundColor == null ? Color(0xFF000000) : foregroundColor,
      padding: padding == null ? EdgeInsets.all(10.0) : padding,
      embeddedImage: image,
      embeddedImageStyle: QrEmbeddedImageStyle(size: imageSize),
    );
  }
}
