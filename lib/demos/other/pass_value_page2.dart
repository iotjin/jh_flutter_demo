import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';
import 'package:jh_flutter_demo/project/routes/fluro_navigator.dart';

class PassValuePage2 extends StatelessWidget {

  final String _passValue;
  PassValuePage2(this._passValue);

  @override
  Widget build(BuildContext context) {

    //获取路由参数
    var value =ModalRoute.of(context).settings.arguments;
    print("接收传值"+ value.toString());
    print("接收传值_passValue: "+ _passValue.toString());

    value = _passValue;

    return Scaffold(
        appBar: AppBar(
          title: Text("接收的值: ${value}"),
          elevation: 0.0,
        ),
       body:
       RaisedButton(
          child: Text("点击回传"),
          onPressed: () {
//            Navigator.of(context).pop('456');
            NavigatorUtils.goBackWithParams(context, '456');
          },
        )

    );
  }
}



