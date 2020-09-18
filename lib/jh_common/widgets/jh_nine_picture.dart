/**
 *  jh_nine_picture.dart
 *
 *  Created by iotjin on 2020/09/14.
 *  description: 九宫格图片展示 4图处理 加载本地和网络图片
 */

import 'package:flutter/material.dart';
import 'jh_photo_browser.dart';

const double _itemSpace = 5.0;
const double _space = 5.0; //上下左右间距

class JhNinePicture extends StatelessWidget {
  final List imgData;
  final double lRSpace; //外部设置的左右间距
  final GestureTapCallback onLongPress;
  bool isHandleFour;

  JhNinePicture({
    this.imgData,
    this.lRSpace = 0.0,
    this.onLongPress,
    this.isHandleFour = true,
  });

  @override
  Widget build(BuildContext context) {
    var kScreenWidth = MediaQuery.of(context).size.width;

    var _ninePictureW = (kScreenWidth - _space * 2 - 2 * _itemSpace - lRSpace);
    var _itemWH = _ninePictureW / 3;
    int _columnCount = imgData.length > 6 ? 3 : imgData.length <= 3 ? 1 : 2;
    // print("九宫格宽 ${_ninePictureW} ");
    // print("item宽  ${_itemWH} ");

    bool _isHandleFour = isHandleFour && imgData.length == 4;

    var _bgWidth = _isHandleFour
        ? (_space * 2 + _itemSpace + _itemWH * 2)
        : (kScreenWidth - lRSpace);

    var _bgHeight =
        _columnCount * _itemWH + _space * 2 + (_columnCount - 1) * _itemSpace;

    var _crossAxisCount = _isHandleFour ? 2 : 3;
    var _childAspectRatio = 1.0;

    if (imgData.length == 1) {
      _bgWidth = (kScreenWidth - lRSpace) * 0.55;
      _bgHeight = (kScreenWidth - lRSpace) * 0.75;
      _crossAxisCount = 1;
      _childAspectRatio = 55.0 / 76.0;
    }

    return Offstage(
      offstage: imgData.length == 0,
      child: Container(
        // color: Colors.yellow,
        color: Colors.white,
        width: _bgWidth,
        height: _bgHeight,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //可以直接指定每行（列）显示多少个Item
              crossAxisCount: _crossAxisCount, //一行的Widget数量
              crossAxisSpacing: _itemSpace, //水平间距
              mainAxisSpacing: _itemSpace, //垂直间距
              childAspectRatio: _childAspectRatio, //子Widget宽高比例
            ),
            physics: NeverScrollableScrollPhysics(),
            //禁用滚动事件
            padding: EdgeInsets.all(_space),
            //GridView内边距
            itemCount: imgData.length,
            itemBuilder: (context, index) {
              return _itemCell(context, index);
            }),
      ),
    );
  }

  _itemCell(context, index) {
    var _img = imgData[index];
    Widget _picture = _img.startsWith('http')
        ? Image.network(_img, fit: BoxFit.cover)
        : Image.asset(_img, fit: BoxFit.cover);

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
        child: _picture,
        constraints: BoxConstraints.expand(),
      ),
      onTap: () => _clickItemCell(context, index),
    );
  }

  //点击cell，展示全图
  _clickItemCell(context, index) {
    //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
    Navigator.of(context).push(new FadeRoute(
      page: JhPhotoBrowser(
        imgDataArr: imgData,
        index: index,
        onLongPress: onLongPress,
      ),
    ));
  }
}
