///  wx_info_set_page.dart
///
///  Created by iotjin on 2020/09/02.
///  description: 资料设置

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/project/configs/project_config.dart';
import '/project/two/models/wx_contacts_model.dart';

class WxInfoSetPage extends StatefulWidget {
  const WxInfoSetPage(this.jumpParams, {Key? key}) : super(key: key);
  final dynamic jumpParams;

  @override
  State<WxInfoSetPage> createState() => _WxInfoSetPageState();
}

class _WxInfoSetPageState extends State<WxInfoSetPage> {
  WxContactsModel model = WxContactsModel();
  bool _switchSelected = false;
  bool _switchSelected2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model = WxContactsModel.fromJson(widget.jumpParams);
    _switchSelected = model.isStar!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('资料设置', bgColor: Colors.transparent),
      body: _body(),
    );
  }

  Widget _body() {
    double cellH = wxCellH;
    double rowSpace = wxRowSpace;

    return ListView(
      children: <Widget>[
        JhSetCell(
          cellHeight: cellH,
          title: '备注和标签',
          text: model.label.jhNullSafe,
          clickCallBack: () => _clickCell('备注和标签'),
        ),
        JhSetCell(
          cellHeight: cellH,
          title: '朋友权限',
          hiddenLine: true,
          clickCallBack: () => _clickCell('朋友权限'),
        ),
        SizedBox(height: rowSpace),
        JhSetCell(
          cellHeight: cellH,
          titleWidth: 150,
          title: model.sex == '0' ? '把他推荐给朋友' : '把她推荐给朋友',
          hiddenLine: true,
          clickCallBack: () => _clickCell(model.sex == '0' ? '把他推荐给朋友' : '把她推荐给朋友'),
        ),
        SizedBox(height: rowSpace),
        JhSetCell(
          cellHeight: cellH,
          title: '设为星标朋友',
          hiddenLine: true,
          hiddenArrow: true,
          rightWidget: CupertinoSwitch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          clickCallBack: () => _clickCell('设为星标朋友'),
        ),
        SizedBox(height: rowSpace),
        JhSetCell(
          cellHeight: cellH,
          title: '加入黑名单',
          hiddenArrow: true,
          rightWidget: CupertinoSwitch(
            value: _switchSelected2,
            onChanged: (value) {
              setState(() {
                _switchSelected2 = value;
              });
            },
          ),
          clickCallBack: () => _clickCell('加入黑名单'),
        ),
        JhSetCell(
          cellHeight: cellH,
          title: '投诉',
          hiddenLine: true,
          clickCallBack: () => _clickCell('投诉'),
        ),
        SizedBox(height: rowSpace),
        InkWell(
          onTap: () => _clickCell('删除'),
          child: Container(
            height: cellH,
            color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('删除', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red))
              ],
            ),
          ),
        )
      ],
    );
  }

  void _clickCell(title) {
    JhToast.showText(context, msg: '点击 $title');
  }
}
