// ignore_for_file: unused_import

import 'dart:convert';
import 'package:fluro/fluro.dart';
import '/project/routes/router_init.dart';
import 'demo_list_page.dart';

// base
import 'base/base_demo_list_page.dart';
import 'base/base_refresh_view_test_page.dart';
import 'base/base_listview_shimmer_test_page.dart';
import 'base/base_gridview_shimmer_test_page.dart';
import 'base/base_refresh_view_header_fixed_page.dart';
import 'base/base_refresh_view_header_follow_page.dart';
import 'base/nav_test.dart';
import 'base/empty_demo_list_page.dart';

// alert
import 'alert/alert_demo_list_page.dart';
import 'alert/bottom_sheet_test.dart';
import 'alert/alert_test.dart';
import 'alert/jhDialog_test_page.dart';
import 'alert/cascade_picker_test.dart';
import 'alert/cascade_tree_picker_test.dart';

// toast
import 'alert/toast/toast_demo_list_page.dart';
import 'alert/toast/toast_test.dart';

// chart
import 'chart/chart_demo_list_page.dart';
import 'chart/graphic/graphic_bar_page.dart';
import 'chart/graphic/graphic_line_page.dart';
import 'chart/graphic/graphic_pie_page.dart';
import 'chart/echarts/eChart_page1.dart';
import 'chart/echarts/eChart_page2.dart';
import 'chart/echarts/eChart_page3.dart';
import 'chart/echarts/eChart_page4.dart';
import 'chart/chart_page1.dart';
import 'chart/chart_page2.dart';
import 'chart/mpChart_line_page1.dart';
import 'chart/mpChart_bar_page1.dart';
import 'chart/mpChart_combined_page.dart';

// 表单
import 'form/form_demo_list_page.dart';
import 'form/login_text_field_test_page.dart';
import 'form/input_text_field_test_page.dart';
import 'form/form_Input_cell_test_page.dart';
import 'form/form_select_cell_test_page.dart';
import 'form/set_cell_test_page.dart';
import 'form/form_test_page.dart';
import 'form/form_validate_page.dart';

// gridView
import 'gridView/gridview_demo_list_page.dart';
import 'gridView/gridview_test1.dart';
import 'gridView/gridview_test2.dart';
import 'gridView/gridview_test3.dart';
import 'gridView/gridview_test4.dart';
import 'gridView/gridview_test5.dart';

// http
import 'http/http_demo_list_page.dart';
import 'http/http_test1_page.dart';
import 'http/http_page_test_page.dart';

// ListView
import 'listView/listview_demo_list_page.dart';
import 'listView/listview_test.dart';
import 'listView/listview_test2.dart';
import 'listView/listview_test3.dart';
import 'listView/listview_test4.dart';
import 'listView/listview_test5.dart';
import 'listView/listview_test_card.dart';
import 'listView/listview_test_custom_vc.dart';
import 'listView/listview_test_simple_pull_down.dart';
import 'listView/listview_test_pull_down_vc.dart';
import 'listView/listview_group_page.dart';
import 'listView/listview_group_page2.dart';
import 'listView/listview_group_page3.dart';
import 'listView/listview_header_page.dart';

// 路由
import 'route_test_page/route_demo_list_page.dart';
import 'route_test_page/pass_value_page.dart';
import 'route_test_page/pass_value_page2.dart';
import 'route_test_page/pass_value_page3.dart';
import 'route_test_page/route_test_page1.dart';
import 'route_test_page/route_test_page2.dart';

// 拖拽排序
import 'dragSort/drag_sort_demo_list_page.dart';
import 'dragSort/gridview_drag_sort_page.dart';
import 'dragSort/listview_drag_sort_page.dart';
import 'dragSort/listview_drag_sort_page2.dart';

// other
import 'other/animation/animation_demo_list_page.dart';
import 'other/animation/3DBall_page.dart';
import 'other/animation/3DBall_page2.dart';
import 'other/animation/3DBall_page3.dart';
import 'other/animation/3DBall_page4.dart';
import 'other/animation/tag_cloud_page.dart';
import 'other/form_test.dart';
import 'other/photo_select_test.dart';
import 'other/red_dot_page.dart';
import 'other/qr_code_test.dart';
import 'other/aes_test_page.dart';
import 'other/sideslip_test_page.dart';
import 'other/city_select_list_page.dart';
import 'other/device_info_test.dart';

// search
import 'search/search_demo_list_page.dart';
import 'search/search_test1_page.dart';
import 'search/search_test2_page.dart';
import 'search/search_test3_page.dart';
import 'search/search_test4_page.dart';

// swiper
import 'swiper/swiper_demo_list_page.dart';
import 'swiper/swiper_test1_page.dart';
import 'swiper/swiper_test2_page.dart';
import 'swiper/swiper_test3_page.dart';
import 'swiper/swiper_test4_page.dart';
import '/project/new_feature/new_feature_page.dart';
import '/project/new_feature/full_screen_swiper_widget.dart';

// TopTabBar
import 'topTabBar/top_tabbar_demo_list_page.dart';
import 'topTabBar/top_tabbar_test1_page.dart';
import 'topTabBar/top_tabbar_test2_page.dart';
import 'topTabBar/top_tabbar_test3_page.dart';

import 'ui/ui_demo_list_page.dart';
import 'ui/ui_page.dart';
import 'ui/ui_page2.dart';
import 'ui/scroll_page.dart';
import 'ui/grammar_test_page.dart';

class DemosRouter implements IRouterProvider {
  static String pDemoListPage = 'DemoListPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pDemoListPage, handler: Handler(handlerFunc: (_, __) => DemoListPage()));
    // base
    router.define('BaseDemoListPage', handler: Handler(handlerFunc: (_, __) => BaseDemoListPage()));
    router.define('BaseRefreshViewTestPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return BaseRefreshViewTestPage(jsonDecode(jumpParams));
    }));
    router.define('BaseListViewShimmerTestPage',
        handler: Handler(handlerFunc: (_, __) => BaseListViewShimmerTestPage()));
    router.define('BaseGridViewShimmerTestPage',
        handler: Handler(handlerFunc: (_, __) => BaseGridViewShimmerTestPage()));
    router.define('BaseRefreshViewHeaderFixedPage',
        handler: Handler(handlerFunc: (_, __) => BaseRefreshViewHeaderFixedPage()));
    router.define('BaseRefreshViewHeaderFollowPage',
        handler: Handler(handlerFunc: (_, __) => BaseRefreshViewHeaderFollowPage()));
    router.define('NavTestPage', handler: Handler(handlerFunc: (_, __) => NavTestPage()));
    router.define('EmptyDemoListPage', handler: Handler(handlerFunc: (_, __) => EmptyDemoListPage()));

    // Alert
    router.define('AlertDemoListPage', handler: Handler(handlerFunc: (_, __) => AlertDemoListPage()));
    router.define('AlertTestPage', handler: Handler(handlerFunc: (_, __) => AlertTestPage()));
    router.define('BottomSheetTest', handler: Handler(handlerFunc: (_, __) => BottomSheetTest()));
    router.define('JhDialogTestPage', handler: Handler(handlerFunc: (_, __) => JhDialogTestPage()));
    router.define('CascadePickerTest', handler: Handler(handlerFunc: (_, __) => CascadePickerTest()));
    router.define('CascadeTreePickerTest', handler: Handler(handlerFunc: (_, __) => CascadeTreePickerTest()));

    // toast
    router.define('ToastDemoListPage', handler: Handler(handlerFunc: (_, __) => ToastDemoListPage()));
    router.define('ToastTestPage', handler: Handler(handlerFunc: (_, __) => ToastTestPage()));
    // chart
    router.define('ChartDemoListPage', handler: Handler(handlerFunc: (_, __) => ChartDemoListPage()));
    router.define('ChartPage1', handler: Handler(handlerFunc: (_, __) => ChartPage1()));
    router.define('ChartPage2', handler: Handler(handlerFunc: (_, __) => ChartPage2()));
    router.define('EChartPage1', handler: Handler(handlerFunc: (_, __) => EChartPage1()));
    router.define('EChartPage2', handler: Handler(handlerFunc: (_, __) => EChartPage2()));
    router.define('EChartPage3', handler: Handler(handlerFunc: (_, __) => EChartPage3()));
    router.define('EChartPage4', handler: Handler(handlerFunc: (_, __) => EChartPage4()));
    router.define('GraphicBarPage', handler: Handler(handlerFunc: (_, __) => GraphicBarPage()));
    router.define('GraphicLinePage', handler: Handler(handlerFunc: (_, __) => GraphicLinePage()));
    router.define('GraphicPiePage', handler: Handler(handlerFunc: (_, __) => GraphicPiePage()));
    // router.define('MpChartLinePage1', handler: Handler(handlerFunc: (_, __) => MpChartLinePage1()));
    // router.define('MpChartBarPage1', handler: Handler(handlerFunc: (_, __) => MpChartBarPage1()));
    // router.define('MpChartCombinedPage', handler: Handler(handlerFunc: (_, __) => MpChartCombinedPage()));
    // 表单
    router.define('FormDemoListPage', handler: Handler(handlerFunc: (_, __) => FormDemoListPage()));
    router.define('LoginTextFieldTestPage', handler: Handler(handlerFunc: (_, __) => LoginTextFieldTestPage()));
    router.define('InputTextFieldTestPage', handler: Handler(handlerFunc: (_, __) => InputTextFieldTestPage()));
    router.define('FormInputCellTestPage', handler: Handler(handlerFunc: (_, __) => FormInputCellTestPage()));
    router.define('FormSelectCellTestPage', handler: Handler(handlerFunc: (_, __) => FormSelectCellTestPage()));
    router.define('SetCellTestPage', handler: Handler(handlerFunc: (_, __) => SetCellTestPage()));
    router.define('FormTestPage', handler: Handler(handlerFunc: (_, __) => FormTestPage()));
    router.define('FormValidatePage', handler: Handler(handlerFunc: (_, __) => FormValidatePage()));

    // GridView
    router.define('GridViewDemoListPage', handler: Handler(handlerFunc: (_, __) => GridViewDemoListPage()));
    router.define('GridViewTest1', handler: Handler(handlerFunc: (_, __) => GridViewTest1()));
    router.define('GridViewTest2', handler: Handler(handlerFunc: (_, __) => GridViewTest2()));
    router.define('GridViewTest3', handler: Handler(handlerFunc: (_, __) => GridViewTest3()));
    router.define('GridViewTest4', handler: Handler(handlerFunc: (_, __) => GridViewTest4()));
    router.define('GridViewTestPage5', handler: Handler(handlerFunc: (_, __) => GridViewTestPage5()));
    // http
    router.define('HttpDemoListPage', handler: Handler(handlerFunc: (_, __) => HttpDemoListPage()));
    router.define('HttpTest1Page', handler: Handler(handlerFunc: (_, __) => HttpTest1Page()));
    router.define('HttpPageTestPage', handler: Handler(handlerFunc: (_, __) => HttpPageTestPage()));
    // ListView
    router.define('ListViewDemoListPage', handler: Handler(handlerFunc: (_, __) => ListViewDemoListPage()));
    router.define('ListViewTest', handler: Handler(handlerFunc: (_, __) => ListViewTest()));
    router.define('ListViewTest2', handler: Handler(handlerFunc: (_, __) => ListViewTest2()));
    router.define('ListViewTest3', handler: Handler(handlerFunc: (_, __) => ListViewTest3()));
    router.define('ListViewTest4', handler: Handler(handlerFunc: (_, __) => ListViewTest4()));
    router.define('ListViewTest5', handler: Handler(handlerFunc: (_, __) => ListViewTest5()));
    router.define('ListViewTestCard', handler: Handler(handlerFunc: (_, __) => ListViewTestCard()));
    router.define('ListViewTestCustomVC', handler: Handler(handlerFunc: (_, __) => ListViewTestCustomVC()));
    router.define('ListViewTestSimplePullDown', handler: Handler(handlerFunc: (_, __) => ListViewTestSimplePullDown()));
    router.define('ListViewTestPullDownVC', handler: Handler(handlerFunc: (_, __) => ListViewTestPullDownVC()));
    router.define('ListViewGroupPage', handler: Handler(handlerFunc: (_, __) => ListViewGroupPage()));
    router.define('ListViewGroupPage2', handler: Handler(handlerFunc: (_, __) => ListViewGroupPage2()));
    router.define('ListViewGroupPage3', handler: Handler(handlerFunc: (_, __) => ListViewGroupPage3()));
    router.define('ListViewHeaderPage', handler: Handler(handlerFunc: (_, __) => ListViewHeaderPage()));

    // 路由
    router.define('RouteDemoListPage', handler: Handler(handlerFunc: (_, __) => RouteDemoListPage()));
    router.define('PassValuePage', handler: Handler(handlerFunc: (_, __) => PassValuePage()));
    router.define('PassValuePage2', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return PassValuePage2(jsonDecode(jumpParams));
    }));
    router.define('PassValuePage3', handler: Handler(handlerFunc: (_, __) => PassValuePage3()));
    router.define('RouteTestPage1', handler: Handler(handlerFunc: (_, __) => RouteTestPage1()));
    router.define('RouteTestPage2', handler: Handler(handlerFunc: (_, __) => RouteTestPage2()));

    // 拖拽排序
    router.define('DragSortDemoListPage', handler: Handler(handlerFunc: (_, __) => DragSortDemoListPage()));
    router.define('ListviewDragSortPage', handler: Handler(handlerFunc: (_, __) => ListviewDragSortPage()));
    router.define('ListviewDragSortPage2', handler: Handler(handlerFunc: (_, __) => ListviewDragSortPage2()));
    router.define('GridviewDragSortPage', handler: Handler(handlerFunc: (_, __) => GridviewDragSortPage()));

    // other
    router.define('AnimationDemoListPage', handler: Handler(handlerFunc: (_, __) => AnimationDemoListPage()));
    router.define('AESTestPage', handler: Handler(handlerFunc: (_, __) => AESTestPage()));
    router.define('DBallPage', handler: Handler(handlerFunc: (_, __) => DBallPage()));
    router.define('DBallPage2', handler: Handler(handlerFunc: (_, __) => DBallPage2()));
    router.define('DBallPage3', handler: Handler(handlerFunc: (_, __) => DBallPage3()));
    router.define('DBallPage4', handler: Handler(handlerFunc: (_, __) => DBallPage4()));
    router.define('TagCloudPage', handler: Handler(handlerFunc: (_, __) => TagCloudPage()));
    router.define('FormTest', handler: Handler(handlerFunc: (_, __) => FormTest()));
    router.define('PhotoSelectTest', handler: Handler(handlerFunc: (_, __) => PhotoSelectTest()));
    router.define('RedDotPage', handler: Handler(handlerFunc: (_, __) => RedDotPage()));
    router.define('QRCodeTest', handler: Handler(handlerFunc: (_, __) => QRCodeTest()));
    router.define('SideslipTestPage', handler: Handler(handlerFunc: (_, __) => SideslipTestPage()));
    router.define('CitySelectListPage', handler: Handler(handlerFunc: (_, __) => CitySelectListPage()));
    router.define('DeviceInfoTest', handler: Handler(handlerFunc: (_, __) => DeviceInfoTest()));

    // search
    router.define('SearchDemoListPage', handler: Handler(handlerFunc: (_, __) => SearchDemoListPage()));
    router.define('SearchTest1Page', handler: Handler(handlerFunc: (_, __) => SearchTest1Page()));
    router.define('SearchTest2Page', handler: Handler(handlerFunc: (_, __) => SearchTest2Page()));
    router.define('SearchTest3Page', handler: Handler(handlerFunc: (_, __) => SearchTest3Page()));
    router.define('SearchTest4Page', handler: Handler(handlerFunc: (_, __) => SearchTest4Page()));

    // swiper
    router.define('SwiperDemoListPage', handler: Handler(handlerFunc: (_, __) => SwiperDemoListPage()));
    router.define('SwiperTest1Page', handler: Handler(handlerFunc: (_, __) => SwiperTest1Page()));
    router.define('SwiperTest2Page', handler: Handler(handlerFunc: (_, __) => SwiperTest2Page()));
    router.define('SwiperTest3Page', handler: Handler(handlerFunc: (_, __) => SwiperTest3Page()));
    router.define('SwiperTest4Page', handler: Handler(handlerFunc: (_, __) => SwiperTest4Page()));
    router.define('NewFeaturePage', handler: Handler(handlerFunc: (_, __) => NewFeaturePage()));
    router.define('FullScreenSwiperWidget', handler: Handler(handlerFunc: (_, __) => FullScreenSwiperWidget()));

    // TopTabBarDemoListPage
    router.define('TopTabBarDemoListPage', handler: Handler(handlerFunc: (_, __) => TopTabBarDemoListPage()));
    router.define('TopTabBarTest1Page', handler: Handler(handlerFunc: (_, __) => TopTabBarTest1Page()));
    router.define('TopTabBarTest2Page', handler: Handler(handlerFunc: (_, __) => TopTabBarTest2Page()));
    router.define('TopTabBarTest3Page', handler: Handler(handlerFunc: (_, __) => TopTabBarTest3Page()));
    // ui
    router.define('UIDemoListPage', handler: Handler(handlerFunc: (_, __) => UIDemoListPage()));
    router.define('UIPage', handler: Handler(handlerFunc: (_, __) => UIPage()));
    router.define('UIPage2', handler: Handler(handlerFunc: (_, __) => UIPage2()));
    router.define('ScrollPage', handler: Handler(handlerFunc: (_, __) => ScrollPage()));
    router.define('GrammarTestPage', handler: Handler(handlerFunc: (_, __) => GrammarTestPage()));
  }
}
