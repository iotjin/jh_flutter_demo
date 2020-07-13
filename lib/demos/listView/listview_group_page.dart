import 'package:flutter/material.dart';

import 'package:sticky_headers/sticky_headers.dart';

import 'package:jh_flutter_demo/base_appbar.dart';

List groupData = [
  {
    "groupTitle": "groupTitle_1",
    "num": "22",
    "data": [
      {
        "title": "group1_title11",
        "phone": "111xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      },
      {
        "title": "group1_title2",
        "phone": "222xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      }
    ]
  },
  {
    "groupTitle": "groupTitle_2",
    "num": "22",
    "data": [
      {
        "title": "group2_title33",
        "phone": "333xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      },
      {
        "title": "group2_title44",
        "phone": "444xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      }
    ]
  }
];

class ListViewGroupPage extends StatefulWidget {
  @override
  _ListViewGroupPageState createState() => _ListViewGroupPageState();
}

class _ListViewGroupPageState extends State<ListViewGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'ListViewGroupPage'),
      body: ListView.builder(
          itemCount: groupData.length,
          itemBuilder: (context, index) {
            return StickyHeader(
              header: Container(
                height: 50.0,
                color: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Header #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              content:  Column(
                children: buildGroup(groupData[index]['data'])
              ),
            );
          }),
    );
  }

  List<Widget> buildGroup(List group){
    return group.map((item){
//      print(item);
      return
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item['title']),
              Text(item['phone']),
              Image.network(item['imageUrl'], fit: BoxFit.cover,
                  width: 50, height: 50.0),
            ],
          );
    }).toList();
  }

}
