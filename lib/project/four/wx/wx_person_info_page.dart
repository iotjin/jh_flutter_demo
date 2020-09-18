/**
 *  wx_person_info_page.dart
 *
 *  Created by iotjin on 2020/08/27.
 *  description:  微信 个人信息
 */

import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_photo_browser.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

class WxPersonInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, KString.wx_personInfo,
          backgroundColor: Colors.transparent),
      body: _body(context),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }
}

double _cellH = wx_cellH;
double _rowSpace = wx_rowSpace;

Widget _body(context) {
  return ListView(
    children: <Widget>[
      JhSetCell(
        cellHeight: 75,
        title: '头像',
//      rightWidget: Image.network('https://gitee.com/iotjh/Picture/raw/master/lufei.png',width: 50,height: 50,),
        rightWidget: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                      'https://gitee.com/iotjh/Picture/raw/master/lufei.png'))),
        ),
        clickCallBack: () {
          var imgData = [
            'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
          ];
          Navigator.of(context).push(new FadeRoute(
              page: JhPhotoBrowser(
            imgDataArr: imgData,
            index: 0,
            isHiddenClose: true,
            isHiddenTitle: true,
            onLongPress: () {
              JhBottomSheet.showText(context,
                  dataArr: ['保存图片'], clickCallback: (index, str) {});
            },
          )));
        },
      ),
      JhSetCell(
        cellHeight: _cellH,
        title: '名字',
        text: 'jin',
      ),
      JhSetCell(
        cellHeight: _cellH,
        title: '拍一拍',
      ),
      JhSetCell(
        cellHeight: _cellH,
        title: '微信号',
        text: 'abc',
      ),
      JhSetCell(
        cellHeight: _cellH,
        title: '我的二维码',
        rightWidget: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset('assets/wechat/mine/ic_setting_myQR.png',
                width: 20, height: 20, fit: BoxFit.fill)),
      ),
      JhSetCell(
        cellHeight: _cellH,
        title: '更多',
        hiddenLine: true,
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        title: '我的地址',
        hiddenLine: true,
      ),
      SizedBox(height: 15),
    ],
  );
}
