import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:sticky_headers/sticky_headers.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/http/http_utils.dart';

List groupData33 = [
  {
    "groupTitle": "groupTitle_1",
    "num": "15",
    "data": [
      {
        "title": "group1_title11",
        "num": "12",
        "phone": "111xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      },
      {
        "title": "group1_title2",
        "num": "5",
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
        "num": "20",
        "phone": "333xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      },
      {
        "title": "group2_title44",
        "num": "1",
        "phone": "444xxxx",
        "content": "content2-content2-content2-content2-content2-content2",
        "imageUrl": "https://gitee.com/iotjh/Picture/raw/master/lufei.png"
      }
    ]
  }
];

var dataArr;
var pageIndex = 0; //页数
var groupData = [];

class ListViewGroupPage3 extends StatefulWidget {
  @override
  _ListViewGroupPage3State createState() => _ListViewGroupPage3State();
}

class _ListViewGroupPage3State extends State<ListViewGroupPage3>
    with SingleTickerProviderStateMixin {
  EasyRefreshController _controller = EasyRefreshController();

  TabController _tabController;
  List tabs = ["近30日", "近7日", "今日"];
  var _rowHeight = 44.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void getNewData() {
    pageIndex = 0;
    print("pageIndex- ${pageIndex}");
    HttpUtils.getNewPageGroupList({"page": pageIndex}, success: (result) {
      setState(() {
        groupData = result['data'];
        _controller.resetLoadState();
      });
    }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("more pageIndex- ${pageIndex}");

    HttpUtils.getNewPageGroupList({"page": pageIndex}, success: (result) {
      var moreData = result['data'];
      setState(() {
        if (moreData.length > 0) {
          _controller.finishLoad();
          groupData = groupData + moreData;
        } else {
          _controller.finishLoad(noMore: true);
        }
      });
    }, fail: (code) {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context,
        'ListViewGroupPage3',
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(_rowHeight), child: _topTabBar()),
      ),
//      body: _content(),
      body: _refresh(),
    );
  }

//顶部
  Widget _topTabBar() {
    return Container(
        height: _rowHeight,
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          indicatorColor: Colors.blueAccent,
          labelColor: Color(0xFF646464),
          unselectedLabelColor: Color(0xFF9B9B9B),
          indicatorSize: TabBarIndicatorSize.label,
        ));
  }

  //刷新
  Widget _refresh() {
    return EasyRefresh(
      header: ClassicalHeader(
        showInfo: false,
//        noMoreText: 'noMoreText',
//        refreshedText: '加载完成',
//        refreshFailedText: '加载失败',
//        refreshingText: '加载中...',
//        refreshReadyText: '释放刷新',
//        refreshText: '下拉刷新',
      ),
      footer: ClassicalFooter(showInfo: false),
      controller: _controller,
      firstRefresh: true,
      child: _content(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          print("下拉刷新-----");
          getNewData();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          print("上拉加载-----");
          getMoreData();
        });
      },
    );
  }

  // content
  Widget _content() {
    return ListView.builder(
        itemCount: groupData.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? _topHeader()
              : StickyHeader(
                  header: Container(
                    height: 50.0,
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.orange,
//                        border: Border(
//                          bottom:
//                              BorderSide(width: 1, color: Color(0xffe5e5e5)),
//                        )
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 8),
                        Text(
                          groupData[index - 1]['groupTitle'],
                        ),
                        SizedBox(width: 8),
                        Text('(${groupData[index - 1]['id']})',
                            style: TextStyle(color: Colors.red, fontSize: 22))
                      ],
                    ),
                  ),
                  content: Column(
                      children: buildGroup(groupData[index - 1]['data'],
                          groupData[index - 1]['groupNum'])),
                );
        });
  }

  //_topHeader
//  Widget _topHeader() {
//    return Container(
//      height: 200,
//      color: Colors.yellow,
//      padding: EdgeInsets.all(15),
//      child: Text("Header"),
//    );
//  }

  Widget _topHeader() {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 8),
                      Text('这是title', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/lufei.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 1,
              child: Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.fromLTRB(50, 15, 50, 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
              ),
            )
          ],
        ));
  }

  List<Widget> buildGroup(List group, var groupNum) {
    return group.map((item) {
      var color = Colors.cyan;
      if (item['state'] == '1') {
        color = Colors.red;
      }
      if (item['state'] == '2') {
        color = Colors.yellow;
      }
      if (item['state'] == '3') {
        color = Colors.blue;
      }

      var _width = MediaQuery.of(context).size.width;
      var _bgW = _width * 0.5;
      var _num = item['num'];
      var libi =
          double.parse(_num.toString()) / double.parse(groupNum.toString());
//      print(libi);
      return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          child: Row(
            children: <Widget>[
              Text(item['name'], style: TextStyle(color: Colors.grey)),
              SizedBox(width: 8),
              LinearPercentIndicator(
                width: _bgW,
                lineHeight: 10.0,
                percent: libi,
                backgroundColor: Color(0xFFDCDCE6),
                progressColor: color,
              ),
              SizedBox(width: 8),
              Text('${_num}次', style: TextStyle(color: Colors.grey)),
            ],
          ));
    }).toList();
  }
}
