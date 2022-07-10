///  jh_bottom_sheet.dart
///
///  Created by iotjin on 2020/02/16.
///  description:  微信样式 底部弹框

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

typedef _ClickCallBack = void Function(int selectIndex, String selectText);

const double _cellHeight = 50.0;
const double _spaceHeight = 5.0;
const double _titleFontSize = 13.0;
const double _textFontSize = 18.0;

const String _cancelText = '取消';

class JhBottomSheet {
  /// 弹出底部文字
  /// index 从上往下 1，2，3，取消是0
  static void showText(
    BuildContext context, {
    String? title,
    List<String>? dataArr,
    String? redBtnTitle,
    bool isShowRadius = true,
    _ClickCallBack? clickCallback,
  }) {
    List<String> _dataArr = [];

    if (dataArr != null) {
      _dataArr = dataArr;
    }
    if (redBtnTitle != null) {
      _dataArr.insert(_dataArr.length, redBtnTitle);
    }
    var titleHeight = _cellHeight;
    var titleLineHeight = 0.6;
    if (title == null) {
      titleHeight = 0.0;
      titleLineHeight = 0.0;
    }

    var _bgHeight =
        _cellHeight * (_dataArr.length + 1) + (_dataArr.length - 1) * 1 + _spaceHeight + titleHeight + titleLineHeight;
    var _radius = isShowRadius ? 10.0 : 0.0;

    // 默认颜色
    var _redTextColor = KColors.kPickerRedTextDarkColor;
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var _bgColor = isDark ? KColors.kPickerBgDarkColor : KColors.kPickerBgColor;
    var _titleColor = isDark ? KColors.kPickerTitleDarkColor : KColors.kPickerTitleColor;
    var _textColor = isDark ? KColors.kPickerTextDarkColor : KColors.kPickerTextColor;
    var _lineColor = isDark ? KColors.kLineDarkColor : KColors.kLineColor;

    showModalBottomSheet(
        context: context,
        // 设置圆角
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
            color: _bgColor,
            height: _bgHeight,
            child: Column(
              children: <Widget>[
                Container(
                  color: _bgColor,
                  height: titleHeight,
                  child: Center(
                    child: Text(
                      title ?? "",
                      style: TextStyle(fontSize: _titleFontSize, color: _titleColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: titleLineHeight,
                  child: Container(color: _lineColor),
                ),
                ListView.separated(
                  itemCount: _dataArr.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Color _btnTextColor =
                        (redBtnTitle != null && index == _dataArr.length - 1) ? _redTextColor : _textColor;

                    return GestureDetector(
                      child: Container(
                        height: _cellHeight,
                        color: _bgColor,
                        child: Center(
                          child: Text(
                            _dataArr[index],
                            style: TextStyle(fontSize: _textFontSize, color: _btnTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
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
                      color: _lineColor,
                    );
                  },
                ),
                SizedBox(height: _spaceHeight, child: Container(color: _lineColor)),
                GestureDetector(
                  child: Container(
                      height: _cellHeight,
                      color: _bgColor,
                      child: Center(
                          child: Text(_cancelText,
                              style: TextStyle(fontSize: _textFontSize, color: _textColor),
                              textAlign: TextAlign.center))),
                  onTap: () {
                    if (clickCallback != null) {
                      clickCallback(0, _cancelText);
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
