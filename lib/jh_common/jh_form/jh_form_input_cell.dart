///  jh_form_input_cell.dart
///
///  Created by iotjin on 2020/04/06.
///  description:  输入行样式，左侧title,右侧输入框，可加自定义widget

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/project/configs/colors.dart';
import 'jh_text_field.dart';

const double _titleSpace = 100.0; // 左侧title默认宽
const double _cellHeight = 45.0; // 输入、选择样式一行的高度
const int _maxLength = 100; // 最大录入长度
const double _lineHeight = 0.6;
const double _titleFontSize = 15.0;
const double _textFontSize = 15.0;
const double _hintTextFontSize = 15.0;

typedef _InputCallBack = void Function(String value);
typedef _InputCompletionCallBack = void Function(String value, bool isSubmitted);

class JhFormInputCell extends StatefulWidget {
  const JhFormInputCell({
    Key? key,
    this.title = '',
    this.text = '',
    this.labelText = '',
    this.errorText = '',
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.hintText = '请输入',
    this.focusNode,
    this.showRedStar = false,
    this.leftWidget,
    this.rightWidget,
    this.maxLines,
    this.maxLength = _maxLength,
    this.showMaxLength = false,
    this.enabled = true,
    this.inputFormatters,
    this.inputCallBack,
    this.inputCompletionCallBack,
    this.space = _titleSpace,
    this.titleStyle,
    this.textStyle,
    this.hintTextStyle,
    this.labelTextStyle,
    this.textAlign = TextAlign.left,
    this.border = InputBorder.none, // 去掉下划线
    this.hiddenLine = false,
    this.topAlign = false,
    this.bgColor,
  }) : super(key: key);

  final String title;
  final String? text;
  final String hintText;
  final String labelText; // top提示文字
  final String errorText; // 错误提示文字
  final TextInputType keyboardType; // 键盘类型，默认文字
  final TextInputAction? textInputAction; // 键盘右下角按钮类型
  final FocusNode? focusNode;
  final bool showRedStar; // 显示左侧小红星，默认不显示
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final int? maxLines; // 最大行数，默认显示一行，自动换行，最多展示_maxLines 行
  final int maxLength; // 最大长度，默认_maxLength
  final bool showMaxLength; // 是否显示右侧最大长度文字，默认不显示
  final bool enabled; // 是否可编辑，默认true
  final List<TextInputFormatter>? inputFormatters;
  final _InputCallBack? inputCallBack;
  final _InputCompletionCallBack? inputCompletionCallBack;
  final double space; // 标题宽度
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle; // 默认为hintTextStyle，高亮为主题色
  final TextAlign textAlign; // 输入文字对齐方式，默认左对齐
  final InputBorder border; // 输入边框样式，默认无边框
  final bool hiddenLine; // 隐藏底部横线
  final bool topAlign; // 左侧标题顶部对齐，默认居中
  final Color? bgColor; // 背景颜色，默认白色

  @override
  State<JhFormInputCell> createState() => _JhFormInputCellState();
}

class _JhFormInputCellState extends State<JhFormInputCell> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    double starW = widget.showRedStar == false && widget.title.isEmpty ? 0 : 8;
    double topSpace = 0; // title 顶对齐 间距

    // 默认颜色
    var bgColor = KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);
    var titleColor = KColors.dynamicColor(context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor);
    var titleStyle = TextStyle(fontSize: _titleFontSize, color: titleColor);
    var textColor = KColors.dynamicColor(context, KColors.kFormInfoColor, KColors.kFormInfoDarkColor);
    var textStyle = TextStyle(fontSize: _textFontSize, color: textColor);
    var hintColor = KColors.dynamicColor(context, KColors.kFormHintColor, KColors.kFormHintDarkColor);
    var hintTextStyle = TextStyle(fontSize: _hintTextFontSize, color: hintColor);
    var lineColor = KColors.dynamicColor(context, KColors.kFormLineColor, KColors.kFormLineDarkColor);

    // 设置的颜色优先级高于暗黑模式
    bgColor = widget.bgColor ?? bgColor;
    titleStyle = widget.titleStyle ?? titleStyle;
    textStyle = widget.textStyle ?? textStyle;
    hintTextStyle = widget.hintTextStyle ?? hintTextStyle;

    return Container(
      color: bgColor,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity, // 宽度尽可能大
          minHeight: _cellHeight, // 最小高度
        ),
        padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
        // decoration: BoxDecoration(
        //   border: widget.hiddenLine == true ? null : Border(bottom: Divider.createBorderSide(context, width: 0.8)),
        // ),
        decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: _lineHeight, color: widget.hiddenLine == true ? Colors.transparent : lineColor),
          insets: EdgeInsets.fromLTRB(starW, 0, 0, 0),
        ),
        child: Row(
          crossAxisAlignment: widget.topAlign == true ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            widget.leftWidget ?? Container(),
            Container(
              width: starW,
              padding: EdgeInsets.fromLTRB(0, widget.topAlign == true ? topSpace : 0, 0, 0),
              child: Text(widget.showRedStar ? '*' : ' ', style: const TextStyle(fontSize: 18.0, color: Colors.red)),
            ),
            Offstage(
              offstage: widget.title.isEmpty ? true : false,
              child: Container(
                width: widget.space - starW,
                padding: EdgeInsets.fromLTRB(0, widget.topAlign == true ? topSpace : 0, 0, 0),
                child: Text(widget.title, style: titleStyle),
              ),
            ),
            Expanded(
              child: JhTextField(
                text: widget.text,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                hintText: widget.hintText,
                labelText: widget.labelText,
                errorText: widget.errorText,
                focusNode: widget.focusNode,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                showMaxLength: widget.showMaxLength,
                enabled: widget.enabled,
                inputFormatters: widget.inputFormatters,
                inputCallBack: widget.inputCallBack,
                inputCompletionCallBack: widget.inputCompletionCallBack,
                textStyle: textStyle,
                hintTextStyle: hintTextStyle,
                labelTextStyle: widget.labelTextStyle,
                textAlign: widget.textAlign,
                border: widget.border,
              ),
            ),
            widget.rightWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}
