import 'package:fluro/fluro.dart';
import '/project/routes/router_init.dart';

import '/project/login/pages/login_page.dart';
import '/project/login/pages/register_page.dart';
import '/project/login/pages/find_pwd_page.dart';
import '/project/login/pages/code_login_page.dart';

class LoginRouter implements IRouterProvider {
  static String pLoginPage = 'LoginPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pLoginPage, handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    router.define('RegisterPage', handler: Handler(handlerFunc: (_, __) => const RegisterPage()));
    router.define('FindPwdPage', handler: Handler(handlerFunc: (_, __) => const FindPwdPage()));
    router.define('CodeLoginPage', handler: Handler(handlerFunc: (_, __) => const CodeLoginPage()));
  }
}
