///  wx_user_info_page.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 用户信息

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/project/configs/project_config.dart';
import '/project/two/models/wx_contacts_model.dart';

class WxUserInfoPage extends StatelessWidget {
  const WxUserInfoPage(this.jumpParams, {Key? key}) : super(key: key);

  final dynamic jumpParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('', rightImgPath: 'assets/images/ic_more_black.png', bgColor: Colors.transparent,
          rightItemCallBack: () {
        // 跳转资料设置
        JhNavUtils.pushNamed(context, 'WxInfoSetPage', arguments: jumpParams);
      }),
      body: _body(context),
    );
  }

  Widget _body(context) {
    WxContactsModel model = WxContactsModel.fromJson(jumpParams);
    print('上个页面传递过来的用户信息: ${model.toJson()}');

    double cellH = wxCellH;
    double rowSpace = wxRowSpace;

    Widget sex = model.sex == '0'
        ? const Icon(Icons.person, color: Colors.blue)
        : const Icon(Icons.pregnant_woman, color: Colors.redAccent);
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(maxHeight: 66, maxWidth: 66),
                height: 66,
                width: 66,
                margin: const EdgeInsets.fromLTRB(20, 3, 15, 0),
                decoration: BoxDecoration(
                  color: JhColorUtils.hexColor(model.color!),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(model.name!.substring(0, 1), style: const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              Expanded(
                flex: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(model.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
//                      Icon(Icons.pregnant_woman, color: Colors.redAccent),
//                      Icon(Icons.person, color: Colors.blue),
                        sex
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text('昵称：${model.namePinyin}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 3),
                    Text('手机号：${model.phone}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 3),
                    Text('地区：${model.region}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                flex: 15,
                child: model.isStar! ? const Icon(Icons.star, color: Colors.yellow) : Container(),
              ),
            ],
          ),
        ),
        Container(color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor), height: 0.5),
        JhSetCell(
          cellHeight: cellH,
          title: '备注和标签',
          text: model.label!,
          textAlign: TextAlign.left,
          clickCallBack: () => _clickCell(context, '备注和标签'),
        ),
        JhSetCell(
          cellHeight: cellH,
          title: '朋友权限',
          text: model.isStar! ? '' : '不看他的朋友圈和视频动态',
          textAlign: TextAlign.left,
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '朋友权限'),
        ),
        SizedBox(height: rowSpace),
        JhSetCell(
          cellHeight: cellH + 20,
          title: '朋友圈',
          clickCallBack: () => _clickCell(context, '朋友圈'),
        ),
        JhSetCell(
          cellHeight: cellH,
          title: '更多信息',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '更多信息'),
        ),
        SizedBox(height: rowSpace),
        InkWell(
          onTap: () => _clickCell(context, '发消息'),
          child: Container(
            height: cellH,
            color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/wechat/contacts/ic_xinxi.png', width: 20, color: KColors.wxTextBlueColor),
                const SizedBox(width: 5),
                const Text('发消息',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: KColors.wxTextBlueColor))
              ],
            ),
          ),
        ),
        Container(color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor), height: 0.5),
        InkWell(
          onTap: () => _clickCell(context, '音视频通话'),
          child: Container(
            height: cellH,
            color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/wechat/contacts/ic_shipintonghua.png', width: 20, color: KColors.wxTextBlueColor),
                const SizedBox(width: 5),
                const Text('音视频通话',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: KColors.wxTextBlueColor))
              ],
            ),
          ),
        )
      ],
    );
  }

  void _clickCell(context, title) {
    JhToast.showText(context, msg: '点击 $title');
  }
}
