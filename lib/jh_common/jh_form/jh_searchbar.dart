///  jh_searchbar.dart
///
///  Created by iotjin on 2022/07/13.
///  description: 搜索框

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';
import 'jh_login_text_field.dart';

const String _hintText = '请输入';
const double _borderRadius = 5.0;
const double _borderWidth = 0.3;
const double _searchViewHeight = 58.0;
const EdgeInsetsGeometry _contentPadding = EdgeInsets.symmetric(vertical: 4);

typedef _InputCallBack = void Function(String value);
typedef _InputCompletionCallBack = void Function(String value, bool isSubmitted);

class JhSearchBar extends StatelessWidget {
  const JhSearchBar({
    Key? key,
    this.text = '',
    this.hintText = _hintText,
    this.maxLength = 15,
    this.bgColor,
    this.isShowDeleteBtn = true,
    this.isShowBorder = false,
    this.contentPadding = _contentPadding,
    this.textInputAction = TextInputAction.done,
    this.inputCallBack,
    this.inputCompletionCallBack,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final int maxLength; // 最大长度，默认15
  final Color? bgColor;
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认显示
  final bool isShowBorder; // 是否显示边框，默认不显示
  final EdgeInsetsGeometry contentPadding; // 当父组件固定高度时，文本一行显示文本过多会出现文字显示不全bug,可设置EdgeInsets.symmetric(vertical: 4)
  final TextInputAction? textInputAction; // 键盘右下角按钮类型
  final _InputCallBack? inputCallBack;
  final _InputCompletionCallBack? inputCompletionCallBack;

  @override
  Widget build(BuildContext context) {
    // 默认颜色
    var viewBgColor = KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);
    var searchBarBgColor = KColors.dynamicColor(context, KColors.kSearchBarBgColor, KColors.kSearchBarBgDarkColor);
    var searchBarBorderColor = KColors.dynamicColor(context, Colors.grey, KColors.kLineDarkColor);
    // 设置的颜色优先级高于暗黑模式
    viewBgColor = bgColor ?? viewBgColor;

    return Container(
      color: viewBgColor,
      child: Container(
        decoration: BoxDecoration(
          color: searchBarBgColor,
          border: isShowBorder ? Border.all(color: searchBarBorderColor, width: _borderWidth) : null,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        height: _searchViewHeight - 20,
        child: JhLoginTextField(
          maxLength: this.maxLength,
          leftWidget: Icon(Icons.search, size: 25),
          text: this.text,
          hintText: this.hintText,
          isShowDeleteBtn: this.isShowDeleteBtn,
          border: InputBorder.none,
          contentPadding: this.contentPadding,
          textInputAction: this.textInputAction,
          inputCallBack: this.inputCallBack,
          inputCompletionCallBack: this.inputCompletionCallBack,
        ),
      ),
    );
  }
}
