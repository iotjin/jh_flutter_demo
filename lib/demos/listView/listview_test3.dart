// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

var dataArr = [];

List getData() {
  dataArr = [];
  for (int i = 0; i < 5; i++) {
    var map = {};
    map['title'] = 'title$i';
    map['place'] = 'place$i';
    map['state'] = '流转中$i';
    map['content'] = '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容';
    map['phone'] = '$i$i$i' 'xxxxxxx';
    map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    dataArr.add(map);
  }
  print(dataArr);
  return dataArr;
}

class ListViewTest3 extends StatelessWidget {
  const ListViewTest3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('ListViewTest3_复杂样式'),
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
    return
//      ListView.builder(
//        itemCount: dataArr.length,
//        itemBuilder: this._getWidget
//     );
        ListView.separated(
      itemCount: dataArr.length,
      itemBuilder: _getWidget,
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

  Widget _getWidget(context, index) {
    var spaceHeight = 10.0;

    return Container(
//      height: 100,
        padding: const EdgeInsets.all(15),
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: spaceHeight),
            Row(
//        mainAxisAlignment: MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dataArr[index]['place'], style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
//            Text(dataArr[index]['state'],style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
                Row(
                  children: <Widget>[
                    Text(dataArr[index]['state'], style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    JhNetworkImage(dataArr[index]['imageUrl'], width: 30, height: 30),
                  ],
                )
              ],
            ),
            SizedBox(height: spaceHeight),
            Text(dataArr[index]['phone'], textAlign: TextAlign.left, style: const TextStyle(fontSize: 18.0)),
            SizedBox(height: spaceHeight),
            Text(dataArr[index]['content'],
                textAlign: TextAlign.left, style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
          ],
        ));
  }
}
