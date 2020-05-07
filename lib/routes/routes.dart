import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/login/login_page.dart';
import 'package:jh_flutter_demo/login/register_page.dart';
import 'package:jh_flutter_demo/login/findPwd_page.dart';
import 'package:jh_flutter_demo/login/codeLogin_page.dart';

import 'package:jh_flutter_demo/one/one_page.dart';
import 'package:jh_flutter_demo/two/two_page.dart';
import 'package:jh_flutter_demo/three/three_page.dart';

//four
import 'package:jh_flutter_demo/four/four_page.dart';
import 'package:jh_flutter_demo/four/set_page.dart';
import 'package:jh_flutter_demo/four/info_page.dart';
import 'package:jh_flutter_demo/four/about_page.dart';
import 'package:jh_flutter_demo/four/about_ios_page.dart';
import 'package:jh_flutter_demo/four/mine_page.dart';

import 'package:jh_flutter_demo/demoLists/demoLists_page.dart';


//alert
import 'package:jh_flutter_demo/demoLists/Alert/alertdemoLists_page.dart';
import '../demoLists/alert/bottomSheetTest.dart';
import '../demoLists/alert/alertTest.dart';
//toast
import 'package:jh_flutter_demo/demoLists/alert/toast/toastDemoLists_page.dart';
import 'package:jh_flutter_demo/demoLists/alert/toast/ToastTest.dart';

//chart
import 'package:jh_flutter_demo/demoLists/chart/chartDemoList_page.dart';
import 'package:jh_flutter_demo/demoLists/chart/chart_page1.dart';
import 'package:jh_flutter_demo/demoLists/chart/chart_page2.dart';


//表单
import 'package:jh_flutter_demo/demoLists/form/formDemoLists_page.dart';
import 'package:jh_flutter_demo/demoLists/form/loginTextFeldTest_page.dart';
import 'package:jh_flutter_demo/demoLists/form/inputTextFieldTest_page.dart';
import 'package:jh_flutter_demo/demoLists/form/formInputCellTest_page.dart';
import 'package:jh_flutter_demo/demoLists/form/formSelectCellTest_page.dart';
import 'package:jh_flutter_demo/demoLists/form/setCellTest_page.dart';
import 'package:jh_flutter_demo/demoLists/form/formTest_page.dart';

//gridView
import 'package:jh_flutter_demo/demoLists/gridView/gridViewdemoLists_page.dart';
import '../demoLists/gridView/gridViewTest1.dart';
import '../demoLists/gridView/gridViewTest2.dart';
import '../demoLists/gridView/gridViewTest3.dart';
import '../demoLists/gridView/gridViewTest4.dart';
import '../demoLists/gridView/gridViewTest5.dart';

//http
import 'package:jh_flutter_demo/demoLists/http/httpdemoLists_page.dart';
import 'package:jh_flutter_demo/demoLists/http/httpTest1_page.dart';
import 'package:jh_flutter_demo/demoLists/http/httppagetest_page.dart';

//ListView
import 'package:jh_flutter_demo/demoLists/listView/ListViewdemoLists_page.dart';
import '../demoLists/listView/ListViewTest.dart';
import '../demoLists/listView/ListViewTest2.dart';
import '../demoLists/listView/ListViewTest3.dart';
import '../demoLists/listView/ListViewTest4.dart';
import '../demoLists/listView/ListViewTest5.dart';
import '../demoLists/listView/ListViewTest_Card.dart';
import '../demoLists/listView/ListViewTest_CustomVC.dart';
import '../demoLists/listView/ListViewTest_SimplePullDown.dart';
import '../demoLists/listView/ListViewTest_PullDownVC.dart';

//other
import 'package:jh_flutter_demo/demoLists/other/formTest.dart';
import 'package:jh_flutter_demo/demoLists/other/photoSelectTest.dart';
import '../demoLists/other/passValue_page.dart';
import '../demoLists/other/passValue_page2.dart';
import '../demoLists/other/navTest.dart';

//search
import 'package:jh_flutter_demo/demoLists/search/searchDemoList_page.dart';
import 'package:jh_flutter_demo/demoLists/search/searchTest1_page.dart';
import 'package:jh_flutter_demo/demoLists/search/searchTest2_page.dart';
import 'package:jh_flutter_demo/demoLists/search/searchTest3_page.dart';

//TopTabBar
import 'package:jh_flutter_demo/demoLists/topTabBar/topTabBarDemoList_page.dart';
import '../demoLists/topTabBar/topTabBarTest1_page.dart';
import '../demoLists/topTabBar/topTabBarTest2_page.dart';

import 'package:jh_flutter_demo/demoLists/ui/uidemoLists.dart';
import 'package:jh_flutter_demo/demoLists/ui/ui_page.dart';
import 'package:jh_flutter_demo/demoLists/ui/ui_page2.dart';


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
  "MinePage": (context) => MinePage(),

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
  "PassValuePage2": (context) => PassValuePage2(),
  "NavTestPage": (context) => NavTestPage(),

  //search
  "SearchDemoListPage": (context) => SearchDemoListPage(),
  "SearchTest1Page": (context) => SearchTest1Page(),
  "SearchTest2Page": (context) => SearchTest2Page(),
  "SearchTest3Page": (context) => SearchTest3Page(),

   //TopTabBarDemoListPage
  "TopTabBarDemoListPage": (context) => TopTabBarDemoListPage(),
        "TopTabBarTest1Page": (context) => TopTabBarTest1Page(),
        "TopTabBarTest2Page": (context) => TopTabBarTest2Page(),


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
