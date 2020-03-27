import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/configs/colors.dart';
import 'routes/routes.dart'as luyou;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhAlert.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flui/src/widgets/toast.dart';
import 'package:oktoast/oktoast.dart';


import 'home_page.dart';
import 'baseTabBar.dart';
import 'package:jh_flutter_demo/login/login_page.dart';

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

void main() {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  runApp(MyApp());

  if (Platform.isAndroid) {
    print("Android");
  }else if (Platform.isIOS) {
    print("iOS");
  }

  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}


class MyApp extends StatelessWidget {
  FLToastDefaults _toastDefaults = FLToastDefaults();
  @override
  Widget build(BuildContext context) {
    return


//      FLToastProvider(
//          defaults: _toastDefaults,
      OKToast(
//          dismissOtherOnShow: true,
          child:
          Container(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
//          brightness: //深色还是浅色
//            primarySwatch: Colors.blue //主题颜色样本
                primaryColor: KColor.kWeiXinThemeColor,  //主色，决定导航栏颜色
                accentColor:  KColor.kWeiXinTitleColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
                primaryIconTheme: IconThemeData(color: KColor.kWeiXinTitleColor),

              ),
//            home: IndexPage(),
//            home: BaseTabBar(),

              home:SwitchRootWidget(),

              // 注册路由
              routes: luyou.routes,
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
                Locale('zh','CN'),
//                Locale('en', 'US')
              ],
            ),
          )
      );

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

  Widget SwitchRootWidget(){
    var user = null;

    if (user != null) {
      return BaseTabBar();
    } else {
      return LoginPage();
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


