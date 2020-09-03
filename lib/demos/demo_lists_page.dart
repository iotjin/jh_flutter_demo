import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart' as Luyou;
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class DemoListsPage extends StatelessWidget {
  final List titleData = [
    "UI",
    "ListView",
    "GridView",
    "弹框",
    "Form",
    "图片选择",
    "跳转传值和回传",
    "网络请求",
    "baseNav",
    "JhForm",
    "chart",
    'JhTopTabBar',
    '搜索框',
    '小红点',
    '二维码',
    '轮播',
    'Animation',
    'AES',
    '列表侧滑',
    '城市选择列表',
  ];
  final List routeData = [
    "UIDemoListsPage",
    "ListViewDemoListsPage",
    "GridViewDemoListsPage",
    "AlertDemoListsPage",
    "FormTest",
    "PhotoSelectTest",
    "PassValuePage",
    "HttpDemoListsPage",
    "NavTestPage",
    "FormDemoListsPage",
    "ChartDemoListPage",
    "TopTabBarDemoListPage",
    "SearchDemoListPage",
    "RedDotPage",
    'QRCodeTest',
    'SwiperDemoListPage',
    'AnimationDemoListPage',
    'AESTestPage',
    'SideslipTestPage',
    'CitySelectListPage',
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "DemoLists",
      dataArr: titleData,
      callBack: (index, str) {
//          print(index);
        print(str);
//          print(routeData[index]);
//        NavigatorUtils.pushNamed(context, routeData[index]);
        NavigatorUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}
