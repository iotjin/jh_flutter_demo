import 'package:flutter/material.dart';

class PassValuePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //获取路由参数
    var value =ModalRoute.of(context).settings.arguments;
    print("接收传值"+ value.toString());

    return Scaffold(
        appBar: AppBar(
          title: Text("接收的值: ${value}"),
          elevation: 0.0,
        ),
       body:
       RaisedButton(
          child: Text("点击回传"),
          onPressed: () {
            Navigator.of(context).pop('456');
          },
        )

    );
  }
}



