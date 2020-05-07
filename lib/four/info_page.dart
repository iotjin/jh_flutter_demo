/**
 *  info_page.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description: 基本信息
 */

import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/JhForm/jhSetCell.dart';
import 'package:jh_flutter_demo/baseAppBar.dart';
import 'package:jh_flutter_demo/configs/colors.dart';
import 'package:flustars/flustars.dart';
import 'package:jh_flutter_demo/model/userModel.dart';
import 'package:jh_flutter_demo/configs/projectConfig.dart';


class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  userModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model = SpUtil.getObj(kUserDefault_UserInfo, (v) => userModel.fromJson(v));
  }


  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
          appBar: baseAppBar(context, '',),
          backgroundColor: Color(0xFFF8F8F8),//248
          body:

          ListView(
            children: <Widget>[


              Container(height: 100,
                color: kThemeColor,
                alignment:Alignment.center,
                child:

                ListTile(
                    leading:
                    Container(width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
//                        color: Colors.pink,
                        image: DecorationImage(
                          image: NetworkImage(model.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title:Text(model.userName,style: TextStyle(color: Colors.white),),
                    subtitle:Text(model.phone,style: TextStyle(color: Colors.white),),
//                    trailing: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    onTap:(){

                    }
                ),

              ),

              JhSetCell(title: '用户名',text:model.userName ,hiddenArrow: true,),
              JhSetCell(title: '手机号',text: model.phone ,hiddenArrow: true),

            ],
          ));


  }
}


