// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '/project/login/pages/login_page.dart';
import '/project/login/pages/register_page.dart';
import '/project/login/pages/find_pwd_page.dart';
import '/project/login/pages/code_login_page.dart';

import '/project/one/one_page.dart';
import '/project/two/two_page.dart';
import '/project/three/three_page.dart';

// four
import '/project/four/four_page.dart';
import '/project/four/pages/set_page.dart';
import '/project/four/pages/info_page.dart';
import '/project/four/pages/about_page.dart';
import '/project/four/pages/about_ios_page.dart';

import '/demos/demo_list_page.dart';

// alert
import '/demos/alert/alert_demo_list_page.dart';
import '../../demos/alert/bottom_sheet_test.dart';
import '../../demos/alert/alert_test.dart';

// toast
import '/demos/alert/toast/toast_demo_list_page.dart';
import '/demos/alert/toast/toast_test.dart';

// chart
import '/demos/chart/chart_demo_list_page.dart';
import '/demos/chart/chart_page1.dart';
import '/demos/chart/chart_page2.dart';
import '../../demos/chart/echarts/eChart_page1.dart';
import '/demos/chart/mpChart_line_page1.dart';

// 表单
import '/demos/form/form_demo_list_page.dart';
import '/demos/form/login_text_field_test_page.dart';
import '/demos/form/input_text_field_test_page.dart';
import '/demos/form/form_Input_cell_test_page.dart';
import '/demos/form/form_select_cell_test_page.dart';
import '/demos/form/set_cell_test_page.dart';
import '/demos/form/form_test_page.dart';

// gridView
import '/demos/gridView/gridview_demo_list_page.dart';
import '../../demos/gridView/gridview_test1.dart';
import '../../demos/gridView/gridview_test2.dart';
import '../../demos/gridView/gridview_test3.dart';
import '../../demos/gridView/gridview_test4.dart';
import '../../demos/gridView/gridview_test5.dart';

// http
import '/demos/http/http_demo_list_page.dart';
import '/demos/http/http_test1_page.dart';
import '/demos/http/http_page_test_page.dart';

// ListView
import '/demos/listView/listview_demo_list_page.dart';
import '../../demos/listView/listview_test.dart';
import '../../demos/listView/listview_test2.dart';
import '../../demos/listView/listview_test3.dart';
import '../../demos/listView/listview_test4.dart';
import '../../demos/listView/listview_test5.dart';
import '../../demos/listView/listview_test_card.dart';
import '../../demos/listView/listview_test_custom_vc.dart';
import '../../demos/listView/listview_test_simple_pull_down.dart';
import '../../demos/listView/listview_test_pull_down_vc.dart';

// other
import '/demos/other/form_test.dart';
import '/demos/other/photo_select_test.dart';
import '../../demos/route_test_page/pass_value_page.dart';
import '../../demos/route_test_page/pass_value_page2.dart';
import '../../demos/base/nav_test.dart';
import '../../demos/other/red_dot_page.dart';
import '../../demos/other/qr_code_test.dart';

// search
import '/demos/search/search_demo_list_page.dart';
import '/demos/search/search_test1_page.dart';
import '/demos/search/search_test2_page.dart';
import '/demos/search/search_test3_page.dart';

// TopTabBar
import '/demos/topTabBar/top_tabbar_demo_list_page.dart';
import '../../demos/topTabBar/top_tabbar_test1_page.dart';
import '../../demos/topTabBar/top_tabbar_test2_page.dart';
import '../../demos/topTabBar/top_tabbar_test3_page.dart';

import '/demos/ui/ui_demo_list_page.dart';
import '/demos/ui/ui_page.dart';
import '/demos/ui/ui_page2.dart';

final String home = '/';

final String loginPage = 'LoginPage';
final String onePage = '/onePage';
final String twoPage = '/twoPage';
final String threePage = '/threePage';
final String fourPage = '/fourPage';

final String demoListPage = 'DemoListPage';

// 配置路由命名信息
final routes = {
  loginPage: (context) => LoginPage(),
  'RegisterPage': (context) => RegisterPage(),
  'FindPwdPage': (context) => FindPwdPage(),
  'CodeLoginPage': (context) => CodeLoginPage(),

  onePage: (context) => OnePage(),
  twoPage: (context) => TwoPage(),
  threePage: (context) => ThreePage(),

  // four
  fourPage: (context) => FourPage(),
  'SetPage': (context) => SetPage(),
  'InfoPage': (context) => InfoPage(),
  'AboutPage': (context) => AboutPage(),
  'AboutIOSPage': (context) => AboutIOSPage(),

  demoListPage: (context) => DemoListPage(),

  // Alert
  'AlertDemoListPage': (context) => AlertDemoListPage(),
  'AlertTestPage': (context) => AlertTestPage(),
  'BottomSheetTest': (context) => BottomSheetTest(),
  // toast
  'ToastDemoListPage': (context) => ToastDemoListPage(),
  'ToastTestPage': (context) => ToastTestPage(),

  // chart
  'ChartDemoListPage': (context) => ChartDemoListPage(),
  'ChartPage1': (context) => ChartPage1(),
  'ChartPage2': (context) => ChartPage2(),
  'EChartPage1': (context) => EChartPage1(),
  // 'MpChartLinePage1': (context) => MpChartLinePage1(),

  // 表单
  'FormDemoListPage': (context) => FormDemoListPage(),
  'LoginTextFieldTestPage': (context) => LoginTextFieldTestPage(),
  'InputTextFieldTestPage': (context) => InputTextFieldTestPage(),
  'FormInputCellTestPage': (context) => FormInputCellTestPage(),
  'FormSelectCellTestPage': (context) => FormSelectCellTestPage(),
  'SetCellTestPage': (context) => SetCellTestPage(),
  'FormTestPage': (context) => FormTestPage(),

  // GridView
  'GridViewDemoListPage': (context) => GridViewDemoListPage(),
  'GridViewTest1': (context) => GridViewTest1(),
  'GridViewTest2': (context) => GridViewTest2(),
  'GridViewTest3': (context) => GridViewTest3(),
  'GridViewTest4': (context) => GridViewTest4(),
  'GridViewTestPage5': (context) => GridViewTestPage5(),

  // http
  'HttpDemoListPage': (context) => HttpDemoListPage(),
  'HttpTest1Page': (context) => HttpTest1Page(),
  'HttpPageTestPage': (context) => HttpPageTestPage(),

  // ListView
  'ListViewDemoListPage': (context) => ListViewDemoListPage(),
  'ListViewTest': (context) => ListViewTest(),
  'ListViewTest2': (context) => ListViewTest2(),
  'ListViewTest3': (context) => ListViewTest3(),
  'ListViewTest4': (context) => ListViewTest4(),
  'ListViewTest5': (context) => ListViewTest5(),
  'ListViewTestCard': (context) => ListViewTestCard(),
  'ListViewTestCustomVC': (context) => ListViewTestCustomVC(),
  'ListViewTestSimplePullDown': (context) => ListViewTestSimplePullDown(),
  'ListViewTestPullDownVC': (context) => ListViewTestPullDownVC(),

  // other
  'FormTest': (context) => FormTest(),
  'PhotoSelectTest': (context) => PhotoSelectTest(),
  'PassValuePage': (context) => PassValuePage(),
//  'PassValuePage2': (context) => PassValuePage2(),
  'NavTestPage': (context) => NavTestPage(),
  'RedDotPage': (context) => RedDotPage(),
  'QRCodeTest': (context) => QRCodeTest(),

  // search
  'SearchDemoListPage': (context) => SearchDemoListPage(),
  'SearchTest1Page': (context) => SearchTest1Page(),
  'SearchTest2Page': (context) => SearchTest2Page(),
  'SearchTest3Page': (context) => SearchTest3Page(),

  // TopTabBarDemoListPage
  'TopTabBarDemoListPage': (context) => TopTabBarDemoListPage(),
  'TopTabBarTest1Page': (context) => TopTabBarTest1Page(),
  'TopTabBarTest2Page': (context) => TopTabBarTest2Page(),
  'TopTabBarTest3Page': (context) => TopTabBarTest3Page(),

  // ui
  'UIDemoListPage': (context) => UIDemoListPage(),
  'UIPage': (context) => UIPage(),
  'UIPage2': (context) => UIPage2(),
};

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跳转错误'),
        centerTitle: true,
      ),
    );
  }
}

//// 配置路由命名信息
//final routes = {
////  home: (context) => Home(),
////  secondPage: (context) => Second(),
////  threePage: (context) => Three(),
////  fourPage: (context) => four(),
//};
//
//class UnknownPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('跳转错误'),
//        centerTitle: true,
//      ),
//    );
//  }
//}
