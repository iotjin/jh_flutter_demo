///  wx_pay_page.dart
///
///  Created by iotjin on 2020/08/27.
///  description: 微信支付

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_pay_model.dart';
import '../widgets/wx_pay_cell.dart';

double _money = 345345.13;

class WxPayPage extends StatefulWidget {
  const WxPayPage({Key? key}) : super(key: key);

  @override
  State<WxPayPage> createState() => _WxPayPageState();
}

class _WxPayPageState extends State<WxPayPage> {
  final _dataArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 3; i++) {
      var maxCount = i == 1 ? 2 : 8;
      var title = i == 0 ? '腾讯服务' : (i == 1 ? '限时推广' : '三方服务');

      var map = <String, dynamic>{};
      map['title'] = title;
      var funcList = [];
      for (int j = 0; j < maxCount; j++) {
        var map2 = <String, dynamic>{};
        map2['text'] = '功能功能$j';
        map2['img'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
        map2['pushName'] = 'PageName';
        funcList.add(map2);
      }
      map['funcList'] = funcList;
      _dataArr.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        KStrings.wxPay,
        rightImgPath: 'assets/images/ic_more_black.png',
        bgColor: Colors.transparent,
        rightItemCallBack: () => JhNavUtils.pushNamed(context, 'WxPayManagerPage'),
      ),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Column(
          children: <Widget>[
            _payCard(),
            _listWidget(_dataArr),
            const SizedBox(height: 50),
          ],
        ),
      ],
    );
  }

  Widget _payCard() {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      // 设置圆角
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // 普通的边
      // shape: Border.all(color: Colors.yellow, width: 5.0),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      // 阴影大小
      elevation: 3,
      child: Container(
        height: 150,
        color: KColors.wxPayColor,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Image.asset('assets/wechat/mine/ic_shoufukuan.png', width: 40),
                  const SizedBox(height: 8),
                  const Text('收付款', style: TextStyle(color: Colors.white, fontSize: 16))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Image.asset('assets/wechat/mine/ic_qianbao.png', width: 40),
                  const SizedBox(height: 8),
                  const Text('收付款', style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text('¥$_money', style: const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: const Text('暂无数据', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.builder(
        itemCount: dataArr.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          WxPayModel model = WxPayModel.fromJson(dataArr[index]);
          return WxPayCell(
            model: model,
            onClickCell: (model) {
              print(model);
              JhProgressHUD.showText(model['text']);
              // JhNavUtils.pushNamed(context, model['pushName']);
            },
          );
        },
      );
    }
  }
}
