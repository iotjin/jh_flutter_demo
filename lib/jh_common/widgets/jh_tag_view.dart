///  jh_tag_view.dart
///
///  Created by iotjin on 2023/08/17.
///  description:

import 'package:flutter/material.dart';

class JhTagView extends StatelessWidget {
  const JhTagView({
    Key? key,
    this.textList = const [],
    this.textColor = Colors.black,
    this.bgColor = Colors.white,
    this.borderColor = const Color(0xFFE6E6E6),
    this.fontSize = 14,
    this.spacing = 10,
    this.runSpacing = 0,
    this.borderRadius = 4,
    this.borderWidth = 1,
  }) : super(key: key);

  final List<String> textList;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final double fontSize;
  final double spacing;
  final double runSpacing;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    if (textList.isEmpty) {
      return Container();
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: List.generate(
        textList.length,
        (index) => Chip(
          label: Text(textList[index], style: TextStyle(color: textColor, fontSize: fontSize)),
          backgroundColor: bgColor,
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
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
