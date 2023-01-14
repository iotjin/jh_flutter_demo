///  wx_motion_top_cell.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动排行榜 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_motion_top_model.dart';

class WxMotionTopCell extends StatefulWidget {
  const WxMotionTopCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxMotionTopModel model;
  final Function(dynamic model)? onClickCell;

  @override
  State<WxMotionTopCell> createState() => _WxMotionTopCellState();
}

class _WxMotionTopCellState extends State<WxMotionTopCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return InkWell(
      onTap: () => widget.onClickCell?.call(widget.model.toJson()),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 13,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text((widget.model.id! + 1).toString(), style: const TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                flex: 74,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: JhColorUtils.hexColor(widget.model.color!),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        widget.model.name.jhNullSafe.substring(0, 1),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.model.name.jhNullSafe,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    widget.model.steps.jhIntToStr,
                    style: TextStyle(
                        fontSize: 28, color: (widget.model.steps ?? 0) > 10000 ? Colors.orange : KColors.wxTextColor),
                  ),
                ),
              ),
              Expanded(
                flex: 13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model.starNum.jhIntToStr,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      child: Icon(
                        Icons.favorite,
                        color: (widget.model.isStar ?? false) ? Colors.red : Colors.grey,
                      ),
                      onTap: () {
                        // 点赞
                        setState(() {
                          widget.model.isStar = !(widget.model.isStar ?? false);
                          if ((widget.model.isStar ?? false) == true) {
                            widget.model.starNum = (widget.model.starNum ?? 0) + 1;
                          } else {
                            widget.model.starNum = (widget.model.starNum ?? 0) - 1;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
            height: (widget.model.isOwn ?? false) ? 10 : 1,
          ),
        ],
      ),
    );
  }
}
