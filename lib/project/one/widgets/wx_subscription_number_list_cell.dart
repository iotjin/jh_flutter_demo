///  wx_subscription_number_list_cell.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号列表 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_subscription_number_list_model.dart';

class WxSubscriptionNumberListCell extends StatelessWidget {
  const WxSubscriptionNumberListCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxSubscriptionNumberListModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return InkWell(
      onTap: () => onClickCell?.call(model.toJson()),
      child: Container(
        color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(model.img!, width: 60),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                Container(color: KColors.kLineColor, height: 0.8),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 70, child: Text(model.title.jhNullSafe, style: const TextStyle(fontSize: 18))),
                      Expanded(
                        flex: 30,
                        child: Text(
                          model.time.jhNullSafe,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      model.subtitle.jhNullSafe,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
