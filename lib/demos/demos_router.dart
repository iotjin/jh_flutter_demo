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
import 'alert/dialog_test_page.dart';
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
import 'chart/echarts/echart_page1.dart';
import 'chart/echarts/echart_page2.dart';
import 'chart/echarts/echart_page3.dart';
import 'chart/echarts/echart_page4.dart';
import 'chart/chart_page1.dart';
import 'chart/chart_page2.dart';
import 'chart/mp_chart_line_page1.dart';
import 'chart/mp_chart_bar_page1.dart';
import 'chart/mp_chart_combined_page.dart';

// 表单
import 'form/form_demo_list_page.dart';
import 'form/login_text_field_test_page.dart';
import 'form/input_text_field_test_page.dart';
import 'form/form_input_cell_test_page.dart';
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
import 'http/http_page_test_header_follow_page.dart';

// ListView
import 'listView/listview_demo_list_page.dart';
import 'listView/listview_test.dart';
import 'listView/listview_test2.dart';
import 'listView/listview_test3.dart';
import 'listView/listview_test4.dart';
import 'listView/listview_test5.dart';
import 'listView/listview_test_card.dart';
import 'listView/listview_test_custom_vc.dart';
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

// 功能组件
import 'components/component_demo_list_page.dart';
import 'components/slide_menu_test_page.dart';

// other
import 'other/form_test.dart';
import 'other/photo_select_test.dart';
import 'other/red_dot_page.dart';
import 'other/qr_code_test.dart';
import 'other/aes_test_page.dart';
import 'other/sideslip_test_page.dart';
import 'other/city_select_list_page.dart';
import 'other/permission_test.dart';
import 'other/device_info_test.dart';

// 动画
import 'other/animation/animation_demo_list_page.dart';
import 'other/animation/animation_test_page.dart';
import 'other/animation/ball_3d_page.dart';
import 'other/animation/ball_3d_page2.dart';
import 'other/animation/ball_3d_page3.dart';
import 'other/animation/ball_3d_page4.dart';
import 'other/animation/tag_cloud_page.dart';

// search
import 'search/search_demo_list_page.dart';
import 'search/search_test1_page.dart';
import 'search/search_test2_page.dart';
import 'search/search_test3_page.dart';
import 'search/search_test4_page.dart';
import 'search/debounce_throttle_test_page.dart';

// swiper
import 'swiper/swiper_demo_list_page.dart';
import 'swiper/swiper_test1_page.dart';
import 'swiper/swiper_test2_page.dart';
import 'swiper/swiper_test3_page.dart';
import 'swiper/swiper_test4_page.dart';
import 'swiper/swiper_test5_page.dart';
import 'swiper/swiper_test6_page.dart';
import 'swiper/swiper_test7_page.dart';

// TopTabBar
import 'topTabBar/top_tabbar_demo_list_page.dart';
import 'topTabBar/top_tabbar_test1_page.dart';
import 'topTabBar/top_tabbar_test2_page.dart';
import 'topTabBar/top_tabbar_test3_page.dart';
import 'topTabBar/top_tabbar_test4_page.dart';
import 'topTabBar/personal_center_page1.dart';
import 'topTabBar/personal_center_page2.dart';
import 'topTabBar/personal_center_page3.dart';
import 'topTabBar/personal_center_page4.dart';
import 'topTabBar/personal_center_page5.dart';

import 'ui/ui_demo_list_page.dart';
import 'ui/ui_page.dart';
import 'ui/ui_page2.dart';
import 'ui/scroll_page.dart';
import 'ui/grammar_test_page.dart';

class DemosRouter implements IRouterProvider {
  static String pDemoListPage = 'DemoListPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pDemoListPage, handler: Handler(handlerFunc: (_, __) => const DemoListPage()));
    // base
    router.define('BaseDemoListPage', handler: Handler(handlerFunc: (_, __) => const BaseDemoListPage()));
    router.define('BaseRefreshViewTestPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return BaseRefreshViewTestPage(jsonDecode(jumpParams));
    }));
    router.define('BaseListViewShimmerTestPage',
        handler: Handler(handlerFunc: (_, __) => const BaseListViewShimmerTestPage()));
    router.define('BaseGridViewShimmerTestPage',
        handler: Handler(handlerFunc: (_, __) => const BaseGridViewShimmerTestPage()));
    router.define('BaseRefreshViewHeaderFixedPage',
        handler: Handler(handlerFunc: (_, __) => const BaseRefreshViewHeaderFixedPage()));
    router.define('BaseRefreshViewHeaderFollowPage',
        handler: Handler(handlerFunc: (_, __) => const BaseRefreshViewHeaderFollowPage()));
    router.define('NavTestPage', handler: Handler(handlerFunc: (_, __) => const NavTestPage()));
    router.define('EmptyDemoListPage', handler: Handler(handlerFunc: (_, __) => const EmptyDemoListPage()));

    // Alert
    router.define('AlertDemoListPage', handler: Handler(handlerFunc: (_, __) => const AlertDemoListPage()));
    router.define('AlertTestPage', handler: Handler(handlerFunc: (_, __) => const AlertTestPage()));
    router.define('BottomSheetTest', handler: Handler(handlerFunc: (_, __) => const BottomSheetTest()));
    router.define('DialogTestPage', handler: Handler(handlerFunc: (_, __) => const DialogTestPage()));
    router.define('CascadePickerTest', handler: Handler(handlerFunc: (_, __) => const CascadePickerTest()));
    router.define('CascadeTreePickerTest', handler: Handler(handlerFunc: (_, __) => const CascadeTreePickerTest()));

    // toast
    router.define('ToastDemoListPage', handler: Handler(handlerFunc: (_, __) => const ToastDemoListPage()));
    router.define('ToastTestPage', handler: Handler(handlerFunc: (_, __) => const ToastTestPage()));
    // chart
    router.define('ChartDemoListPage', handler: Handler(handlerFunc: (_, __) => const ChartDemoListPage()));
    router.define('ChartPage1', handler: Handler(handlerFunc: (_, __) => const ChartPage1()));
    router.define('ChartPage2', handler: Handler(handlerFunc: (_, __) => const ChartPage2()));
    router.define('EChartPage1', handler: Handler(handlerFunc: (_, __) => const EChartPage1()));
    router.define('EChartPage2', handler: Handler(handlerFunc: (_, __) => const EChartPage2()));
    router.define('EChartPage3', handler: Handler(handlerFunc: (_, __) => const EChartPage3()));
    router.define('EChartPage4', handler: Handler(handlerFunc: (_, __) => const EChartPage4()));
    router.define('GraphicBarPage', handler: Handler(handlerFunc: (_, __) => const GraphicBarPage()));
    router.define('GraphicLinePage', handler: Handler(handlerFunc: (_, __) => const GraphicLinePage()));
    router.define('GraphicPiePage', handler: Handler(handlerFunc: (_, __) => const GraphicPiePage()));
    // router.define('MpChartLinePage1', handler: Handler(handlerFunc: (_, __) => MpChartLinePage1()));
    // router.define('MpChartBarPage1', handler: Handler(handlerFunc: (_, __) => MpChartBarPage1()));
    // router.define('MpChartCombinedPage', handler: Handler(handlerFunc: (_, __) => MpChartCombinedPage()));
    // 表单
    router.define('FormDemoListPage', handler: Handler(handlerFunc: (_, __) => const FormDemoListPage()));
    router.define('LoginTextFieldTestPage', handler: Handler(handlerFunc: (_, __) => const LoginTextFieldTestPage()));
    router.define('InputTextFieldTestPage', handler: Handler(handlerFunc: (_, __) => const InputTextFieldTestPage()));
    router.define('FormInputCellTestPage', handler: Handler(handlerFunc: (_, __) => const FormInputCellTestPage()));
    router.define('FormSelectCellTestPage', handler: Handler(handlerFunc: (_, __) => const FormSelectCellTestPage()));
    router.define('SetCellTestPage', handler: Handler(handlerFunc: (_, __) => const SetCellTestPage()));
    router.define('FormTestPage', handler: Handler(handlerFunc: (_, __) => const FormTestPage()));
    router.define('FormValidatePage', handler: Handler(handlerFunc: (_, __) => const FormValidatePage()));

    // GridView
    router.define('GridViewDemoListPage', handler: Handler(handlerFunc: (_, __) => const GridViewDemoListPage()));
    router.define('GridViewTest1', handler: Handler(handlerFunc: (_, __) => const GridViewTest1()));
    router.define('GridViewTest2', handler: Handler(handlerFunc: (_, __) => const GridViewTest2()));
    router.define('GridViewTest3', handler: Handler(handlerFunc: (_, __) => const GridViewTest3()));
    router.define('GridViewTest4', handler: Handler(handlerFunc: (_, __) => const GridViewTest4()));
    router.define('GridViewTestPage5', handler: Handler(handlerFunc: (_, __) => const GridViewTestPage5()));
    // http
    router.define('HttpDemoListPage', handler: Handler(handlerFunc: (_, __) => const HttpDemoListPage()));
    router.define('HttpTest1Page', handler: Handler(handlerFunc: (_, __) => const HttpTest1Page()));
    router.define('HttpPageTestPage', handler: Handler(handlerFunc: (_, __) => const HttpPageTestPage()));
    router.define('HttpPageTestHeaderFollowPage',
        handler: Handler(handlerFunc: (_, __) => const HttpPageTestHeaderFollowPage()));
    // ListView
    router.define('ListViewDemoListPage', handler: Handler(handlerFunc: (_, __) => const ListViewDemoListPage()));
    router.define('ListViewTest', handler: Handler(handlerFunc: (_, __) => const ListViewTest()));
    router.define('ListViewTest2', handler: Handler(handlerFunc: (_, __) => const ListViewTest2()));
    router.define('ListViewTest3', handler: Handler(handlerFunc: (_, __) => const ListViewTest3()));
    router.define('ListViewTest4', handler: Handler(handlerFunc: (_, __) => const ListViewTest4()));
    router.define('ListViewTest5', handler: Handler(handlerFunc: (_, __) => const ListViewTest5()));
    router.define('ListViewTestCard', handler: Handler(handlerFunc: (_, __) => const ListViewTestCard()));
    router.define('ListViewTestCustomVC', handler: Handler(handlerFunc: (_, __) => const ListViewTestCustomVC()));
    router.define('ListViewTestPullDownVC', handler: Handler(handlerFunc: (_, __) => const ListViewTestPullDownVC()));
    router.define('ListViewGroupPage', handler: Handler(handlerFunc: (_, __) => const ListViewGroupPage()));
    router.define('ListViewGroupPage2', handler: Handler(handlerFunc: (_, __) => const ListViewGroupPage2()));
    router.define('ListViewGroupPage3', handler: Handler(handlerFunc: (_, __) => const ListViewGroupPage3()));
    router.define('ListViewHeaderPage', handler: Handler(handlerFunc: (_, __) => const ListViewHeaderPage()));

    // 路由
    router.define('RouteDemoListPage', handler: Handler(handlerFunc: (_, __) => const RouteDemoListPage()));
    router.define('PassValuePage', handler: Handler(handlerFunc: (_, __) => const PassValuePage()));
    router.define('PassValuePage2', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return PassValuePage2(jsonDecode(jumpParams));
    }));
    router.define('PassValuePage3', handler: Handler(handlerFunc: (_, __) => const PassValuePage3()));
    router.define('RouteTestPage1', handler: Handler(handlerFunc: (_, __) => const RouteTestPage1()));
    router.define('RouteTestPage2', handler: Handler(handlerFunc: (_, __) => const RouteTestPage2()));

    // 拖拽排序
    router.define('DragSortDemoListPage', handler: Handler(handlerFunc: (_, __) => const DragSortDemoListPage()));
    router.define('ListviewDragSortPage', handler: Handler(handlerFunc: (_, __) => const ListviewDragSortPage()));
    router.define('ListviewDragSortPage2', handler: Handler(handlerFunc: (_, __) => const ListviewDragSortPage2()));
    router.define('GridviewDragSortPage', handler: Handler(handlerFunc: (_, __) => const GridviewDragSortPage()));

    // 功能组件
    router.define('ComponentDemoListPage', handler: Handler(handlerFunc: (_, __) => const ComponentDemoListPage()));
    router.define('SlideMenuTestPage', handler: Handler(handlerFunc: (_, __) => const SlideMenuTestPage()));

    // other
    router.define('AESTestPage', handler: Handler(handlerFunc: (_, __) => const AESTestPage()));
    router.define('FormTest', handler: Handler(handlerFunc: (_, __) => const FormTest()));
    router.define('PhotoSelectTest', handler: Handler(handlerFunc: (_, __) => const PhotoSelectTest()));
    router.define('RedDotPage', handler: Handler(handlerFunc: (_, __) => const RedDotPage()));
    router.define('QRCodeTest', handler: Handler(handlerFunc: (_, __) => const QRCodeTest()));
    router.define('SideslipTestPage', handler: Handler(handlerFunc: (_, __) => const SideslipTestPage()));
    router.define('CitySelectListPage', handler: Handler(handlerFunc: (_, __) => const CitySelectListPage()));
    router.define('PermissionTestPage', handler: Handler(handlerFunc: (_, __) => const PermissionTestPage()));
    router.define('DeviceInfoTest', handler: Handler(handlerFunc: (_, __) => const DeviceInfoTest()));
    // 动画
    router.define('AnimationDemoListPage', handler: Handler(handlerFunc: (_, __) => const AnimationDemoListPage()));
    router.define('AnimationTestPage', handler: Handler(handlerFunc: (_, __) => const AnimationTestPage()));
    router.define('Ball3DPage', handler: Handler(handlerFunc: (_, __) => const Ball3DPage()));
    router.define('Ball3DPage2', handler: Handler(handlerFunc: (_, __) => const Ball3DPage2()));
    router.define('Ball3DPage3', handler: Handler(handlerFunc: (_, __) => const Ball3DPage3()));
    router.define('Ball3DPage4', handler: Handler(handlerFunc: (_, __) => const Ball3DPage4()));
    router.define('TagCloudPage', handler: Handler(handlerFunc: (_, __) => const TagCloudPage()));

    // search
    router.define('SearchDemoListPage', handler: Handler(handlerFunc: (_, __) => const SearchDemoListPage()));
    router.define('SearchTest1Page', handler: Handler(handlerFunc: (_, __) => const SearchTest1Page()));
    router.define('SearchTest2Page', handler: Handler(handlerFunc: (_, __) => const SearchTest2Page()));
    router.define('SearchTest3Page', handler: Handler(handlerFunc: (_, __) => const SearchTest3Page()));
    router.define('SearchTest4Page', handler: Handler(handlerFunc: (_, __) => const SearchTest4Page()));
    router.define('DebounceThrottleTestPage',
        handler: Handler(handlerFunc: (_, __) => const DebounceThrottleTestPage()));

    // swiper
    router.define('SwiperDemoListPage', handler: Handler(handlerFunc: (_, __) => const SwiperDemoListPage()));
    router.define('SwiperTest1Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest1Page()));
    router.define('SwiperTest2Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest2Page()));
    router.define('SwiperTest3Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest3Page()));
    router.define('SwiperTest4Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest4Page()));
    router.define('SwiperTest5Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest5Page()));
    router.define('SwiperTest6Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest6Page()));
    router.define('SwiperTest7Page', handler: Handler(handlerFunc: (_, __) => const SwiperTest7Page()));

    // TopTabBarDemoListPage
    router.define('TopTabBarDemoListPage', handler: Handler(handlerFunc: (_, __) => const TopTabBarDemoListPage()));
    router.define('TopTabBarTest1Page', handler: Handler(handlerFunc: (_, __) => const TopTabBarTest1Page()));
    router.define('TopTabBarTest2Page', handler: Handler(handlerFunc: (_, __) => const TopTabBarTest2Page()));
    router.define('TopTabBarTest3Page', handler: Handler(handlerFunc: (_, __) => const TopTabBarTest3Page()));
    router.define('TopTabBarTest4Page', handler: Handler(handlerFunc: (_, __) => const TopTabBarTest4Page()));
    router.define('PersonalCenterPage1', handler: Handler(handlerFunc: (_, __) => const PersonalCenterPage1()));
    router.define('PersonalCenterPage2', handler: Handler(handlerFunc: (_, __) => const PersonalCenterPage2()));
    router.define('PersonalCenterPage3', handler: Handler(handlerFunc: (_, __) => const PersonalCenterPage3()));
    router.define('PersonalCenterPage4', handler: Handler(handlerFunc: (_, __) => const PersonalCenterPage4()));
    router.define('PersonalCenterPage5', handler: Handler(handlerFunc: (_, __) => const PersonalCenterPage5()));

    // ui
    router.define('UIDemoListPage', handler: Handler(handlerFunc: (_, __) => const UIDemoListPage()));
    router.define('UIPage', handler: Handler(handlerFunc: (_, __) => const UIPage()));
    router.define('UIPage2', handler: Handler(handlerFunc: (_, __) => const UIPage2()));
    router.define('ScrollPage', handler: Handler(handlerFunc: (_, __) => const ScrollPage()));
    router.define('GrammarTestPage', handler: Handler(handlerFunc: (_, __) => const GrammarTestPage()));
  }
}
