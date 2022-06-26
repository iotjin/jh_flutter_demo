///  jh_image_utils.dart
///
///  Created by iotjin on 2020/03/18.
///  description:  图片加载工具类

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class JhImageUtils {
  /// 加载本地图片
  /// image: AssetImage('assets/images/set.png')
  /// image: JhImageUtils.getAssetImage('set')
  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    //    print("路径-- "+ getImgPath(name, format: format));
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
//    return 'images/$name.$format';
  }

//  /// 加载本地或者URL图片
//  static ImageProvider Jh_loadImage(String imageUrl, {String holderImg: 'none'}) {
//
//    if(imageUrl ==null || imageUrl.isEmpty){
//      return AssetImage(Jh_getImgPath(holderImg));
//    }
//    return CachedNetworkImageProvider(imageUrl, errorListener: () => print("图片加载失败！"));
//  }

}

/// 加载本地图片
/// JhLoadAssetImage('account/${_bankLogoList[index]}',width: 24.0)
class JhLoadAssetImage extends StatelessWidget {
  const JhLoadAssetImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.fit,
      this.format: 'png',
      this.color})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      JhImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      color: color,
      // 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
