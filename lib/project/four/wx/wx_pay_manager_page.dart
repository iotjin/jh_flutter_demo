/**
 *  wx_pay_manager_page.dart
 *
 *  Created by iotjin on 2020/08/28.
 *  description:  微信 支付管理
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_photo_allscreen_show.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jhtoast/jhtoast.dart';

class WxPayManagerPage extends StatefulWidget {
  @override
  _WxPayManagerPageState createState() => _WxPayManagerPageState();
}

class _WxPayManagerPageState extends State<WxPayManagerPage> {
  double _cellH = wx_cellH;
  double _rowSpace = wx_rowSpace;
  bool _switchSelected = false;
  bool _switchSelected2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, KString.wx_payManager,
          backgroundColor: Colors.transparent),
      body: _body(context),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }

  Widget _body(context) {
    return ListView(
      children: <Widget>[
        JhSetCell(
          cellHeight: _cellH,
          title: '实名认证',
          text: '已认证',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '实名认证'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '修改支付密码',
          clickCallBack: () => _clickCell(context, '修改支付密码'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '忘记支付密码',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '忘记支付密码'),
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
          padding: EdgeInsets.fromLTRB(20, 5, 25, 15),
          child: Text(
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
          padding: EdgeInsets.fromLTRB(20, 5, 25, 15),
          child: RichText(
            text: TextSpan(children: <InlineSpan>[
              TextSpan(
                text: '他人可进入“收付款 > 向银行卡手机号转账”，向你的微信绑定手机号转账，收款将存入零钱。开启即同意',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                text: '服务协议',
                style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => _clickXieYi(context),
              ),
            ]),
          ),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '扣费服务',
          clickCallBack: () => _clickCell(context, '扣费服务'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '转账到账时间',
          text: '实时到账',
          clickCallBack: () => _clickCell(context, '转账到账时间'),
        ),
        JhSetCell(
          cellHeight: _cellH,
          title: '红包退款方式',
          text: '退回原支付方式',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '红包退款方式'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '服务管理',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '服务管理'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          title: '注销微信支付',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '注销微信支付'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          titleWidth: 150,
          title: '微信收款商家版',
          hiddenLine: true,
          clickCallBack: () => _clickCell(context, '微信收款商家版'),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  void _clickXieYi(context) {
    JhToast.showText(context, msg: '点击服务协议');
  }

  void _clickCell(context, title) {
    JhToast.showText(context, msg: '点击 ${title}');
  }
}
