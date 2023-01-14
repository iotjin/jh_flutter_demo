///  wxPay_manager_page.dart
///
///  Created by iotjin on 2020/08/28.
///  description:  微信 支付管理

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/project/configs/project_config.dart';

class WxPayManagerPage extends StatefulWidget {
  const WxPayManagerPage({Key? key}) : super(key: key);

  @override
  State<WxPayManagerPage> createState() => _WxPayManagerPageState();
}

class _WxPayManagerPageState extends State<WxPayManagerPage> {
  final double _cellH = wxCellH;
  final double _rowSpace = wxRowSpace;
  bool _switchSelected = false;
  bool _switchSelected2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(KStrings.wxPayManager, bgColor: Colors.transparent),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        JhSetCell(
          cellHeight: _cellH,
          title: '实名认证',
          text: '已认证',
          hiddenLine: true,
          clickCallBack: () => _clickCell('实名认证'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '修改支付密码',
          clickCallBack: () => _clickCell('修改支付密码'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '忘记支付密码',
          hiddenLine: true,
          clickCallBack: () => _clickCell('忘记支付密码'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '指纹支付',
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
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 25, 15),
          child: const Text(
            '开启后，转账或消费时，可使用 Touch ID 验证指纹快速完成付款',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
        JhSetCell(
          cellHeight: _cellH,
          titleWidth: 200,
          title: '允许通过手机号向我转账',
          hiddenLine: true,
          hiddenArrow: true,
          rightWidget: CupertinoSwitch(
            value: _switchSelected2,
            onChanged: (value) {
              setState(() {
                _switchSelected2 = value;
              });
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 25, 15),
          child: RichText(
            text: TextSpan(children: <InlineSpan>[
              const TextSpan(
                text: '他人可进入“收付款 > 向银行卡手机号转账”，向你的微信绑定手机号转账，收款将存入零钱。开启即同意',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                text: '服务协议',
                style: const TextStyle(color: Colors.blueAccent, fontSize: 15),
                recognizer: TapGestureRecognizer()..onTap = () => _clickXieYi(),
              ),
            ]),
          ),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '扣费服务',
          clickCallBack: () => _clickCell('扣费服务'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '转账到账时间',
          text: '实时到账',
          clickCallBack: () => _clickCell('转账到账时间'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '红包退款方式',
          text: '退回原支付方式',
          hiddenLine: true,
          clickCallBack: () => _clickCell('红包退款方式'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '服务管理',
          hiddenLine: true,
          clickCallBack: () => _clickCell('服务管理'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '注销微信支付',
          hiddenLine: true,
          clickCallBack: () => _clickCell('注销微信支付'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          titleWidth: 150,
          title: '微信收款商家版',
          hiddenLine: true,
          clickCallBack: () => _clickCell('微信收款商家版'),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  void _clickXieYi() {
    JhToast.showText(context, msg: '点击服务协议');
  }

  void _clickCell(title) {
    JhToast.showText(context, msg: '点击 $title');
  }
}
