///  jh_qr_code_utils.dart
///
///  Created by iotjin on 2020/07/01.
///  description:  二维码工具类

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_common_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/routes/jh_nav_utils.dart';
import 'jh_device_utils.dart';

class JhQrCodeUtils {
  /// 跳转二维码扫码页扫码
  /// 需配置路由
  /// 添加 --enable-software-rendering debug模式闪退
  static Future jumpScan(
    BuildContext context, {
    isShowScanLine = false, // 是否显示扫描线动画
    isShowGridLine = false, // 是否显示网格线动画，优先级高于扫描线
    Function(String data)? callBack,
  }) async {
    if (!JhDeviceUtils.isMobile) {
      JhProgressHUD.showText('当前平台暂不支持');
      return;
    }
    JhNavUtils.unFocus();
    // 延时保证键盘收起，否则进入扫码页会黑屏
    JhCommonUtils.debounce(() {
      JhNavUtils.pushNamedResult(context, isShowGridLine ? 'QrCodeGridScannerPage' : 'QrCodeScannerPage',
          isShowGridLine ? null : isShowScanLine, (dynamic code) {
        callBack?.call(code.toString());
      });
    }, 500);
  }

  /// 生成二维码（中间带图片）
  static Widget createQRCode(String data, double size,
      {Color? backgroundColor, Color? foregroundColor, EdgeInsets? padding, ImageProvider? image, Size? imageSize}) {
    foregroundColor = foregroundColor ?? const Color(0xFF000000);
    return QrImageView(
      data: data,
      size: size,
      backgroundColor: backgroundColor ?? const Color(0x00FFFFFF),
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: foregroundColor),
      dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: foregroundColor),
      // foregroundColor: foregroundColor ?? const Color(0xFF000000),
      padding: padding ?? const EdgeInsets.all(10.0),
      embeddedImage: image,
      embeddedImageStyle: QrEmbeddedImageStyle(size: imageSize),
    );
  }

  ///  barcode_scan 扫码
  static Future scan({
    Function(String data)? callBack,
  }) async {
    if (!JhDeviceUtils.isMobile) {
      JhProgressHUD.showText('当前平台暂不支持');
      return;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      try {
        const ScanOptions options = ScanOptions(
          strings: {
            'cancel': '取消',
            'flash_on': '开启闪光灯',
            'flash_off': '关闭闪光灯',
          },
        );
        BarcodeScanner.scan(options: options).then((ScanResult result) {
          if (result.rawContent.isNotEmpty) {
            callBack?.call(result.rawContent);
          }
        });
      } catch (e) {
        if (e is PlatformException) {
          if (e.code == BarcodeScanner.cameraAccessDenied) {
            JhProgressHUD.showText('没有相机权限！');
          }
        }
      }
    });
  }

  ///  barcode_scan 扫码
// static Future<String> scan() async {
//   try {
//     const ScanOptions options = ScanOptions(
//       strings: {
//         'cancel': '取消',
//         'flash_on': '开启闪光灯',
//         'flash_off': '关闭闪光灯',
//       },
//     );
//     final ScanResult result = await BarcodeScanner.scan(options: options);
//     print('========== 23432423423434234234 ==========');
//     print('object: ${result.toString()}');
//     print('object: ${result.rawContent}');
//
//     return result.rawContent;
//   } catch (e) {
//     if (e is PlatformException) {
//       if (e.code == BarcodeScanner.cameraAccessDenied) {
//         JhProgressHUD.showText('没有相机权限！');
//       }
//     }
//   }
//   return '';
// }
/*
   Future.delayed(Duration(milliseconds: 400), () {
        JhQrCodeUtils.scan().then((data) {
          print('扫码结果：$data');
         });
    });
*/
}
