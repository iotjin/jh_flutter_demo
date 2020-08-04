import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';

import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'listview_test_custom_cell.dart';

var dataArr;
var pageIndex = 0; //页数
var count = 10; //每页10条

void getNewData() {
  pageIndex = 0;
  dataArr = new List();
  for (int i = pageIndex * count; i < count; i++) {
    var map = new Map();
    map["title"] = "title${i}";
    map["place"] = "place${i}";
    map["state"] = "流转中${i}";
    map["content"] =
        "这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容";
    map["phone"] = "${i}${i}${i}xxxxxxx";
    map["imageUrl"] = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    dataArr.add(map);
  }
}

void getMoreData() {
  pageIndex++;
  for (int i = pageIndex * count; i < pageIndex * count + count; i++) {
    var map = new Map();
    map["title"] = "title${i}";
    map["place"] = "place${i}";
    map["state"] = "流转中${i}";
    map["content"] =
        "这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容";
    map["phone"] = "${i}${i}${i}xxxxxxx";
    map["imageUrl"] = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    dataArr.add(map);
  }
}

class ListViewTest_PullDownVC extends StatefulWidget {
  @override
  _ListViewTest_PullDownVCState createState() =>
      _ListViewTest_PullDownVCState();
}

class _ListViewTest_PullDownVCState extends State<ListViewTest_PullDownVC> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ListViewTest_PullDownVC')),
        body: EasyRefresh(
            header: BallPulseHeader(),
            controller: _controller,
            firstRefresh: true,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2), () {
                print("下拉刷新-----");
                getNewData();
                setState(() {
                  _count = dataArr.length;
                  print("最新条数" + _count.toString());
                  _controller.resetLoadState();
                });
              });
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 2), () {
                print("上拉加载-----");
                getMoreData();
                setState(() {
                  _count = dataArr.length;
                  print("加载更多条数" + _count.toString());
                });
                _controller.finishLoad(noMore: _count >= 30);
              });
            },
            child: cell(_count)));
  }
}

Widget cell(int dataCount) {
  return ListView.separated(
    itemCount: dataCount,
    itemBuilder: (context, index) {
      /*先将字符串转成json*/
      Map<String, dynamic> json = Map<String, dynamic>.from(dataArr[index]);
//        print(json);
      /*将Json转成实体类*/
      CustomViewModel model = CustomViewModel.fromJson(json);
      print("title" + model.title);
      return ListViewTest_CustomCell(data: model);
    },
    separatorBuilder: (context, index) {
      return Divider(
        height: .5,
        indent: 15,
        endIndent: 15,
//            color: Color(0xFFDDDDDD),
        color: Colors.purple,
      );
    },
  );
}
