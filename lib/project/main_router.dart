import 'dart:convert';
import 'package:fluro/fluro.dart';

import '/project/model/contacts_model.dart';
import '/project/routes/router_init.dart';
import '/jh_common/widgets/qr_code_grid_scanner_page.dart';
import '/jh_common/widgets/qr_code_scanner_page.dart';

import '/project/one/one_page.dart';
import '/project/two/two_page.dart';
import '/project/three/three_page.dart';

// four
import '/project/four/four_page.dart';
import '/project/four/pages/set_page.dart';
import '/project/four/pages/info_page.dart';
import '/project/four/pages/theme_page.dart';
import '/project/four/pages/about_page.dart';
import '/project/four/pages/about_ios_page.dart';
import '/project/four/pages/mine_page.dart';
import '/project/two/wx/wx_info_set_page.dart';
import '/project/four/pages/img_pull_down_big_page.dart';
import '/project/four/pages/img_pull_down_big_page2.dart';
import '/project/four/pages/img_pull_down_big_page3.dart';
import '/project/four/pages/person_center_page.dart';
import '/project/four/pages/person_center_page2.dart';
import '/project/four/pages/fade_app_bar_page.dart';

// wx
// 首页
import 'one/wx/wx_qq_message_page.dart';
import 'one/wx/wx_subscription_number_page.dart';
import 'one/wx/wx_subscription_number_list_page.dart';
import 'one/wx/wx_motion_page.dart';
import 'one/wx/wx_motion_top_page.dart';

// 联系人
import 'two/wx/wx_userInfo_page.dart';
import 'two/wx/wx_new_friend_page.dart';
import 'two/wx/wx_add_friend_page.dart';
import 'two/wx/wx_group_chat_page.dart';

// 发现
import 'three/wx/wx_friends_circle_page.dart';

// 我的
import 'four/wx/wx_person_info_page.dart';
import 'four/wx/wx_pay_page.dart';
import 'four/wx/wx_pay_manager_page.dart';

class MainRouter implements IRouterProvider {
  static String pOnePage = '/onePage';
  static String pTwoPage = '/twoPage';
  static String pThreePage = '/threePage';
  static String pFourPage = '/fourPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pOnePage, handler: Handler(handlerFunc: (_, __) => OnePage()));
    router.define(pTwoPage, handler: Handler(handlerFunc: (_, __) => TwoPage()));
    router.define(pThreePage, handler: Handler(handlerFunc: (_, __) => ThreePage()));
    router.define(pFourPage, handler: Handler(handlerFunc: (_, __) => FourPage()));
    // 二维码扫描
    router.define('QrCodeGridScannerPage', handler: Handler(handlerFunc: (_, __) => QrCodeGridScannerPage()));
    router.define('QrCodeScannerPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return QrCodeScannerPage(isShowScanLine: jsonDecode(jumpParams));
    }));

    router.define('SetPage', handler: Handler(handlerFunc: (_, __) => SetPage()));
    router.define('InfoPage', handler: Handler(handlerFunc: (_, __) => InfoPage()));
    router.define('ThemePage', handler: Handler(handlerFunc: (_, __) => ThemePage()));
    router.define('AboutPage', handler: Handler(handlerFunc: (_, __) => AboutPage()));
    router.define('AboutIOSPage', handler: Handler(handlerFunc: (_, __) => AboutIOSPage()));
    router.define('MinePage', handler: Handler(handlerFunc: (_, __) => MinePage()));
    router.define('ImgPullDownBigPage', handler: Handler(handlerFunc: (_, __) => ImgPullDownBigPage()));
    router.define('ImgPullDownBigPage2', handler: Handler(handlerFunc: (_, __) => ImgPullDownBigPage2()));
    router.define('ImgPullDownBigPage3', handler: Handler(handlerFunc: (_, __) => ImgPullDownBigPage3()));
    router.define('PersonCenterPage', handler: Handler(handlerFunc: (_, __) => PersonCenterPage()));
    router.define('PersonCenterPage2', handler: Handler(handlerFunc: (_, __) => PersonCenterPage2()));
    router.define('FadeAppBarPage', handler: Handler(handlerFunc: (_, __) => FadeAppBarPage()));

    /********************************* 首页 ********************************/

    router.define('WxQQMessagePage', handler: Handler(handlerFunc: (_, __) => WxQQMessagePage()));
    router.define('WxSubscriptionNumberPage', handler: Handler(handlerFunc: (_, __) => WxSubscriptionNumberPage()));
    router.define('WxSubscriptionNumberListPage',
        handler: Handler(handlerFunc: (_, __) => WxSubscriptionNumberListPage()));
    router.define('WxMotionPage', handler: Handler(handlerFunc: (_, __) => WxMotionPage()));
    router.define('WxMotionTopPage', handler: Handler(handlerFunc: (_, __) => WxMotionTopPage()));

    /********************************* 联系人 ********************************/

    // 个人信息页面
    router.define('WxUserInfoPage', handler: Handler(handlerFunc: (_, params) {
//      print('---------params---------');
//      print(params);
      String jsonStr = params['passValue']!.first;
      ContactsModel model = ContactsModel.fromJson(json.decode(jsonStr));
//      print('model: ${ model.name }');
//      print('---------params---------');
      return WxUserInfoPage(model);
    }));
    // 资料设置
    router.define('WxInfoSetPage', handler: Handler(handlerFunc: (_, params) {
      String jsonStr = params['passValue']!.first;
      ContactsModel model = ContactsModel.fromJson(json.decode(jsonStr));
      return WxInfoSetPage(model);
    }));
    router.define('WxAddFriendPage', handler: Handler(handlerFunc: (_, __) => WxAddFriendPage()));
    router.define('WxNewFriendPage', handler: Handler(handlerFunc: (_, __) => WxNewFriendPage()));
    router.define('WxGroupChatPage', handler: Handler(handlerFunc: (_, __) => WxGroupChatPage()));

    /********************************* 发现 ********************************/
    router.define('WxFriendsCirclePage', handler: Handler(handlerFunc: (_, __) => WxFriendsCirclePage()));

    /********************************* 我的 ********************************/
    router.define('WxPersonInfoPage', handler: Handler(handlerFunc: (_, __) => WxPersonInfoPage()));
    router.define('WxPayPage', handler: Handler(handlerFunc: (_, __) => WxPayPage()));
    router.define('WxPayManagerPage', handler: Handler(handlerFunc: (_, __) => WxPayManagerPage()));
  }
}
