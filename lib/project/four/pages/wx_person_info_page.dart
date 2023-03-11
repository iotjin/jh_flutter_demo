///  wx_person_info_page.dart
///
///  Created by iotjin on 2020/08/27.
///  description:  微信 个人信息

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/jh_common/widgets/jh_photo_browser.dart';
import '/project/configs/project_config.dart';

class WxPersonInfoPage extends StatelessWidget {
  const WxPersonInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(KStrings.wxPersonInfo, bgColor: Colors.transparent),
      body: _body(context),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }
}

double _cellH = wxCellH;
double _rowSpace = wxRowSpace;

Widget _body(context) {
  return ListView(
    children: <Widget>[
      JhSetCell(
        cellHeight: 75,
        title: '头像',
        rightWidget: const JhNetworkImage('https://gitee.com/iotjh/Picture/raw/master/lufei.png',
            placeholder: 'lufei', width: 55, height: 55, borderRadius: 5),
        clickCallBack: () {
          var imgData = ['https://gitee.com/iotjh/Picture/raw/master/lufei.png'];
          JhPhotoBrowser.show(context, data: imgData, index: 0, isHiddenClose: true,
              onLongPress: (int index, dynamic imgArr) {
            JhBottomSheet.showText(context, dataArr: ['保存图片'], clickCallback: (index, str) {});
          });
        },
      ),
      JhSetCell(cellHeight: _cellH, title: '名字', text: 'jin'),
      JhSetCell(cellHeight: _cellH, title: '拍一拍'),
      JhSetCell(cellHeight: _cellH, title: '微信号', text: 'abc'),
      JhSetCell(
        cellHeight: _cellH,
        title: '我的二维码',
        rightWidget: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Image.asset('assets/wechat/mine/ic_setting_myQR.png', width: 20, height: 20, fit: BoxFit.fill),
        ),
      ),
      JhSetCell(cellHeight: _cellH, title: '更多', hiddenLine: true),
      SizedBox(height: _rowSpace),
      JhSetCell(cellHeight: _cellH, title: '我的地址', hiddenLine: true),
      const SizedBox(height: 15),
    ],
  );
}
