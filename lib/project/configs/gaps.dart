///  gaps.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  间隔

import 'dimens.dart';
import 'package:flutter/material.dart';

class KGaps {
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: KDimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: KDimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: KDimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: KDimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: KDimens.gap_dp12);
  static const Widget hGap15 = SizedBox(width: KDimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: KDimens.gap_dp16);
  static const Widget hGap32 = SizedBox(width: KDimens.gap_dp32);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: KDimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: KDimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: KDimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: KDimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: KDimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: KDimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: KDimens.gap_dp16);
  static const Widget vGap24 = SizedBox(height: KDimens.gap_dp24);
  static const Widget vGap32 = SizedBox(height: KDimens.gap_dp32);
  static const Widget vGap50 = SizedBox(height: KDimens.gap_dp50);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();
}
