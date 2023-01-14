// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'listview_test_custom_cell.dart';
import '/base_appbar.dart';

var dataArr = [];
var dataJson = '';

List getData() {
  dataArr = [];
  for (int i = 0; i < 50; i++) {
    var map = {};
    map['title'] = 'title$i';
    map['place'] = 'place$i';
    map['state'] = '流转中$i';
    map['content'] = '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容';
    map['phone'] = '$i$i$i' 'xxxxxxx';
    map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    dataArr.add(map);
  }

  dataJson = json.encode(dataArr); //转json 字符串
//  print('转json 字符串:'+dataJson);
  dataArr = json.decode(dataJson);
//  dataArr.forEach((v) {
//    print(v);
//  });

  return dataArr;
}

class ListViewTestCustomVC extends StatelessWidget {
  const ListViewTestCustomVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('ListViewTestCustomVC'),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  ContentBody({Key? key}) : super(key: key) {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(dataArr.length);
    if (dataArr.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        //    alignment: Alignment.center,
        child: const Text('暂无数据', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.separated(
        itemCount: dataArr.length,
        itemBuilder: (context, index) {
          /*先将字符串转成json*/
          Map<String, dynamic> json = Map<String, dynamic>.from(dataArr[index]);
//        print(json);
          /*将Json转成实体类*/
          CustomViewModel model = CustomViewModel.fromJson(json);
          print('title ${model.title!}');
          return ListViewTestCustomCell(data: model);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: .5,
            indent: 15,
            endIndent: 15,
//            color: Color(0xFFDDDDDD),
            color: Colors.purple,
          );
        },
      );
    }
  }
}
