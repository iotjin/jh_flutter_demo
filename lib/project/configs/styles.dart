///  styles.dart
///
///  Created by iotjin on 2020/07/09.
///  description:  TextStyles

import 'package:flutter/material.dart';
import 'colors.dart';
import 'dimens.dart';

class KStyles {
  static const TextStyle textSize12 = TextStyle(fontSize: KDimens.font_sp12);
  static const TextStyle textSize16 = TextStyle(fontSize: KDimens.font_sp16);
  static const TextStyle textBold14 = TextStyle(fontSize: KDimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold15 = TextStyle(fontSize: KDimens.font_sp15, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 = TextStyle(fontSize: KDimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 = TextStyle(fontSize: KDimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 = TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(fontSize: KDimens.font_sp14, color: Colours.text_gray);
  static const TextStyle textDarkGray14 = TextStyle(fontSize: KDimens.font_sp14, color: Colours.dark_text_gray);

  static const TextStyle textWhite14 = TextStyle(fontSize: KDimens.font_sp14, color: Colors.white);

  static const TextStyle text =
      TextStyle(fontSize: KDimens.font_sp14, color: Colours.text, textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark =
      TextStyle(fontSize: KDimens.font_sp14, color: Colours.dark_text, textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 =
      TextStyle(fontSize: KDimens.font_sp12, color: Colours.text_gray, fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray12 =
      TextStyle(fontSize: KDimens.font_sp12, color: Colours.dark_text_gray, fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(fontSize: KDimens.font_sp14, color: Colours.dark_unselected_item_color);

  /// 列表边框样式
  static BoxDecoration cellBorderStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(3),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12, // 阴影颜色
        spreadRadius: 1.5, // 阴影浓度
        blurRadius: 1.5, // 阴影范围
      ),
    ],
  );

  /// 列表分割线样式1
  static Divider cellLineStyle = const Divider(height: 0.0001, color: Colors.transparent);

  /// 列表分割线样式2
  static Divider cellLineGrayStyle = const Divider(height: .5, indent: 15, endIndent: 15, color: KColors.kLineColor);

  static const TextStyle titleBold15 = TextStyle(fontSize: KDimens.font_sp15, color: KColors.kFormTitleColor);
}
