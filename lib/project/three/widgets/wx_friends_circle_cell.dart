///  wx_friends_circle_cell.dart
///
///  Created by iotjin on 2020/09/14.
///  description: 朋友圈 cell

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_nine_picture.dart';
import '/project/configs/project_config.dart';
import '../models/wx_friends_circle_model.dart';

class WxFriendsCircleCell extends StatelessWidget {
  const WxFriendsCircleCell({
    Key? key,
    required this.model,
    this.onClickCell,
    this.onClickHeadPortrait,
    this.onClickComment,
  }) : super(key: key);

  final WxFriendsCircleModel model;
  final Function(dynamic model)? onClickCell;
  final Function(dynamic model)? onClickHeadPortrait;
  final Function(dynamic model)? onClickComment;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return InkWell(
      onTap: () => onClickCell?.call(model.toJson()),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: KColors.kLineColor, width: 1),
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
            ), // 下边框
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像
            InkWell(
              onTap: () => onClickHeadPortrait?.call(model.toJson()),
              child: Container(
                margin: const EdgeInsets.all(15),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: JhColorUtils.hexColor(model.color!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(model.name!.substring(0, 1), style: const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 13),
                    child: Text(
                      model.name!,
                      style: const TextStyle(color: KColors.wxTextBlueColor, fontSize: 15),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                      child: Text(model.content.jhNullSafe, style: const TextStyle(fontSize: 13))),
                  _imagesWidget(context),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.time.jhNullSafe,
                          style: const TextStyle(color: KColors.kLightGreyTextColor, fontSize: 13),
                        ),
                        InkWell(
                          child: Container(
                            width: 34,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: KColors.dynamicColor(
                                  context, const Color.fromRGBO(240, 240, 240, 1), KColors.kCellBgDarkColor),
                            ),
                            child: Image.asset(
                              'assets/wechat/discover/ic_diandian.png',
                              color: KColors.wxTextBlueColor,
                            ),
                          ),
                          onTap: () => onClickComment?.call(model.toJson()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 图片view
  Widget _imagesWidget(context) {
    return JhNinePicture(
      imgData: model.images ?? [],
      lRSpace: (80.0 + 20.0),
      onLongPress: (int index, dynamic imgArr) {
        print('onLongPress:');
        JhBottomSheet.showText(context, dataArr: ['保存图片']);
      },
    );
  }
}
