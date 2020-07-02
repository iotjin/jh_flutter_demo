import 'package:fluro/fluro.dart';
import 'demo_lists_page.dart';
import 'package:jh_flutter_demo/project/routes/router_init.dart';

//alert
import 'Alert/alert_demo_lists_page.dart';
import 'alert/bottom_sheet_test.dart';
import 'alert/alert_test.dart';
//toast
import 'alert/toast/toast_demo_lists_page.dart';
import 'alert/toast/toast_test.dart';

//chart
import 'chart/chart_demo_list_page.dart';
import 'chart/chart_page1.dart';
import 'chart/chart_page2.dart';
import 'chart/eChart_page1.dart';
import 'chart/mpChart_line_page1.dart';


//表单
import 'form/form_demo_lists_page.dart';
import 'form/login_textfeld_test_page.dart';
import 'form/input_textfield_test_page.dart';
import 'form/form_Input_cell_test_page.dart';
import 'form/form_select_cell_test_page.dart';
import 'form/set_cell_test_page.dart';
import 'form/form_test_page.dart';

//gridView
import 'gridView/gridview_demo_lists_page.dart';
import 'gridView/gridview_test1.dart';
import 'gridView/gridview_test2.dart';
import 'gridView/gridview_test3.dart';
import 'gridView/gridview_test4.dart';
import 'gridView/gridview_test5.dart';

//http
import 'http/http_demo_lists_page.dart';
import 'http/http_test1_page.dart';
import 'http/http_page_test_page.dart';

//ListView
import 'listView/listview_demo_lists_page.dart';
import 'listView/listview_test.dart';
import 'listView/listview_test2.dart';
import 'listView/listview_test3.dart';
import 'listView/listview_test4.dart';
import 'listView/listview_test5.dart';
import 'listView/listview_test_card.dart';
import 'listView/listview_test_custom_vc.dart';
import 'listView/listview_test_simple_pull_down.dart';
import 'listView/listview_test_pull_down_vc.dart';

//other
import 'other/form_test.dart';
import 'other/photo_select_test.dart';
import 'other/pass_value_page.dart';
import 'other/pass_value_page2.dart';
import 'other/nav_test.dart';
import 'other/red_dot_page.dart';
import 'other/qr_code_test.dart';

//search
import 'search/search_demo_list_page.dart';
import 'search/search_test1_page.dart';
import 'search/search_test2_page.dart';
import 'search/search_test3_page.dart';

//TopTabBar
import 'topTabBar/top_tabbar_demo_list_page.dart';
import 'topTabBar/top_tabbar_test1_page.dart';
import 'topTabBar/top_tabbar_test2_page.dart';
import 'topTabBar/top_tabbar_test3_page.dart';

import 'ui/ui_demo_lists.dart';
import 'ui/ui_page.dart';
import 'ui/ui_page2.dart';

class DemosRouter implements IRouterProvider{

  static String demoListsPage = 'DemoListsPage';

  @override
  void initRouter(Router router) {


    router.define(demoListsPage, handler: Handler(handlerFunc: (_, __) => DemoListsPage()));
    //Alert
    router.define("AlertDemoListsPage", handler: Handler(handlerFunc: (_, __) => AlertDemoListsPage()));
    router.define("AlertTestPage", handler: Handler(handlerFunc: (_, __) => AlertTestPage()));
    router.define("BottomSheetTest", handler: Handler(handlerFunc: (_, __) => BottomSheetTest()));
    //toast
    router.define("ToastDemoListsPage", handler: Handler(handlerFunc: (_, __) => ToastDemoListsPage()));
    router.define("ToastTestPage", handler: Handler(handlerFunc: (_, __) => ToastTestPage()));
    //chart
    router.define("ChartDemoListPage", handler: Handler(handlerFunc: (_, __) => ChartDemoListPage()));
    router.define("ChartPage1", handler: Handler(handlerFunc: (_, __) => ChartPage1()));
    router.define("ChartPage2", handler: Handler(handlerFunc: (_, __) => ChartPage2()));
    router.define("EChartPage1", handler: Handler(handlerFunc: (_, __) => EChartPage1()));
    router.define("MpChartLinePage1", handler: Handler(handlerFunc: (_, __) => MpChartLinePage1()));
    //表单
    router.define("FormDemoListsPage", handler: Handler(handlerFunc: (_, __) => FormDemoListsPage()));
    router.define("LoginTextFieldTestPage", handler: Handler(handlerFunc: (_, __) => LoginTextFieldTestPage()));
    router.define("InputTextFieldTestPage", handler: Handler(handlerFunc: (_, __) => InputTextFieldTestPage()));
    router.define("FormInputCellTestPage", handler: Handler(handlerFunc: (_, __) => FormInputCellTestPage()));
    router.define("FormSelectCellTestPage", handler: Handler(handlerFunc: (_, __) => FormSelectCellTestPage()));
    router.define("SetCellTestPage", handler: Handler(handlerFunc: (_, __) => SetCellTestPage()));
    router.define("FormTestPage", handler: Handler(handlerFunc: (_, __) => FormTestPage()));
    //GridView
    router.define("GridViewDemoListsPage", handler: Handler(handlerFunc: (_, __) => GridViewDemoListsPage()));
    router.define("GridViewTest1", handler: Handler(handlerFunc: (_, __) => GridViewTest1()));
    router.define("GridViewTest2", handler: Handler(handlerFunc: (_, __) => GridViewTest2()));
    router.define("GridViewTest3", handler: Handler(handlerFunc: (_, __) => GridViewTest3()));
    router.define("GridViewTest4", handler: Handler(handlerFunc: (_, __) => GridViewTest4()));
    router.define("GridViewTestPage5", handler: Handler(handlerFunc: (_, __) => GridViewTestPage5()));
    //http
    router.define("HttpDemoListsPage", handler: Handler(handlerFunc: (_, __) => HttpDemoListsPage()));
    router.define("HttpTest1Page", handler: Handler(handlerFunc: (_, __) => HttpTest1Page()));
    router.define("HttpPageTestPage", handler: Handler(handlerFunc: (_, __) => HttpPageTestPage()));
    //ListView
    router.define("ListViewDemoListsPage", handler: Handler(handlerFunc: (_, __) => ListViewDemoListsPage()));
    router.define("ListViewTest", handler: Handler(handlerFunc: (_, __) => ListViewTest()));
    router.define("ListViewTest2", handler: Handler(handlerFunc: (_, __) => ListViewTest2()));
    router.define("ListViewTest3", handler: Handler(handlerFunc: (_, __) => ListViewTest3()));
    router.define("ListViewTest4", handler: Handler(handlerFunc: (_, __) => ListViewTest4()));
    router.define("ListViewTest5", handler: Handler(handlerFunc: (_, __) => ListViewTest5()));
    router.define("ListViewTest_Card", handler: Handler(handlerFunc: (_, __) => ListViewTest_Card()));
    router.define("ListViewTest_CustomVC", handler: Handler(handlerFunc: (_, __) => ListViewTest_CustomVC()));
    router.define("ListViewTest_SimplePullDown", handler: Handler(handlerFunc: (_, __) => ListViewTest_SimplePullDown()));
    router.define("ListViewTest_PullDownVC", handler: Handler(handlerFunc: (_, __) => ListViewTest_PullDownVC()));
    //other
    router.define("FormTest", handler: Handler(handlerFunc: (_, __) => FormTest()));
    router.define("PhotoSelectTest", handler: Handler(handlerFunc: (_, __) => PhotoSelectTest()));
    router.define("PassValuePage", handler: Handler(handlerFunc: (_, __) => PassValuePage()));
//    router.define("PassValuePage2", handler: Handler(handlerFunc: (_, __) => PassValuePage2()));

    router.define("PassValuePage2", handler: Handler(handlerFunc: (_, params) {
      print("---------params---------");
      print(params);
      final String passValue = params['passvalue']?.first;
      final bool isScan = params['isScan']?.first == 'true';
      return PassValuePage2(passValue);
    }));

    router.define("NavTestPage", handler: Handler(handlerFunc: (_, __) => NavTestPage()));
    router.define("RedDotPage", handler: Handler(handlerFunc: (_, __) => RedDotPage()));
    router.define("QRCodeTest", handler: Handler(handlerFunc: (_, __) => QRCodeTest()));
    //search
    router.define("SearchDemoListPage", handler: Handler(handlerFunc: (_, __) => SearchDemoListPage()));
    router.define("SearchTest1Page", handler: Handler(handlerFunc: (_, __) => SearchTest1Page()));
    router.define("SearchTest2Page", handler: Handler(handlerFunc: (_, __) => SearchTest2Page()));
    router.define("SearchTest3Page", handler: Handler(handlerFunc: (_, __) => SearchTest3Page()));
    //TopTabBarDemoListPage
    router.define("TopTabBarDemoListPage", handler: Handler(handlerFunc: (_, __) => TopTabBarDemoListPage()));
    router.define("TopTabBarTest1Page", handler: Handler(handlerFunc: (_, __) => TopTabBarTest1Page()));
    router.define("TopTabBarTest2Page", handler: Handler(handlerFunc: (_, __) => TopTabBarTest2Page()));
    router.define("TopTabBarTest3Page", handler: Handler(handlerFunc: (_, __) => TopTabBarTest3Page()));
    //ui
    router.define("UIDemoListsPage", handler: Handler(handlerFunc: (_, __) => UIDemoListsPage()));
    router.define("UIPage", handler: Handler(handlerFunc: (_, __) => UIPage()));
    router.define("UIPage2", handler: Handler(handlerFunc: (_, __) => UIPage2()));


  }

}

