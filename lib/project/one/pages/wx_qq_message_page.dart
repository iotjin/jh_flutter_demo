///  wx_qq_message_page.dart
///
///  Created by iotjin on 2020/09/03.
///  description: QQ邮箱提醒

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/project/configs/project_config.dart';
import '../models/wx_qq_message_model.dart';
import '../widgets/wx_qq_message_cell.dart';

List _dataArr = [
  {
    'title': '消息1',
    'subtitle': '您收到一封新的邮件',
  },
  {
    'title': '消息2',
    'subtitle': '您收到一封新的邮件',
  },
];

class WxQQMessagePage extends StatelessWidget {
  const WxQQMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'QQ邮箱提醒',
        rightImgPath: 'assets/images/ic_more_black.png',
        bgColor: Colors.transparent,
        rightItemCallBack: () => _clickCell(context, '更多'),
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    var dataArr = _dataArr;
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: dataArr.length,
//            itemExtent: 150.0, // 强制高度为100.0
          itemBuilder: (context, index) {
            WxQQMessageModel model = WxQQMessageModel.fromJson(dataArr[index]);
            return WxQQMessageCell(
              model: model,
              onClickCell: (model) {
                _clickCell(context, model['title']);
              },
            );
          },
        ),
        Positioned(left: 0, right: 0, bottom: 0, child: _bottomView(context, dataArr)),
      ],
    );
  }

  _bottomView(context, dataArr) {
    return Container(
      height: JhScreenUtils.bottomSafeHeight + 60,
      color: KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor),
      child: SafeArea(
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 60,
                color: KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor),
                child: const Center(child: Text('写邮件')),
              ),
              onTap: () => _clickCell(context, '写邮件'),
            ),
          ),
          Container(height: 60, width: 0.5, color: KColors.kLineColor),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 60,
                color: KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor),
                child: Center(child: Text('QQ邮箱（${dataArr.length}）')),
              ),
              onTap: () => _clickCell(context, 'QQ邮箱'),
            ),
          ),
        ],
      )),
    );
  }

  // 点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 $text');
  }
}
