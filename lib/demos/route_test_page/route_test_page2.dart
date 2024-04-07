import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class RouteTestPage2 extends StatefulWidget {
  const RouteTestPage2({Key? key}) : super(key: key);

  @override
  State<RouteTestPage2> createState() => _RouteTestPage2State();
}

class _RouteTestPage2State extends State<RouteTestPage2> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('禁用手势返回和安卓返回键', leftItemCallBack: () => _onClickBackItem(context)),
      body: PopScope(
        canPop: false, // false表示拦截物理按键，true不拦截
        onPopInvoked: (didPop) async {
          // 不管canPop是否为true，onPopInvoked都会调用
          if (didPop) return;
          // 在这里添加你想要执行的逻辑，比如弹出确认框等
          // 一些操作
          //
          // if (!context.mounted) return;
          // Navigator.of(context).pop(); // 如果需要返回则再执行 Navigator.of(context).pop();
        },
        child: _body(),
      ),
    );
  }

  void _onClickBackItem(context) {
    var title = '确认返回?';
    JhDialog.show(context, content: title, onConfirm: () {
      JhNavUtils.goBackWithParams(context, {'isRefresh': true});
    });
  }

  _body() {
    return ListView(
      children: const <Widget>[
        SizedBox(height: 10),
        Text('只能点击返回按钮返回'),
      ],
    );
  }
}

/*

当 canPop 为 true，则系统返回手势将导致封闭的 Navigator 照常接收弹出。会调用 onPopInvoked，此时didPop为true。

当 canPop 为 false，则系统返回手势不会将路由从封闭的 Navigator 中弹出，但仍然会调用 onPopInvoked 方法,此时 didPop 为 false，此时进行逻辑判断或者插入其他需要执行的代码，
如果需要返回则再执行 Navigator.of(context).pop();

注意此时 onPopInvoked 又会被再次调用，但此时 didPop 为 true。 因此，在onPopInvoked中，需要判断一下 didPop，如果为 true, 则 return。


*/
