///  wx_motion_page.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/project/configs/project_config.dart';
import '../models/wx_motion_model.dart';
import '../widgets/wx_motion_cell.dart';

List _dataArr = [
  {
    'time': '2020年5月8日 22:10',
    'ranking': '10',
    'steps': '2861',
    'img': 'assets/images/picture/touxiang_1.jpeg',
    'text': '夺得05月08日排行榜冠军',
    'color': '#00AE5B',
  },
  {
    'time': '2020年6月6日 22:22',
    'ranking': '3',
    'steps': '12180',
    'img': 'assets/images/picture/touxiang_2.jpeg',
    'text': '夺得6月6日排行榜冠军',
    'color': '#FF8B22',
  },
  {
    'time': '2020年7月12日 22:01',
    'ranking': '7',
    'steps': '1986',
    'img': 'assets/images/picture/touxiang_3.jpeg',
    'text': '夺得7月12日排行榜冠军',
    'color': '#00AE5B',
  },
  {
    'time': '2020年8月18日 22:09',
    'ranking': '6',
    'steps': '23354',
    'img': 'assets/images/picture/touxiang_4.jpeg',
    'text': '夺得8月18日排行榜冠军',
    'color': '#FF8B22',
  },
  {
    'time': '2020年9月9日 22:23',
    'ranking': '1',
    'steps': '20015',
    'img': 'assets/images/picture/touxiang_5.jpeg',
    'text': '夺得9月9日排行榜冠军',
    'color': '#FF8B22',
  },
];

class WxMotionPage extends StatelessWidget {
  const WxMotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        '微信运动',
        rightImgPath: 'assets/images/ic_set_black.png',
        bgColor: Colors.transparent,
        rightItemCallBack: () => _clickCell(context, '设置'),
      ),
      body: _body(context),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
      bottomNavigationBar: _bottomView(context),
    );
  }

  Widget _body(context) {
    var dataArr = _dataArr;
    return ListView.builder(
      itemCount: dataArr.length,
      // itemExtent: 150.0, // 强制高度为100.0
      itemBuilder: (context, index) {
        WxMotionModel model = WxMotionModel.fromJson(dataArr[index]);
        return WxMotionCell(
          model: model,
          onClickCell: (model) {
            JhNavUtils.pushNamed(context, 'WxMotionTopPage');
          },
        );
      },
    );
  }

  _bottomView(context) {
    return Container(
      height: JhScreenUtils.bottomSafeHeight + 60,
      color: KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  height: 60,
                  color: KColors.dynamicColor(context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor),
                  child: const Center(child: Text('步数排行榜')),
                ),
                onTap: () => _clickCell(context, '步数排行榜'),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 $text');
  }
}
