///  wx_new_friend_cell.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 新的朋友 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_new_friend_model.dart';

class WxNewFriendCell extends StatelessWidget {
  const WxNewFriendCell({
    Key? key,
    required this.model,
    this.onClickCell,
    this.onClickBtn,
  }) : super(key: key);

  final WxNewFriendModel model;
  final Function(dynamic model)? onClickCell;
  final Function(dynamic model)? onClickBtn;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    Widget btn = InkWell(
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 35,
        decoration: BoxDecoration(
          color: KColors.wxThemeColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const Text('接受', style: TextStyle(color: Colors.white)),
      ),
      onTap: () => onClickBtn?.call(model.toJson()),
    );
    Widget text = InkWell(
        child: Container(
      alignment: Alignment.center,
      width: 70,
      height: 35,
      child: const Text('已添加', style: TextStyle(color: Colors.grey)),
    ));

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
            trailing: (model.isAdd ?? false) ? text : btn,
          ),
        ),
        SizedBox(
          width: 70,
          height: 1,
          child: Container(
            color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
          ),
        )
      ],
    );
  }
}
