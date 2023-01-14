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
import '../../demos/chart/echarts/echart_page1.dart';
import '/demos/chart/mp_chart_line_page1.dart';

// 表单
import '/demos/form/form_demo_list_page.dart';
import '/demos/form/login_text_field_test_page.dart';
import '/demos/form/input_text_field_test_page.dart';
import '/demos/form/form_input_cell_test_page.dart';
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

const String home = '/';

const String loginPage = 'LoginPage';
const String onePage = '/onePage';
const String twoPage = '/twoPage';
const String threePage = '/threePage';
const String fourPage = '/fourPage';

const String demoListPage = 'DemoListPage';

// 配置路由命名信息
final routes = {
  loginPage: (context) => const LoginPage(),
  'RegisterPage': (context) => const RegisterPage(),
  'FindPwdPage': (context) => const FindPwdPage(),
  'CodeLoginPage': (context) => const CodeLoginPage(),

  onePage: (context) => const OnePage(),
  twoPage: (context) => const TwoPage(),
  threePage: (context) => const ThreePage(),

  // four
  fourPage: (context) => const FourPage(),
  'SetPage': (context) => const SetPage(),
  'InfoPage': (context) => const InfoPage(),
  'AboutPage': (context) => const AboutPage(),
  'AboutIOSPage': (context) => const AboutIOSPage(),

  demoListPage: (context) => const DemoListPage(),

  // Alert
  'AlertDemoListPage': (context) => const AlertDemoListPage(),
  'AlertTestPage': (context) => const AlertTestPage(),
  'BottomSheetTest': (context) => const BottomSheetTest(),
  // toast
  'ToastDemoListPage': (context) => const ToastDemoListPage(),
  'ToastTestPage': (context) => const ToastTestPage(),

  // chart
  'ChartDemoListPage': (context) => const ChartDemoListPage(),
  'ChartPage1': (context) => const ChartPage1(),
  'ChartPage2': (context) => const ChartPage2(),
  'EChartPage1': (context) => const EChartPage1(),
  // 'MpChartLinePage1': (context) => MpChartLinePage1(),

  // 表单
  'FormDemoListPage': (context) => const FormDemoListPage(),
  'LoginTextFieldTestPage': (context) => const LoginTextFieldTestPage(),
  'InputTextFieldTestPage': (context) => const InputTextFieldTestPage(),
  'FormInputCellTestPage': (context) => const FormInputCellTestPage(),
  'FormSelectCellTestPage': (context) => const FormSelectCellTestPage(),
  'SetCellTestPage': (context) => const SetCellTestPage(),
  'FormTestPage': (context) => const FormTestPage(),

  // GridView
  'GridViewDemoListPage': (context) => const GridViewDemoListPage(),
  'GridViewTest1': (context) => const GridViewTest1(),
  'GridViewTest2': (context) => const GridViewTest2(),
  'GridViewTest3': (context) => const GridViewTest3(),
  'GridViewTest4': (context) => const GridViewTest4(),
  'GridViewTestPage5': (context) => const GridViewTestPage5(),

  // http
  'HttpDemoListPage': (context) => const HttpDemoListPage(),
  'HttpTest1Page': (context) => const HttpTest1Page(),
  'HttpPageTestPage': (context) => const HttpPageTestPage(),

  // ListView
  'ListViewDemoListPage': (context) => const ListViewDemoListPage(),
  'ListViewTest': (context) => const ListViewTest(),
  'ListViewTest2': (context) => const ListViewTest2(),
  'ListViewTest3': (context) => const ListViewTest3(),
  'ListViewTest4': (context) => const ListViewTest4(),
  'ListViewTest5': (context) => const ListViewTest5(),
  'ListViewTestCard': (context) => const ListViewTestCard(),
  'ListViewTestCustomVC': (context) => const ListViewTestCustomVC(),
  'ListViewTestPullDownVC': (context) => const ListViewTestPullDownVC(),

  // other
  'FormTest': (context) => const FormTest(),
  'PhotoSelectTest': (context) => const PhotoSelectTest(),
  'PassValuePage': (context) => const PassValuePage(),
//  'PassValuePage2': (context) => PassValuePage2(),
  'NavTestPage': (context) => const NavTestPage(),
  'RedDotPage': (context) => const RedDotPage(),
  'QRCodeTest': (context) => const QRCodeTest(),

  // search
  'SearchDemoListPage': (context) => const SearchDemoListPage(),
  'SearchTest1Page': (context) => const SearchTest1Page(),
  'SearchTest2Page': (context) => const SearchTest2Page(),
  'SearchTest3Page': (context) => const SearchTest3Page(),

  // TopTabBarDemoListPage
  'TopTabBarDemoListPage': (context) => const TopTabBarDemoListPage(),
  'TopTabBarTest1Page': (context) => const TopTabBarTest1Page(),
  'TopTabBarTest2Page': (context) => const TopTabBarTest2Page(),
  'TopTabBarTest3Page': (context) => const TopTabBarTest3Page(),

  // ui
  'UIDemoListPage': (context) => const UIDemoListPage(),
  'UIPage': (context) => const UIPage(),
  'UIPage2': (context) => const UIPage2(),
};

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('跳转错误'),
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
