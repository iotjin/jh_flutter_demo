///  jh_image_utils.dart
///
///  Created by iotjin on 2020/03/18.
///  description:  图片加载工具类

// ignore_for_file: unused_import

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ImageFormat { png, jpg, jpeg, gif, webp }

/// 使用：_methodValues[ImageFormat.png]
const _methodValues = {
  ImageFormat.png: 'png',
  ImageFormat.jpg: 'jpg',
  ImageFormat.jpeg: 'jpeg',
  ImageFormat.gif: 'gif',
  ImageFormat.webp: 'webp',
};

class JhImageUtils {
  /// 加载本地图片
  /// image: JhImageUtils.getAssetImage('set')
  ///
  /// image: AssetImage('assets/images/set.png')
  /// widget: Image.asset('assets/images/set.png', fit: BoxFit.cover, width: 50, height: 50.0),
  static ImageProvider getAssetImage(String name, {ImageFormat format = ImageFormat.png}) {
    //    print('路径-- '+ getImgPath(name, format: format));
    return AssetImage(getImgPath(name, format: format));
  }

  /// 获取图片路径
  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${_methodValues[format]}';
//    return 'images/$name.$format';
  }

  /// 加载本地或者URL图片
  static ImageProvider loadImage(String imageUrl, {String placeholder = 'ic_placeholder'}) {
    if (imageUrl.isEmpty) {
      return AssetImage(getImgPath(placeholder));
    }
    return CachedNetworkImageProvider(imageUrl, errorListener: (error) => print('图片加载失败！$error'));
  }

  /*
    iOS 11 和 macOS High Sierra 支持下面这两种新的行业标准媒体格式：
    适用于照片的 HEIF（高效图像文件格式）, 之前用的是HEIC
    适用于视频的 HEVC（高效视频编码），也称为 H.265
   */

  /// 根据文件名判断是否是图片
  static isImageFormat(String fileName) {
    if (fileName.isEmpty) return false;
    final parts = fileName.split('.');
    if (parts.length < 2) return false;
    final suffix = parts.last.toLowerCase();
    const imageExtensions = ['jpg', 'jpeg', 'jpe', 'png', 'gif', 'webp', 'svg', 'jfif', 'heif'];
    return imageExtensions.contains(suffix);
  }

  /// 根据文件名判断是否是视频
  static bool isVideoFormat(String fileName) {
    if (fileName.isEmpty) return false;
    final parts = fileName.split('.');
    if (parts.length < 2) return false;
    final suffix = parts.last.toLowerCase();
    const videoExtensions = ['mp4', 'avi', 'mov', 'hevc', 'flv', 'mkv', 'wmv', '3gp'];
    return videoExtensions.contains(suffix);
  }

  /// 根据文件名判断是否是excel
  static bool isExcelFormat(String fileName) {
    if (fileName.isEmpty) return false;
    final parts = fileName.split('.');
    if (parts.length < 2) return false;
    final suffix = parts.last.toLowerCase();
    const excelExtensions = ['xls', 'xlsx', 'csv', 'xltx', 'xltm'];
    return excelExtensions.contains(suffix);
  }
}

/// 加载本地图片
/// JhAssetImage('account/${_bankLogoList[index]}',width: 24.0)
class JhAssetImage extends StatelessWidget {
  const JhAssetImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.format = ImageFormat.png,
    this.color,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  final String image; // 本地图片路径（assets/images/ 路径下的图片路径，不带后缀）
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageFormat format;
  final Color? color;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      JhImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      color: color,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      // 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
