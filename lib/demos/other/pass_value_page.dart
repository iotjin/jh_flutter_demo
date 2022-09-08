// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';
import '/demos/demos_router.dart';

class PassValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context, '传值'),
        body: ElevatedButton(
          child: Text('带参数跳转'),
          onPressed: () {
//            var title = 'title222';
//            Navigator.pushNamed(context, 'PassValuePage2',
//                arguments: {'title': title});

//            Navigator.pushNamed(context, 'PassValuePage2',arguments:'123').then((value){
//              print('回传的值===='+value.toString());
//            });

//            NavigatorFluroUtils.pushResult(context, '${'PassValuePage2'}?passValue=123&isScan=true', (value){
//              print('回传的值===='+value.toString());
//            });

//            JhNavUtils.pushNamed(context, '${'PassValuePage2'}?passValue=123&isScan=true');

            //跳转传递model可看two_page跳转个人信息

            JhNavUtils.pushNamedResult(context, '${'PassValuePage2'}?passValue=123&isScan=true', null, (value) {
              print('回传的值====' + value.toString());
              JhToast.showText(context, msg: '返回的参数: $value');
            });
          },
        ));
  }
}
