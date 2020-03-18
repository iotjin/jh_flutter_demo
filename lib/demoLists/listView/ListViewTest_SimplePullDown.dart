import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

var dataArr;
var pageIndex =0;//页数
var count =10;//每页10条

void getNewData(){
  pageIndex =0;
  dataArr = new List();
  for(int i = pageIndex*count; i < count; i++){
    dataArr.add(i);
  }
  print(dataArr);
}

void getMoreData(){
  pageIndex++;
  for(int i = pageIndex*count; i <pageIndex*count+count; i++){
    dataArr.add(i);
  }
  print(dataArr);
}


class ListViewTest_SimplePullDown extends StatefulWidget {
  @override
  _ListViewTest_SimplePullDownState createState() => _ListViewTest_SimplePullDownState();
}

class _ListViewTest_SimplePullDownState extends State<ListViewTest_SimplePullDown> {

  EasyRefreshController _controller = EasyRefreshController();

    @override
    void initState() {
      super.initState();
    }
    int _count =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('ListViewTest_SimplePullDown')
      ),
      body:EasyRefresh(
        controller: _controller,
        firstRefresh: true,
        child:
        ListView.builder(
            itemCount: _count,
            itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            }
        ),

        onRefresh: () async{

          await Future.delayed(Duration(seconds: 2), () {
            print("下拉刷新-----");
            getNewData();
            setState(() {
              _count =dataArr.length;
              print("最新条数"+_count.toString());
              _controller.resetLoadState();
            });
          });


        },
        onLoad: () async {
         await Future.delayed(Duration(seconds: 2), () {
          print("上拉加载-----");
          getMoreData();
          setState(() {
            _count =dataArr.length;
            print("加载更多条数"+_count.toString());
          });
          _controller.finishLoad(noMore: _count >= 30);
         });
        },
      )
    );
  }
}




