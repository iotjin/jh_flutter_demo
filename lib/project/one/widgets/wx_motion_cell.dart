///  wx_motion_cell.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_motion_model.dart';

class WxMotionCell extends StatelessWidget {
  const WxMotionCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxMotionModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            model.time.jhNullSafe,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
        InkWell(
          onTap: () => onClickCell?.call(model.toJson()),
          child: Card(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              // 设置圆角
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              // 抗锯齿
              clipBehavior: Clip.antiAlias,
              // 普通的边
              //shape: Border.all(color: Colors.yellow, width: 5.0),
              elevation: 3,
              // 阴影大小
              child: Container(
                width: double.infinity,
                height: 200,
                color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
                // child: ListTile(
                //   title: Text(item['title']),
                //   subtitle: Text(
                //     item['subtitle'],
                //   ),
                //   onTap: () => _clickCell(context, item['title']),
                // ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.ranking.jhNullSafe,
                                    style: TextStyle(color: JhColorUtils.hexColor(model.color!), fontSize: 35),
                                  ),
                                  Text(
                                    '名次',
                                    style: TextStyle(color: JhColorUtils.hexColor(model.color!), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    model.steps.jhNullSafe,
                                    style: TextStyle(color: JhColorUtils.hexColor(model.color!), fontSize: 35),
                                  ),
                                  Text(
                                    '步数',
                                    style: TextStyle(color: JhColorUtils.hexColor(model.color!), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                      color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(model.img!, width: 40),
                        ),
                        title: Text(
                          model.text.jhNullSafe,
                          style: TextStyle(color: JhColorUtils.hexColor(model.color!), fontSize: 15),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black26),
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
