import 'package:flutter/material.dart';

class PassValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("传值"),
          elevation: 0.0,
        ),
        body:
        RaisedButton(
          child: Text("带参数跳转"),
          onPressed: () {
            Navigator.pushNamed(context, "PassValuePage2",arguments:"123").then((value){
              print("回传的值===="+value.toString());
            });
          },
        )

    );
  }
}



