///  wx_home_cell.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信首页 cell

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/widgets/jh_badge.dart';
import '/project/configs/project_config.dart';
import '../models/wx_home_model.dart';

class WxHomeCell extends StatelessWidget {
  const WxHomeCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxHomeModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _buildCell(context);
  }

  _buildCell(context) {
    Widget noRead = CustomSlidableAction(
      padding: const EdgeInsets.all(0),
//      foregroundColor:Colors.white,
      backgroundColor: Colors.black87,
      child: const Text(
        '标为未读',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击标为未读');
      },
    );

    Widget noAttention = CustomSlidableAction(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.black87,
      child: const Text(
        '不再关注',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击不再关注');
      },
    );

    Widget delete = CustomSlidableAction(
      backgroundColor: Colors.red,
      child: const Text(
        '删除',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击删除');
      },
    );

    List<Widget> tempArr = [];
    if (model.type == '1') {
      tempArr.add(delete);
    }
    if (model.type == '2') {
      tempArr.addAll([noRead, delete]);
    }
    if (model.type == '3') {
      tempArr.addAll([noAttention, delete]);
    }

    var extentRatio = model.type == '0' ? 0.00001 : (model.type == '1' ? 0.2 : 0.4);

    return Slidable(
      key: Key(model.type!),
      // 右侧按钮列表
      endActionPane: ActionPane(
//            motion: const ScrollMotion(),
        motion: const DrawerMotion(),
        extentRatio: extentRatio,
        // 拖动删除
        dragDismissible: false,
        dismissible: DismissiblePane(
          closeOnCancel: true,
//                dismissThreshold: 0.8,
          onDismissed: () {},
        ),
        children: tempArr,
      ),
      child: _cell(context),
    );
  }

  // cell
  Widget _cell(context) {
    return InkWell(
      onTap: () => onClickCell?.call(model.toJson()),
      child: Container(
        color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            JhBadge(
              showBadge: (model.isNew ?? false),
              padding: const EdgeInsets.all(5),
              topValue: 5,
              endValue: 5,
              child: Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(model.img!, width: 60),
                ),
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
                  Text(model.subtitle.jhNullSafe, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
