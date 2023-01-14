///  jh_highlight_text.dart
///
///  Created by iotjin on 2022/09/07.
///  description: 在一行文本高亮显示指定文本

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

// // 默认普通文本的样式
// const TextStyle _textStyle = TextStyle(fontSize: 15, color: Colors.black);
// 默认高亮文本的样式
const TextStyle _highlightStyle = TextStyle(fontSize: 15, color: Colors.blue);

class JhHighlightText extends StatelessWidget {
  const JhHighlightText({
    Key? key,
    this.text = '',
    this.highlightText = '',
    this.textStyle,
    this.highlightStyle = _highlightStyle,
  }) : super(key: key);

  final String text; // 要显示的内容
  final String highlightText; // 要显示的内容中，需要高亮显示的文字(默认为空字符串，即不高亮显示文本)
  final TextStyle? textStyle; // 要显示的内容的文本风格
  final TextStyle highlightStyle; // 要显示的内容中，需要高亮显示的文字的文本风格

  @override
  Widget build(BuildContext context) {
    var color = KColors.dynamicColor(context, Colors.black, Colors.white);
    var textStyle = this.textStyle ?? TextStyle(fontSize: 15, color: color);

    // 如果没有需要高亮显示的内容
    if (highlightText.isEmpty) {
      return Text(text, style: textStyle);
    }
    // 如果有需要高亮显示的内容
    return _lightView(textStyle);
  }

  /// 需要高亮显示的内容
  Widget _lightView(textStyle) {
    List<TextSpan> spans = [];
    int start = 0; // 当前要截取字符串的起始位置
    int end; // end 表示要高亮显示的文本出现在当前字符串中的索引

    // 如果有符合的高亮文字
    while ((end = text.indexOf(highlightText, start)) != -1) {
      // 第一步：添加正常显示的文本
      spans.add(TextSpan(text: text.substring(start, end), style: textStyle));
      // 第二步：添加高亮显示的文本
      spans.add(TextSpan(text: highlightText, style: highlightStyle));
      // 设置下一段要截取的开始位置
      start = end + highlightText.length;
    }
    // 下面这行代码的意思是
    // 如果没有要高亮显示的，则start=0，也就是返回了传进来的text
    // 如果有要高亮显示的，则start=最后一个高亮显示文本的索引，然后截取到text的末尾
    spans.add(
      TextSpan(text: text.substring(start, text.length), style: textStyle),
    );

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
