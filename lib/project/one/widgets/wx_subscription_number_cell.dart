///  wx_subscription_number_cell.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号消息 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_subscription_number_model.dart';

class WxSubscriptionNumberCell extends StatelessWidget {
  const WxSubscriptionNumberCell({
    Key? key,
    required this.model,
    required this.index,
    this.onClickCell,
  }) : super(key: key);

  final WxSubscriptionNumberModel model;
  final int index;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cell(context, index);
  }

  Widget _cell(context, index) {
    Widget widget1 = Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(model.img2!)),
          title: Text(model.title.jhNullSafe, style: const TextStyle(color: KColors.wxTextBlueColor)),
          trailing: Text(model.time.jhNullSafe),
        ),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 20 / 9,
//          child: Image.network(value['imageUrl'], fit: BoxFit.cover),
              child: Image.asset(model.img1!, fit: BoxFit.cover),
            ),
            Positioned(
              left: 18.0,
              bottom: 10,
              child: Text(
                model.subtitle.jhNullSafe,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(18),
          title: Text(model.text2.jhNullSafe, style: const TextStyle(color: KColors.wxTextBlueColor)),
          trailing: Image.asset(model.img2!, width: 60),
        )
      ],
    );

    Widget widget2 = Column(
      children: <Widget>[
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(model.img2!, width: 30),
          ),
          title: Text(model.title.jhNullSafe),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(18),
          title: Text(
            model.text2.jhNullSafe,
            style: const TextStyle(color: KColors.wxTextBlueColor),
          ),
          trailing: Image.asset(model.img2!, width: 60),
        )
      ],
    );

    return InkWell(
      child: Card(
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
          child: index % 2 == 0 ? widget1 : widget2,
        ),
      ),
      onTap: () => onClickCell?.call(model.toJson()),
    );
  }
}
