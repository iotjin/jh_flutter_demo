///  jh_searchbar.dart
///
///  Created by iotjin on 2022/07/13.
///  description: 搜索框

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';
import 'jh_login_textfield.dart';

const String _hintText = '请输入';
const double _borderRadius = 5.0;
const double _borderWidth = 0.3;

typedef _InputCallBack = void Function(String value);

class JhSearchBar extends StatelessWidget {
  const JhSearchBar({
    Key? key,
    this.text = '',
    this.hintText = _hintText,
    this.bgColor,
    this.isShowDeleteBtn: true,
    this.isShowBorder: false,
    this.inputCallBack,
  }) : super(key: key);

  final String text;
  final String hintText;
  final Color? bgColor;
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认显示
  final bool isShowBorder; // 是否显示边框，默认不显示
  final _InputCallBack? inputCallBack;

  @override
  Widget build(BuildContext context) {
    var _viewBgColor = KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);
    var _searchBarBgColor = KColors.dynamicColor(context, KColors.kSearchBarBgColor, KColors.kSearchBarBgDarkColor);
    var _searchBarBorderColor = KColors.dynamicColor(context, Colors.grey, KColors.kLineDarkColor);
    _viewBgColor = bgColor ?? _viewBgColor;

    return Container(
      color: _viewBgColor,
      child: Container(
        decoration: BoxDecoration(
          color: _searchBarBgColor,
          border: isShowBorder ? Border.all(color: _searchBarBorderColor, width: _borderWidth) : null,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        height: 38,
        child: JhLoginTextField(
          leftWidget: Icon(Icons.search, size: 25),
          text: this.text,
          hintText: this.hintText,
          isShowDeleteBtn: this.isShowDeleteBtn,
          border: InputBorder.none,
          inputCallBack: this.inputCallBack,
        ),
      ),
    );
  }
}
