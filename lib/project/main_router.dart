import 'package:fluro/fluro.dart';
import 'package:jh_flutter_demo/project/routes/router_init.dart';

import 'package:jh_flutter_demo/project/one/one_page.dart';
import 'package:jh_flutter_demo/project/two/two_page.dart';
import 'package:jh_flutter_demo/project/three/three_page.dart';
//four
import 'package:jh_flutter_demo/project/four/four_page.dart';
import 'package:jh_flutter_demo/project/four/set_page.dart';
import 'package:jh_flutter_demo/project/four/info_page.dart';
import 'package:jh_flutter_demo/project/four/about_page.dart';
import 'package:jh_flutter_demo/project/four/about_ios_page.dart';
import 'package:jh_flutter_demo/project/four/mine_page.dart';


class MainRouter implements IRouterProvider{

  static String onePage = '/onePage';
  static String twoPage = '/twoPage';
  static String threePage = '/threePage';
  static String fourPage = '/fourPage';

  @override
  void initRouter(Router router) {
    router.define(onePage, handler: Handler(handlerFunc: (_, __) => OnePage()));
    router.define(twoPage, handler: Handler(handlerFunc: (_, __) => TwoPage()));
    router.define(threePage, handler: Handler(handlerFunc: (_, __) => ThreePage()));

    router.define(fourPage, handler: Handler(handlerFunc: (_, __) => FourPage()));
    router.define("SetPage", handler: Handler(handlerFunc: (_, __) => SetPage()));
    router.define("InfoPage", handler: Handler(handlerFunc: (_, __) => InfoPage()));
    router.define("AboutPage", handler: Handler(handlerFunc: (_, __) => AboutPage()));
    router.define("AboutIOSPage", handler: Handler(handlerFunc: (_, __) => AboutIOSPage()));
    router.define("MinePage", handler: Handler(handlerFunc: (_, __) => MinePage()));
  }
}

