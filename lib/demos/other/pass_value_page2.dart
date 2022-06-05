import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/routes/jh_nav_fluro_utils.dart';

class PassValuePage2 extends StatelessWidget {
  final String _passValue;

  PassValuePage2(this._passValue);

  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var value = ModalRoute.of(context)!.settings.arguments;
    print("接收传值" + value.toString());
    print("接收传值_passValue: " + _passValue.toString());

    value = _passValue;

    return Scaffold(
        appBar: backAppBar(context, '接收的值: ${value}'),
        body: RaisedButton(
          child: Text("点击回传"),
          onPressed: () {
//            Navigator.of(context).pop('456');
            JhNavFluroUtils.goBackWithParams(context, '456');
          },
        ));
  }
}
