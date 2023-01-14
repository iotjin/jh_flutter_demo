///  wx_qq_message_cell.dart
///
///  Created by iotjin on 2020/09/09.
///  description: QQ邮箱提醒 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_qq_message_model.dart';

class WxQQMessageCell extends StatelessWidget {
  const WxQQMessageCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxQQMessageModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      // 设置圆角
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      // 普通的边
//    shape: Border.all(color: Colors.yellow, width: 5.0),
      elevation: 3,
      // 阴影大小
      child: Container(
        color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
        child: ListTile(
          title: Text(model.title.jhNullSafe),
          subtitle: Text(model.subtitle.jhNullSafe),
          onTap: () => onClickCell?.call(model.toJson()),
        ),
      ),
    );
  }
}
