///  jh_tag_view.dart
///
///  Created by iotjin on 2023/08/17.
///  description:

import 'package:flutter/material.dart';

class JhTagView extends StatelessWidget {
  const JhTagView({
    Key? key,
    this.textList = const [],
    this.margin = const EdgeInsets.all(3),
    this.spacing = 10,
    this.runSpacing = 5,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.textColor = Colors.black,
    this.bgColor = Colors.white,
    this.borderColor = const Color(0xFFE6E6E6),
    this.fontSize = 14,
    this.borderRadius = 4,
    this.borderWidth = 1,
  }) : super(key: key);

  final List<String> textList;
  final EdgeInsetsGeometry margin;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry textPadding;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final double fontSize;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    if (textList.isEmpty) {
      return Container();
    }

    var wrapWidget = Wrap(
      spacing: spacing, // 主轴方向子widget的间距
      runSpacing: runSpacing, // 纵轴方向的间距
      runAlignment: WrapAlignment.start, // 纵轴方向的对齐方式
      children: List.generate(
        textList.length,
            (index) => _itemWidget(textList[index]),
      ),
    );

    return Container(
      margin: margin,
      child: wrapWidget,
    );
  }

  _itemWidget(String text) {
    return Container(
      padding: textPadding,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
    );
  }

// _itemWidget2(String text) {
//   return Chip(
//     labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
//     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
//     label: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
//     backgroundColor: bgColor,
//     side: BorderSide(color: borderColor, width: borderWidth),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
//   );
// }
}

class WarningTag extends StatelessWidget {
  const WarningTag({
    Key? key,
    this.text = '',
    this.textList = const [],
  }) : super(key: key);

  final String text; // 优先级高于textList
  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return JhTagView(
      textList: text.isNotEmpty ? [text] : textList,
      textColor: const Color(0xFFFFBA00),
      bgColor: const Color(0xFFFFF8E6),
      borderColor: const Color(0xFFFFF1CC),
    );
  }
}

class ErrorTag extends StatelessWidget {
  const ErrorTag({
    Key? key,
    this.text = '',
    this.textList = const [],
  }) : super(key: key);

  final String text; // 优先级高于textList
  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return JhTagView(
      textList: text.isNotEmpty ? [text] : textList,
      textColor: const Color(0xFFFF4949),
      bgColor: const Color(0xFFFFEDED),
      borderColor: const Color(0xFFFFDBDB),
    );
  }
}

class SuccessTag extends StatelessWidget {
  const SuccessTag({
    Key? key,
    this.text = '',
    this.textList = const [],
  }) : super(key: key);

  final String text; // 优先级高于textList
  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return JhTagView(
      textList: text.isNotEmpty ? [text] : textList,
      textColor: const Color(0xFF13CE66),
      bgColor: const Color(0xFFE7FAF0),
      borderColor: const Color(0xFFD0F5E0),
    );
  }
}
