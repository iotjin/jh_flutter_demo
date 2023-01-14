///  wx_add_friend_cell.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 添加朋友 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_add_friend_model.dart';

class WxAddFriendCell extends StatelessWidget {
  const WxAddFriendCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxAddFriendModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
          child: ListTile(
            onTap: () => onClickCell?.call(model.toJson()),
            leading: CircleAvatar(backgroundImage: AssetImage(model.img!)),
            title: Text(model.title.jhNullSafe, style: const TextStyle(color: KColors.wxTextBlueColor)),
            subtitle: Text(model.subtitle.jhNullSafe),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        SizedBox(
          width: 70,
          height: 1,
          child: Container(color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor)),
        )
      ],
    );
  }
}
