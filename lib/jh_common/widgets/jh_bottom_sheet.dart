/**
 *  jh_bottom_sheet.dart
 *
 *  Created by iotjin on 2020/02/16.
 *  description:  微信样式 底部弹框
 */

import 'package:flutter/material.dart';

typedef _ClickCallBack = void Function(int selectIndex, String selectText);

const double _cellHeight = 50.0;
const double _spaceHeight = 5.0;
const Color _spaceColor = Color(0xFFE6E6E6); //230
const Color _textColor = Color(0xFF323232); //50
const double _textFontSize = 18.0;
const Color _red_textColor = Color(0xFFE64242); //rgba(230,66,66,1)
const Color _titleColor = Color(0xFF787878); //120
const double _titleFontSize = 13.0;

class JhBottomSheet {
  /**
      index 从上往下 1，2，3，取消是0
   */

  //弹出底部文字
  static void showText(
    BuildContext context, {
    String title,
    List<String> dataArr,
    String redBtnTitle,
    bool isShowRadius = true,
    _ClickCallBack clickCallback,
  }) {
    List<String> _dataArr = [];

    if (dataArr != null) {
      _dataArr = dataArr;
    }
    if (redBtnTitle != null) {
      _dataArr.insert(_dataArr.length, redBtnTitle);
    }
    var titleHeight = _cellHeight;
    var titltLineHeight = 0.5;
    if (title == null) {
      titleHeight = 0.0;
      titltLineHeight = 0.0;
    }

    var _bgHeight = _cellHeight * (_dataArr.length + 1) +
        (_dataArr.length - 1) * 1 +
        _spaceHeight +
        titleHeight +
        titltLineHeight;

    var _radius = isShowRadius ? 10.0 : 0.0;

    showModalBottomSheet(
        context: context,
        //设置圆角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
          ),
        ),
        // 抗锯齿
        clipBehavior: Clip.antiAlias,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
            color: Colors.white,
            height: _bgHeight,
            child: Column(
              children: <Widget>[
                Container(
                  height: titleHeight,
                  child: Center(
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                          fontSize: _titleFontSize, color: _titleColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: titltLineHeight,
                  child: Container(color: _spaceColor),
                ),
                ListView.separated(
                  itemCount: _dataArr.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Color _btnTextColor =
                        (redBtnTitle != null && index == _dataArr.length - 1)
                            ? _red_textColor
                            : _textColor;

                    return GestureDetector(
                      child: Container(
                          height: _cellHeight,
                          color: Colors.white,
                          child: Center(
                              child: Text(_dataArr[index],
                                  style: TextStyle(
                                      fontSize: _textFontSize,
                                      color: _btnTextColor),
                                  textAlign: TextAlign.center))),
                      // onTap: () => Navigator.of(context).pop(index),
                      onTap: () {
                        Navigator.of(context).pop(index);
                        if (clickCallback != null) {
                          clickCallback(index + 1, _dataArr[index]);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: _spaceColor,
                    );
                  },
                ),
                SizedBox(
                    height: _spaceHeight, child: Container(color: _spaceColor)),
                GestureDetector(
                  child: Container(
                      height: _cellHeight,
                      color: Colors.white,
                      child: Center(
                          child: Text("取消",
                              style: TextStyle(
                                  fontSize: _textFontSize, color: _textColor),
                              textAlign: TextAlign.center))),
                  onTap: () {
                    if (clickCallback != null) {
                      clickCallback(0, "取消");
                    }

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }
}
