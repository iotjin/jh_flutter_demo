///  jh_network_image.dart
///
///  Created by iotjin on 2023/01/28.
///  description: 加载网络图片(cached_network_image封装)

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
export '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/project/configs/colors.dart';

const String _normalPlaceholder = 'ic_placeholder';

/// 加载网络图片
/// 使用：JhNetworkImage(model.avatarUrl.jhNullSafe, placeholder: 'ic_placeholder', width: 75, height: 75, borderRadius: 10),
///
/// image: NetworkImage('https://xxx.png'),
/// widget: Image.network('https://xxx.png', fit: BoxFit.cover, width: 50, height: 50.0),
class JhNetworkImage extends StatelessWidget {
  const JhNetworkImage(
    this.image, {
    Key? key,
    this.placeholder = _normalPlaceholder,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.format = ImageFormat.png,
    this.color,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  final String image;
  final String placeholder; // 本地占位图路径（assets/images/ 路径下的图片路径，不带后缀）
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit? fit;
  final ImageFormat format;
  final Color? color;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    var radius = borderRadius;
    var placeholderColor = color;
    if (placeholder == _normalPlaceholder && context.jhIsDark) {
      placeholderColor = const Color(0xFF1E1E1E); // (30, 30, 30)
    }

    final Widget placeholderImage = JhAssetImage(placeholder,
        height: height,
        width: width,
        fit: fit,
        format: format,
        color: placeholderColor,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight);

    if (image.isEmpty || image.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (_, __) => placeholderImage,
          errorWidget: (_, __, dynamic error) => placeholderImage,
          width: width,
          height: height,
          fit: fit,
          color: color,
          memCacheWidth: cacheWidth,
          memCacheHeight: cacheHeight,
        ),
      );
    }
    return placeholderImage;
  }
}
