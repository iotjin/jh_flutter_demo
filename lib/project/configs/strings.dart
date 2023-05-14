///  strings.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  字符串配置

import 'package:flutter/cupertino.dart';

class KStrings {
  // 默认  屏幕像素  基于该像素进行适配
  static double deviceHeightPix = 1920;
  static double deviceWidthPix = 1080;

  // 主界面切换使用到的文本
  static String oneTabTitle = '微信';
  static String twoTabTitle = '通讯录';
  static String threeTabTitle = '发现';
  static String fourTabTitle = '我的';

  static String wxPersonInfo = '个人信息';
  static String wxPay = '支付';
  static String wxPayManager = '支付管理';

  static String testTitle = 'DemoList';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

// 使用
// Future.delayed(Duration(milliseconds: 200), () {
//   BuildContext context = KStrings.navigatorKey.currentContext!;
// });

  // static String headBgImage = 'https://picsum.photos/800/200';
  static String headBgImage = 'https://placekitten.com/800/200';
  static String headBgImage2 = 'https://picsum.photos/500/500';
  static String avatarImage = 'https://picsum.photos/300/300'; // 'https://picsum.photos/300/300?random=$index'
}
