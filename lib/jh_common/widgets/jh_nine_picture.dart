///  jh_nine_picture.dart
///
///  Created by iotjin on 2020/09/14.
///  description:  九宫格图片展示 4图处理 加载本地和网络图片

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import 'jh_photo_browser.dart';

const double _itemSpace = 5.0;
const double _space = 5.0; // 上下左右间距

/// 长按回调，返回当前索引和所有图片数组
typedef _OnLongPress = void Function(int index, dynamic imgArr);

class JhNinePicture extends StatelessWidget {
  const JhNinePicture({
    Key? key,
    this.imgData,
    this.lRSpace = 0.0,
    this.onLongPress,
    this.isHandleFour = true,
  }) : super(key: key);

  final List? imgData;
  final double lRSpace; // 外部设置的左右间距
  final _OnLongPress? onLongPress;
  final bool isHandleFour;

  @override
  Widget build(BuildContext context) {
    var kScreenWidth = MediaQuery.of(context).size.width;

    var ninePictureW = (kScreenWidth - _space * 2 - 2 * _itemSpace - lRSpace);
    var itemWH = ninePictureW / 3;
    int columnCount = imgData!.length > 6
        ? 3
        : imgData!.length <= 3
            ? 1
            : 2;
    // print('九宫格宽 $_ninePictureW ');
    // print('item宽  $_itemWH ');

    bool isHandleFourNew = isHandleFour && imgData!.length == 4;

    var bgWidth = isHandleFourNew ? (_space * 2 + _itemSpace + itemWH * 2) : (kScreenWidth - lRSpace);
    var bgHeight = columnCount * itemWH + _space * 2 + (columnCount - 1) * _itemSpace;
    var crossAxisCount = isHandleFourNew ? 2 : 3;
    var childAspectRatio = 1.0;

    if (imgData!.length == 1) {
      bgWidth = (kScreenWidth - lRSpace) * 0.55;
      bgHeight = (kScreenWidth - lRSpace) * 0.75;
      crossAxisCount = 1;
      childAspectRatio = 55.0 / 76.0;
    }

    return Offstage(
      offstage: imgData!.isEmpty,
      child: SizedBox(
        width: bgWidth,
        height: bgHeight,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 可以直接指定每行（列）显示多少个Item
            crossAxisCount: crossAxisCount, // 一行的Widget数量
            crossAxisSpacing: _itemSpace, // 水平间距
            mainAxisSpacing: _itemSpace, // 垂直间距
            childAspectRatio: childAspectRatio, // 子Widget宽高比例
          ),
          // 禁用滚动事件
          physics: const NeverScrollableScrollPhysics(),
          // GridView内边距
          padding: const EdgeInsets.all(_space),
          itemCount: imgData!.length,
          itemBuilder: (context, index) {
            return _itemCell(context, index);
          },
        ),
      ),
    );
  }

  _itemCell(context, index) {
    var img = imgData![index];
    Widget picture =
        img.startsWith('http') ? JhNetworkImage(img, fit: BoxFit.cover) : Image.asset(img, fit: BoxFit.cover);

    // CachedNetworkImage(
    //   imageUrl: imgData[index],
    //   imageBuilder: (context, imageProvider) =>
    //       Container(
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //               image: imageProvider,
    //               fit: BoxFit.cover),
    //         ),
    //       ),
    //   placeholder: (context, url) => CircularProgressIndicator(),
    //   errorWidget: (context, url, error) => Icon(Icons.error),
    // ),
    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: picture,
      ),
      onTap: () => _clickItemCell(context, index),
    );
  }

  /// 点击cell，展示全图
  _clickItemCell(context, index) {
    JhPhotoBrowser.show(context, data: imgData!, index: index, onLongPress: onLongPress);
  }
}
