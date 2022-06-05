import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/demos/demos_router.dart';
import 'package:jh_flutter_demo/project/routes/jh_nav_fluro_utils.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';

class PassValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context, '传值'),
        body: RaisedButton(
          child: Text("带参数跳转"),
          onPressed: () {
//            var title = 'title222';
//            Navigator.pushNamed(context, 'PassValuePage2',
//                arguments: {'title': title});

//            Navigator.pushNamed(context, "PassValuePage2",arguments:"123").then((value){
//              print("回传的值===="+value.toString());
//            });

//            NavigatorFluroUtils.pushResult(context, '${"PassValuePage2"}?passvalue=123&isScan=true', (value){
//              print("回传的值===="+value.toString());
//            });

//            JhNavFluroUtils.pushNamed(context, '${"PassValuePage2"}?passvalue=123&isScan=true');

            //跳转传递model可看two_page跳转个人信息

            JhNavFluroUtils.pushNamedResult(
                context, '${"PassValuePage2"}?passvalue=123&isScan=true',
                    (value) {
                  print("回传的值====" + value.toString());
                  JhToast.showText(context, msg: "返回的参数: $value");
                });
          },
        ));
  }
}
