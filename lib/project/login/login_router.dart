import 'package:fluro/fluro.dart';
import '/project/routes/router_init.dart';
import '/project/login/pages/login_page.dart';
import '/project/login/pages/register_page.dart';
import '/project/login/pages/find_pwd_page.dart';
import '/project/login/pages/code_login_page.dart';
import '/project/new_feature/new_feature_page.dart';
import '/project/new_feature/full_screen_swiper_widget.dart';

class LoginRouter implements IRouterProvider {
  static String pLoginPage = 'LoginPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pLoginPage, handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    router.define('RegisterPage', handler: Handler(handlerFunc: (_, __) => const RegisterPage()));
    router.define('FindPwdPage', handler: Handler(handlerFunc: (_, __) => const FindPwdPage()));
    router.define('CodeLoginPage', handler: Handler(handlerFunc: (_, __) => const CodeLoginPage()));

    router.define('NewFeaturePage', handler: Handler(handlerFunc: (_, __) => const NewFeaturePage()));
    router.define('FullScreenSwiperWidget', handler: Handler(handlerFunc: (_, __) => const FullScreenSwiperWidget()));
  }
}
