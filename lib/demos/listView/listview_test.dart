// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

var dataArr = [];
var dataJson = '';

List getData() {
  dataArr = [];
  for (int i = 0; i < 5; i++) {
    var map = {};
    map['title'] = 'title$i';
    map['content'] = 'content$i-content$i-content$i-content$i';
    map['phone'] = '$i$i$i' 'xxxxxxx';
    map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    dataArr.add(map);
  }
//  print(dataArr);

  dataJson = json.encode(dataArr);
  print('转json 字符串: $dataJson'); // 转json 字符串

  var data = json.decode(dataJson);
  data.forEach((v) {
//    print(v);
  });

  dataArr = data;

  return dataArr;
}

class ListViewTest extends StatelessWidget {
  const ListViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('ListViewTest_for循环造假数据'),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  ContentBody({Key? key}) : super(key: key) {
    getData();

    /*

      import 'dart:convert';
      json.encode(value) // map转json字符串
      json.decode(source) // json字符串转map

       */
    Map data = {
      'title': 'title1',
    };
    print('map转json字符串：${json.encode(data)}');
    String strData = '{"title":"title1"}';
    Map newMap = json.decode(strData);
    print('json字符串转map：${newMap['title']}');
  }

  Widget _getWidget(context, index) {
//    print(dataArr[index]['title']);
    return ListTile(
      title: Text(dataArr[index]['title']),
      leading: JhNetworkImage(dataArr[index]['imageUrl']),
      subtitle: Text(dataArr[index]['content']),
      onTap: () {
        print('点击的index ${index.toString()}');
      },
    );
  }

//  Widget _getWidget(context, index) {
//    return Container(
//     child:AspectRatio(
//        aspectRatio: 20/9,
//        child: JhNetworkImage(dataArr[index]['imageUrl']),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
//    getData();
    return ListView.builder(
      itemCount: dataArr.length,
      itemExtent: 100.0, // 强制高度为100.0
      itemBuilder: _getWidget,
    );
  }
}
