///  strings.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  字符串配置

import 'package:flutter/cupertino.dart';

class KStrings {
  // 默认  屏幕像素  基于该像素进行适配
  static const double deviceHeightPix = 1920;
  static const double deviceWidthPix = 1080;

  // 主界面切换使用到的文本
  static const String oneTabTitle = '微信';
  static const String twoTabTitle = '通讯录';
  static const String threeTabTitle = '发现';
  static const String fourTabTitle = '我的';

  static const String wxPersonInfo = '个人信息';
  static const String wxPay = '支付';
  static const String wxPayManager = '支付管理';

  static const String testTitle = 'DemoList';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

// 使用
// Future.delayed(Duration(milliseconds: 200), () {
//   BuildContext context = KStrings.navigatorKey.currentContext!;
// });

  // static String headBgImage = 'https://picsum.photos/800/200';
  static const String headBgImage = 'https://placekitten.com/800/200';
  static const String headBgImage2 = 'https://picsum.photos/500/500';
  static const String avatarImage = 'https://picsum.photos/300/300'; // 'https://picsum.photos/300/300?random=$index'
}
