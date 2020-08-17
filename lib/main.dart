import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jh_flutter_demo/project/new_feature/new_feature_page.dart';
import 'package:package_info/package_info.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flustars/flustars.dart';
import 'package:flui/src/widgets/toast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluro/fluro.dart';

import 'package:jhtoast/jhtoast.dart';

import 'project/configs/colors.dart';
import 'project/routes/routes_old.dart' as luyou;
import 'project/routes/routes.dart';
import 'project/routes/application.dart';
import 'project/home_page.dart';
import 'project/base_tabbar.dart';
import 'project/login/pages/login_page.dart';
import 'project/model/user_model.dart';
import 'project/configs/project_config.dart';

import 'jh_common/utils/jh_screen_utils.dart';
import 'jh_common/utils/jh_storage_utils.dart';
import 'jh_common/widgets/jh_alert.dart';

/**
    屏幕宽度高度：MediaQuery.of(context).size.width
    屏幕宽度高度：MediaQuery.of(context).size.height
    屏幕状态栏高度：MediaQueryData.fromWindow(WidgetBinding.instance.window).padding.top。

    MediaQueryData mq = MediaQuery.of(context);
    // 屏幕密度
    pixelRatio = mq.devicePixelRatio;
    // 屏幕宽(注意是dp, 转换px 需要 screenWidth * pixelRatio)
    screenWidth = mq.size.width;
    // 屏幕高(注意是dp)
    screenHeight = mq.size.height;
    // 顶部状态栏, 随着刘海屏会增高
    statusBarHeight = mq padding.top;
    // 底部功能栏, 类似于iPhone XR 底部安全区域
    bottomBarHeight = mq.padding.bottom;

 * */

//void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;

  runApp(MyApp());

  if (Platform.isAndroid) {
    print("Android");
  } else if (Platform.isIOS) {
    print("iOS");
  }

  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FLToastDefaults _toastDefaults = FLToastDefaults();
  var _currentVersion = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LogUtils.init();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    _getInfo(); //获取设备信息
  }

  @override
  Widget build(BuildContext context) {
//    JhScreenUtils.init(context);
    return
//      FLToastProvider(
//          defaults: _toastDefaults,
        OKToast(
//          dismissOtherOnShow: true,
            child: Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
//                brightness: //深色还是浅色
//                primarySwatch: Colors.blue //主题颜色样本
          primaryColor: KColor.kWeiXinThemeColor, //主色，决定导航栏颜色
          accentColor: KColor.kWeiXinTitleColor,
          //次级色，决定大多数Widget的颜色，如进度条、开关等。
          primaryIconTheme: IconThemeData(color: KColor.kWeiXinTitleColor),
        ),
//            home: IndexPage(),
//            home: BaseTabBar(),
        home: SwitchRootWidget(),
        // 注册路由
//              routes: luyou.routes,
        onGenerateRoute: Application.router.generator,
        onUnknownRoute: (RouteSettings settings) =>
            MaterialPageRoute(builder: (context) => luyou.UnknownPage()),
        //        locale: Locale('en','US'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalEasyRefreshLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate()
        ],
        supportedLocales: [
          Locale('zh', 'CN'),
//                Locale('en', 'US')
        ],
      ),
    ));

// -------------------------- 以下不使用oktoast------------------------------------
//      Container(
//      child: MaterialApp(
//        debugShowCheckedModeBanner: false,
//        theme: ThemeData(
////          brightness: //深色还是浅色
////            primarySwatch: Colors.blue //主题颜色样本
//            primaryColor: KColor.kWeiXinThemeColor,  //主色，决定导航栏颜色
//            accentColor:  KColor.kWeiXinTitleColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
//            primaryIconTheme: IconThemeData(color: KColor.kWeiXinTitleColor),
//
//        ),
//        home: IndexPage(),
//        // 注册路由
//        routes: luyou.routes,
//        onUnknownRoute: (RouteSettings settings) =>
//            MaterialPageRoute(builder: (context) => luyou.UnknownPage()),
//        //        locale: Locale('en','US'),
//        localizationsDelegates: [
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//          GlobalEasyRefreshLocalizations.delegate
//        ],
//        supportedLocales: [
////          Locale('en','US'),
//          Locale('zh','CN'),
//        ],
//      ),
//    );
// -------------------------- 以下不使用oktoast------------------------------------
  }

  void _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currentVersion = packageInfo.version;
    });
  }

  Widget SwitchRootWidget() {
    var lastVersion =
        JhStorageUtils.getStringWithKey(kUserDefault_LastVersion);
//    print('lastVersion 版本号：$lastVersion');
    if (lastVersion == null || lastVersion == '') {
//      print('首次安装');
      return NewFeaturePage();
    } else {
//      print(oldVersion.compareTo(_currentVersion)); // 字符串 比较大小, 0:相同、1:大于、-1:小于
      if (lastVersion.compareTo(_currentVersion) < 0) {
//        print('新版本安装');
        return NewFeaturePage();
      } else {
//        print('正常启动');
        userModel model =
            SpUtil.getObj(kUserDefault_UserInfo, (v) => userModel.fromJson(v));
        if (model != null) {
          print('本地取出的 userName:' + model.userName);
          return BaseTabBar();
        } else {
          return LoginPage();
        }
      }
    }
  }
}

//void main() => runApp(MyApp());
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
//          child: new Text('Hello World'),
//        ),
//      ),
//    );
//  }
//}
