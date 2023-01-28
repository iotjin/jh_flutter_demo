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
      body: WillPopScope(
        onWillPop: () async {
          return false;
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
