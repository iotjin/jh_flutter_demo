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
    print('接收传值' + value.toString());
    print('接收传值_passValue: ' + _passValue.toString());

    value = _passValue;

    return Scaffold(
      appBar: BaseAppBar('接收的值: $value'),
      body: _body(context),
    );
  }

  _body(context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('点击回传'),
          onPressed: () {
//            Navigator.of(context).pop('456');
            JhNavUtils.goBackWithParams(context, '456');
          },
        ),
        ElevatedButton(
          child: Text('返回多级'),
          onPressed: () {
            JhNavUtils.goBack(context);
            JhNavUtils.goBack(context);
            JhNavUtils.goBackWithParams(context, '456');
          },
        )
      ],
    );
  }
}
