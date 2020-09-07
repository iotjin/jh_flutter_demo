import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/project/login/pages/login_page.dart';
import 'package:jh_flutter_demo/project/login/pages/register_page.dart';
import 'package:jh_flutter_demo/project/login/pages/find_pwd_page.dart';
import 'package:jh_flutter_demo/project/login/pages/code_login_page.dart';

import 'package:jh_flutter_demo/project/one/one_page.dart';
import 'package:jh_flutter_demo/project/two/two_page.dart';
import 'package:jh_flutter_demo/project/three/three_page.dart';

//four
import 'package:jh_flutter_demo/project/four/four_page.dart';
import 'package:jh_flutter_demo/project/four/pages/set_page.dart';
import 'package:jh_flutter_demo/project/four/pages/info_page.dart';
import 'package:jh_flutter_demo/project/four/pages/about_page.dart';
import 'package:jh_flutter_demo/project/four/pages/about_ios_page.dart';

import 'package:jh_flutter_demo/demos/demo_lists_page.dart';


//alert
import 'package:jh_flutter_demo/demos/Alert/alert_demo_lists_page.dart';
import '../../demos/alert/bottom_sheet_test.dart';
import '../../demos/alert/alert_test.dart';
//toast
import 'package:jh_flutter_demo/demos/alert/toast/toast_demo_lists_page.dart';
import 'package:jh_flutter_demo/demos/alert/toast/toast_test.dart';

//chart
import 'package:jh_flutter_demo/demos/chart/chart_demo_list_page.dart';
import 'package:jh_flutter_demo/demos/chart/chart_page1.dart';
import 'package:jh_flutter_demo/demos/chart/chart_page2.dart';
import 'package:jh_flutter_demo/demos/chart/eChart_page1.dart';
import 'package:jh_flutter_demo/demos/chart/mpChart_line_page1.dart';


//表单
import 'package:jh_flutter_demo/demos/form/form_demo_lists_page.dart';
import 'package:jh_flutter_demo/demos/form/login_textfeld_test_page.dart';
import 'package:jh_flutter_demo/demos/form/input_textfield_test_page.dart';
import 'package:jh_flutter_demo/demos/form/form_Input_cell_test_page.dart';
import 'package:jh_flutter_demo/demos/form/form_select_cell_test_page.dart';
import 'package:jh_flutter_demo/demos/form/set_cell_test_page.dart';
import 'package:jh_flutter_demo/demos/form/form_test_page.dart';

//gridView
import 'package:jh_flutter_demo/demos/gridView/gridview_demo_lists_page.dart';
import '../../demos/gridView/gridview_test1.dart';
import '../../demos/gridView/gridview_test2.dart';
import '../../demos/gridView/gridview_test3.dart';
import '../../demos/gridView/gridview_test4.dart';
import '../../demos/gridView/gridview_test5.dart';

//http
import 'package:jh_flutter_demo/demos/http/http_demo_lists_page.dart';
import 'package:jh_flutter_demo/demos/http/http_test1_page.dart';
import 'package:jh_flutter_demo/demos/http/http_page_test_page.dart';

//ListView
import 'package:jh_flutter_demo/demos/listView/listview_demo_lists_page.dart';
import '../../demos/listView/listview_test.dart';
import '../../demos/listView/listview_test2.dart';
import '../../demos/listView/listview_test3.dart';
import '../../demos/listView/listview_test4.dart';
import '../../demos/listView/listview_test5.dart';
import '../../demos/listView/listview_test_card.dart';
import '../../demos/listView/listview_test_custom_vc.dart';
import '../../demos/listView/listview_test_simple_pull_down.dart';
import '../../demos/listView/listview_test_pull_down_vc.dart';

//other
import 'package:jh_flutter_demo/demos/other/form_test.dart';
import 'package:jh_flutter_demo/demos/other/photo_select_test.dart';
import '../../demos/other/pass_value_page.dart';
import '../../demos/other/pass_value_page2.dart';
import '../../demos/other/nav_test.dart';
import '../../demos/other/red_dot_page.dart';
import '../../demos/other/qr_code_test.dart';

//search
import 'package:jh_flutter_demo/demos/search/search_demo_list_page.dart';
import 'package:jh_flutter_demo/demos/search/search_test1_page.dart';
import 'package:jh_flutter_demo/demos/search/search_test2_page.dart';
import 'package:jh_flutter_demo/demos/search/search_test3_page.dart';

//TopTabBar
import 'package:jh_flutter_demo/demos/topTabBar/top_tabbar_demo_list_page.dart';
import '../../demos/topTabBar/top_tabbar_test1_page.dart';
import '../../demos/topTabBar/top_tabbar_test2_page.dart';
import '../../demos/topTabBar/top_tabbar_test3_page.dart';

import 'package:jh_flutter_demo/demos/ui/ui_demo_lists.dart';
import 'package:jh_flutter_demo/demos/ui/ui_page.dart';
import 'package:jh_flutter_demo/demos/ui/ui_page2.dart';


final String home = '/';

final String loginPage = 'LoginPage';
final String onePage = '/onePage';
final String twoPage = '/twoPage';
final String threePage = '/threePage';
final String fourPage = '/fourPage';

final String demoListsPage = 'DemoListsPage';




// 配置路由命名信息
final routes = {
  loginPage: (context) => LoginPage(),
  "RegisterPage": (context) => RegisterPage(),
  "FindPwdPage": (context) => FindPwdPage(),
  "CodeLoginPage": (context) => CodeLoginPage(),


  onePage: (context) => OnePage(),
  twoPage: (context) => TwoPage(),
  threePage: (context) => ThreePage(),

  //four
  fourPage: (context) => FourPage(),
  "SetPage": (context) => SetPage(),
  "InfoPage": (context) => InfoPage(),
  "AboutPage": (context) => AboutPage(),
  "AboutIOSPage": (context) => AboutIOSPage(),

  demoListsPage: (context) => DemoListsPage(),


  //Alert
  "AlertDemoListsPage": (context) => AlertDemoListsPage(),
      "AlertTestPage": (context) => AlertTestPage(),
      "BottomSheetTest": (context) => BottomSheetTest(),
      //toast
      "ToastDemoListsPage": (context) => ToastDemoListsPage(),
      "ToastTestPage": (context) => ToastTestPage(),

  //chart
  "ChartDemoListPage": (context) => ChartDemoListPage(),
  "ChartPage1": (context) => ChartPage1(),
  "ChartPage2": (context) => ChartPage2(),
  "EChartPage1": (context) => EChartPage1(),
  "MpChartLinePage1": (context) => MpChartLinePage1(),



  //表单
  "FormDemoListsPage": (context) => FormDemoListsPage(),
      "LoginTextFieldTestPage": (context) => LoginTextFieldTestPage(),
      "InputTextFieldTestPage": (context) => InputTextFieldTestPage(),
      "FormInputCellTestPage": (context) => FormInputCellTestPage(),
      "FormSelectCellTestPage": (context) => FormSelectCellTestPage(),
      "SetCellTestPage": (context) => SetCellTestPage(),
      "FormTestPage": (context) => FormTestPage(),

  //GridView
  "GridViewDemoListsPage": (context) => GridViewDemoListsPage(),
      "GridViewTest1": (context) => GridViewTest1(),
      "GridViewTest2": (context) => GridViewTest2(),
      "GridViewTest3": (context) => GridViewTest3(),
      "GridViewTest4": (context) => GridViewTest4(),
      "GridViewTestPage5": (context) => GridViewTestPage5(),

  //http
  "HttpDemoListsPage": (context) => HttpDemoListsPage(),
      "HttpTest1Page": (context) => HttpTest1Page(),
      "HttpPageTestPage": (context) => HttpPageTestPage(),

  //ListView
  "ListViewDemoListsPage": (context) => ListViewDemoListsPage(),
      "ListViewTest": (context) => ListViewTest(),
      "ListViewTest2": (context) => ListViewTest2(),
      "ListViewTest3": (context) => ListViewTest3(),
      "ListViewTest4": (context) => ListViewTest4(),
      "ListViewTest5": (context) => ListViewTest5(),
      "ListViewTest_Card": (context) => ListViewTest_Card(),
      "ListViewTest_CustomVC": (context) => ListViewTest_CustomVC(),
      "ListViewTest_SimplePullDown": (context) => ListViewTest_SimplePullDown(),
      "ListViewTest_PullDownVC": (context) => ListViewTest_PullDownVC(),

  //other
  "FormTest": (context) => FormTest(),
  "PhotoSelectTest": (context) => PhotoSelectTest(),
  "PassValuePage": (context) => PassValuePage(),
//  "PassValuePage2": (context) => PassValuePage2(),
  "NavTestPage": (context) => NavTestPage(),
  "RedDotPage": (context) => RedDotPage(),
  "QRCodeTest": (context) => QRCodeTest(),

  //search
  "SearchDemoListPage": (context) => SearchDemoListPage(),
  "SearchTest1Page": (context) => SearchTest1Page(),
  "SearchTest2Page": (context) => SearchTest2Page(),
  "SearchTest3Page": (context) => SearchTest3Page(),

   //TopTabBarDemoListPage
  "TopTabBarDemoListPage": (context) => TopTabBarDemoListPage(),
        "TopTabBarTest1Page": (context) => TopTabBarTest1Page(),
        "TopTabBarTest2Page": (context) => TopTabBarTest2Page(),
        "TopTabBarTest3Page": (context) => TopTabBarTest3Page(),


  //ui
  "UIDemoListsPage": (context) => UIDemoListsPage(),
        "UIPage": (context) => UIPage(),
        "UIPage2": (context) => UIPage2(),


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
