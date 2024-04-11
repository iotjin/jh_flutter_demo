///  wx_discover_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 发现

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/widgets/jh_badge.dart';
import '/project/configs/project_config.dart';

class WxDiscoverPage extends StatelessWidget {
  const WxDiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(IntlKeys.threeTabTitle.tr, bgColor: Colors.transparent, leftWidget: Container()),
      body: _body(context),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }
}

double _cellH = 55.0;
double _leftSpace = 50.0;
double _rowSpace = 6;

Widget _body(context) {
  return ListView(
    children: <Widget>[
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_social_circle.png',
        title: IntlKeys.discoverMoments.tr,
        // hiddenLine: true,
//      rightWidget: Image.network('https://gitee.com/iotjh/Picture/raw/master/lufei.png',width: 50,height: 50,),
        rightWidget: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: JhBadge(child: Image.asset('assets/images/lufei.png', width: 30, height: 30, fit: BoxFit.fill)),
        ),
        clickCallBack: () => _clickCell(context, 'WxFriendsCirclePage'),
      ),
      JhSetCell(
        titleWidth: 200,
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_social_circle.png',
        title: IntlKeys.discoverMomentsMock.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, 'WxFriendsCirclePage2'),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_video_number.png',
        title: IntlKeys.discoverChannels.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/wechat/discover/ic_quick_scan.png',
        title: IntlKeys.discoverScan.tr,
        clickCallBack: () => _clickCell(context, ''),
      ),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_shake_phone.png',
        title: IntlKeys.discoverShake.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/wechat/discover/ic_feeds.png',
        title: IntlKeys.discoverTopStories.tr,
        clickCallBack: () => _clickCell(context, ''),
      ),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_quick_search.png',
        title: IntlKeys.discoverSearch.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_people_nearby.png',
        title: IntlKeys.discoverNearby.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/wechat/discover/ic_shopping.png',
        title: IntlKeys.discoverShopping.tr,
        clickCallBack: () => _clickCell(context, ''),
      ),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_game_entry.png',
        title: IntlKeys.discoverGames.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      SizedBox(height: _rowSpace),
      JhSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/wechat/discover/ic_mini_program.png',
        title: IntlKeys.discoverMiniPrograms.tr,
        hiddenLine: true,
        clickCallBack: () => _clickCell(context, ''),
      ),
      const SizedBox(height: 15),
    ],
  );
}

// 点击cell
_clickCell(context, String path) {
  if (path.isNotEmpty) {
    JhNavUtils.pushNamed(context, path);
  }
}

Widget testBtn(context) {
  return Container(
    alignment: Alignment.center,
    // 子组件将以何种方式进行排列
    margin: const EdgeInsets.all(20),
    // 容器外补白
    color: Colors.yellow,
    width: 200,
    height: 200,
    child: ElevatedButton(
      child: const Text('点击跳转'),
      onPressed: () {
        JhNavUtils.pushNamed(context, 'UIDemoListPage');
//          Navigator.push(context, MaterialPageRoute(builder: (context) => (UIDemoListPage())));// 普通路由
//          Navigator.push(context, MaterialPageRoute(builder: (context) => (testPage(content: '这是route传递的参数',))));// 普通路由
//          JhNavUtils.pushNamed(context,'/Test');// 命名路由
      },
    ),
  );
}
