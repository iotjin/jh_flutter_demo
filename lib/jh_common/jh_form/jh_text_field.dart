///  jh_text_field.dart
///
///  Created by iotjin on 2020/02/18.
///  description:  输入框（默认没有边框，宽充满屏幕，文字居左，默认显示1行，自动换行，最多5行，可设置键盘类型，右侧添加自定义widget，多行，最大长度，是否可编辑，文字样式）

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const int _maxLines = 5; // 最大行数
const int _maxLength = 100; // 最大录入长度
const double _labelTextFontSize = 15.0;

/// 录入回调
typedef _InputCallBack = void Function(String value);

/// 录入完成回调（失去焦点或者点击键盘右下角按钮触发）
/// isSubmitted：是否通过onSubmitted方法触发
/// 直接使用回调范围更大，可判断外部三方键盘关闭按钮点击事件，如果有多个textField切换，也会走这个回调，按需使用
typedef _InputCompletionCallBack = void Function(String value, bool isSubmitted);

class JhTextField extends StatefulWidget {
  const JhTextField({
    Key? key,
    this.text = '',
    this.hintText = '请输入',
    this.labelText = '',
    this.errorText = '',
    this.focusNode,
    this.leftWidget,
    this.rightWidget,
    this.maxLines,
    this.maxLength = _maxLength,
    this.showMaxLength = false,
    this.enabled = true,
    this.inputFormatters,
    this.inputCallBack,
    this.inputCompletionCallBack,
    this.textStyle,
    this.hintTextStyle,
    this.labelTextStyle,
    this.textAlign = TextAlign.left,
    this.border = InputBorder.none, // 去掉下划线
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final String labelText; // top提示文字
  final String errorText; // 错误提示文字
  final FocusNode? focusNode;
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final int? maxLines; // 最大行数，默认显示一行，自动换行，最多展示_maxLines 行
  final int maxLength; // 最大长度，默认_maxLength
  final bool showMaxLength; // 是否显示右侧最大长度文字，默认不显示
  final bool enabled; // 是否可编辑，默认true
  final List<TextInputFormatter>? inputFormatters;
  final _InputCallBack? inputCallBack;
  final _InputCompletionCallBack? inputCompletionCallBack;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle; // 默认为hintTextStyle，高亮为主题色
  final TextAlign textAlign; // 对齐方式，默认左对齐
  final InputBorder border; // 边框样式，默认无边框
  final TextEditingController? controller;
  final TextInputType keyboardType; // 键盘类型，默认文字
  final TextInputAction? textInputAction; // 键盘右下角按钮类型

  @override
  _JhTextFieldState createState() => _JhTextFieldState();
}

class _JhTextFieldState extends State<JhTextField> {
  TextEditingController? _textController;
  FocusNode? _focusNode;
  bool _isFocused = false;
  bool _isSubmitted = false; // 记录是否点击键盘右下角按钮

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = widget.controller ?? TextEditingController();
    _textController!.text = widget.text ?? '';
    // 超过最大长度截取
    if ((widget.text ?? '').length > widget.maxLength) {
      _textController!.text = (widget.text ?? '').substring(0, widget.maxLength);
    }
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode!.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode!.hasFocus;
          // 录入完成回调，失去焦点并且不是点击键盘右下角时触发
          if (!_isFocused && !_isSubmitted) {
            widget.inputCompletionCallBack?.call(_textController!.text, false);
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant JhTextField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    /// 更新text的值，并处理光标
    /// https://github.com/flutter/flutter/issues/11416
    var cursorPos = _textController!.selection;
    // 更新text值到_textController
    _textController!.text = widget.text ?? '';
    // 超过最大长度截取
    if ((widget.text ?? '').length > widget.maxLength) {
      _textController!.text = (widget.text ?? '').substring(0, widget.maxLength);
    }
    if (cursorPos.start > _textController!.text.length) {
      // 光标保持在文本最后
      cursorPos = TextSelection.fromPosition(TextPosition(offset: _textController!.text.length));
    }
    _textController!.selection = cursorPos;

    // 有bug，删除中间的文字会跳到最后
    // // 更新text值到_textController
    // _textController!.text = widget.text ?? '';
    // // 光标保持在文本最后
    // _textController!.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _textController!.text.length),
    // );

    // 同上
    // _textController!.value = _textController!.value.copyWith(
    //   text: widget.text,
    //   selection: TextSelection(
    //     baseOffset: _textController!.text.length,
    //     extentOffset: _textController!.text.length,
    //   ),
    //   composing: TextRange.empty,
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _focusNode!.unfocus();
    _textController!.dispose();
    super.dispose();
//    print('JhTextField dispose');
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var labelTextStyle = TextStyle(fontSize: _labelTextFontSize, color: themeColor);
    // 设置的颜色优先级高于暗黑模式
    labelTextStyle = widget.labelTextStyle ?? labelTextStyle;

    return TextField(
      enabled: widget.enabled,
      focusNode: _focusNode,
      controller: _textController,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.textStyle,
      textAlign: widget.textAlign,
      minLines: widget.maxLines ?? 1,
      maxLines: widget.maxLines ?? _maxLines,
      maxLength: widget.showMaxLength == true ? widget.maxLength : null,
      inputFormatters: widget.inputFormatters ?? [LengthLimitingTextInputFormatter(widget.maxLength)],
      decoration: InputDecoration(
        prefixIcon: widget.leftWidget,
        suffixIcon: widget.rightWidget,
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle,
        labelText: widget.labelText.isEmpty ? null : widget.labelText,
        labelStyle: _isFocused ? labelTextStyle : widget.hintTextStyle,
        errorText: widget.errorText.isEmpty ? null : widget.errorText,
        isDense: true,
        contentPadding: widget.border != InputBorder.none
            ? const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
            : const EdgeInsets.fromLTRB(0, 8, 5, 8),
        border: widget.border,
      ),
      // 执行顺序为 onTap -> onChanged -> onEditingComplete -> onSubmitted
      // 点击输入框
      onTap: () {
        _isSubmitted = false;
      },
      // 每次输入框文字改变，均会执行
      onChanged: (value) {
        widget.inputCallBack?.call(_textController!.text);
      },
      // 输入完成，提交按钮点击后会先执行这里
      onEditingComplete: () {
        _focusNode!.unfocus();
      },
      // 提交按钮点击
      onSubmitted: (value) {
        _isSubmitted = true;
        widget.inputCompletionCallBack?.call(_textController!.text, true);
      },
    );
  }
}
