import 'dart:convert';
import 'package:fluro/fluro.dart';

import '/project/routes/router_init.dart';
import '/jh_common/widgets/qr_code_grid_scanner_page.dart';
import '/jh_common/widgets/qr_code_scanner_page.dart';

import '/project/one/one_page.dart';
import '/project/two/two_page.dart';
import '/project/three/three_page.dart';
import '/project/four/four_page.dart';

// four
import '/project/four/pages/set_page.dart';
import '/project/four/pages/info_page.dart';
import '/project/four/pages/theme_page.dart';
import '/project/four/pages/about_page.dart';
import '/project/four/pages/about_ios_page.dart';
import '/project/four/pages/mine_page.dart';
import '/project/two/pages/wx_info_set_page.dart';
import '/project/four/pages/img_pull_down_big_page.dart';
import '/project/four/pages/img_pull_down_big_page2.dart';
import '/project/four/pages/img_pull_down_big_page3.dart';
import '/project/four/pages/person_center_page.dart';
import '/project/four/pages/person_center_page2.dart';
import '/project/four/pages/fade_app_bar_page.dart';

// wx
// 首页
import 'one/pages/wx_home_page.dart';
import 'one/pages/wx_qq_message_page.dart';
import 'one/pages/wx_subscription_number_page.dart';
import 'one/pages/wx_subscription_number_list_page.dart';
import 'one/pages/wx_motion_page.dart';
import 'one/pages/wx_motion_top_page.dart';

// 联系人
import 'two/pages/wx_contacts_page.dart';
import 'two/pages/wx_user_info_page.dart';
import 'two/pages/wx_new_friend_page.dart';
import 'two/pages/wx_add_friend_page.dart';
import 'two/pages/wx_group_chat_page.dart';

// 发现
import 'three/pages/wx_discover_page.dart';
import 'three/pages/wx_friends_circle_page.dart';
import 'three/pages/wx_friends_circle_page2.dart';

// 我的
import 'four/pages/wx_mine_page.dart';
import 'four/pages/wx_person_info_page.dart';
import 'four/pages/wx_pay_page.dart';
import 'four/pages/wx_pay_manager_page.dart';

class MainRouter implements IRouterProvider {
  static String pOnePage = '/onePage';
  static String pTwoPage = '/twoPage';
  static String pThreePage = '/threePage';
  static String pFourPage = '/fourPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pOnePage, handler: Handler(handlerFunc: (_, __) => const OnePage()));
    router.define(pTwoPage, handler: Handler(handlerFunc: (_, __) => const TwoPage()));
    router.define(pThreePage, handler: Handler(handlerFunc: (_, __) => const ThreePage()));
    router.define(pFourPage, handler: Handler(handlerFunc: (_, __) => const FourPage()));
    // 二维码扫描
    router.define('QrCodeGridScannerPage', handler: Handler(handlerFunc: (_, __) => const QrCodeGridScannerPage()));
    router.define('QrCodeScannerPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return QrCodeScannerPage(isShowScanLine: jsonDecode(jumpParams));
    }));

    router.define('SetPage', handler: Handler(handlerFunc: (_, __) => const SetPage()));
    router.define('InfoPage', handler: Handler(handlerFunc: (_, __) => const InfoPage()));
    router.define('ThemePage', handler: Handler(handlerFunc: (_, __) => const ThemePage()));
    router.define('AboutPage', handler: Handler(handlerFunc: (_, __) => const AboutPage()));
    router.define('AboutIOSPage', handler: Handler(handlerFunc: (_, __) => const AboutIOSPage()));
    router.define('MinePage', handler: Handler(handlerFunc: (_, __) => const MinePage()));
    router.define('ImgPullDownBigPage', handler: Handler(handlerFunc: (_, __) => const ImgPullDownBigPage()));
    router.define('ImgPullDownBigPage2', handler: Handler(handlerFunc: (_, __) => const ImgPullDownBigPage2()));
    router.define('ImgPullDownBigPage3', handler: Handler(handlerFunc: (_, __) => const ImgPullDownBigPage3()));
    router.define('PersonCenterPage', handler: Handler(handlerFunc: (_, __) => const PersonCenterPage()));
    router.define('PersonCenterPage2', handler: Handler(handlerFunc: (_, __) => const PersonCenterPage2()));
    router.define('FadeAppBarPage', handler: Handler(handlerFunc: (_, __) => const FadeAppBarPage()));

    /********************************* 首页 ********************************/

    router.define('WxHomePage', handler: Handler(handlerFunc: (_, __) => const WxHomePage()));
    router.define('WxQQMessagePage', handler: Handler(handlerFunc: (_, __) => const WxQQMessagePage()));
    router.define('WxSubscriptionNumberPage',
        handler: Handler(handlerFunc: (_, __) => const WxSubscriptionNumberPage()));
    router.define('WxSubscriptionNumberListPage',
        handler: Handler(handlerFunc: (_, __) => const WxSubscriptionNumberListPage()));
    router.define('WxMotionPage', handler: Handler(handlerFunc: (_, __) => const WxMotionPage()));
    router.define('WxMotionTopPage', handler: Handler(handlerFunc: (_, __) => const WxMotionTopPage()));

    /********************************* 联系人 ********************************/

    router.define('WxContactsPage', handler: Handler(handlerFunc: (_, __) => const WxContactsPage()));
    // 个人信息页面
    router.define('WxUserInfoPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return WxUserInfoPage(jsonDecode(jumpParams));
    }));
    // 资料设置
    router.define('WxInfoSetPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return WxInfoSetPage(jsonDecode(jumpParams));
    }));
    router.define('WxAddFriendPage', handler: Handler(handlerFunc: (_, __) => const WxAddFriendPage()));
    router.define('WxNewFriendPage', handler: Handler(handlerFunc: (_, __) => const WxNewFriendPage()));
    router.define('WxGroupChatPage', handler: Handler(handlerFunc: (_, __) => const WxGroupChatPage()));

    /********************************* 发现 ********************************/

    router.define('WxDiscoverPage', handler: Handler(handlerFunc: (_, __) => const WxDiscoverPage()));
    router.define('WxFriendsCirclePage', handler: Handler(handlerFunc: (_, __) => const WxFriendsCirclePage()));
    router.define('WxFriendsCirclePage2', handler: Handler(handlerFunc: (_, __) => const WxFriendsCirclePage2()));

    /********************************* 我的 ********************************/

    router.define('WxMinePage', handler: Handler(handlerFunc: (_, __) => const WxMinePage()));
    router.define('WxPersonInfoPage', handler: Handler(handlerFunc: (_, __) => const WxPersonInfoPage()));
    router.define('WxPayPage', handler: Handler(handlerFunc: (_, __) => const WxPayPage()));
    router.define('WxPayManagerPage', handler: Handler(handlerFunc: (_, __) => const WxPayManagerPage()));
  }
}
