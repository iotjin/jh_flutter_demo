import 'package:flutter/material.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class PassValuePage2 extends StatelessWidget {
  final String _passValue;

  PassValuePage2(this._passValue);

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var value = ModalRoute.of(context)!.settings.arguments;
    print("接收传值" + value.toString());
    print("接收传值_passValue: " + _passValue.toString());

    value = _passValue;

    return Scaffold(
        appBar: backAppBar(context, '接收的值: $value'),
        body: ElevatedButton(
          child: Text("点击回传"),
          onPressed: () {
//            Navigator.of(context).pop('456');
            JhNavUtils.goBackWithParams(context, '456');
          },
        ));
  }
}
