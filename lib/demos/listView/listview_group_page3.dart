// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '/project/configs/project_config.dart';

List groupData33 = [
  {
    'groupTitle': 'groupTitle_1',
    'num': '15',
    'data': [
      {
        'title': 'group1_title11',
        'num': '12',
        'phone': '111xxxx',
        'content': 'content2-content2-content2-content2-content2-content2',
        'imageUrl': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      },
      {
        'title': 'group1_title2',
        'num': '5',
        'phone': '222xxxx',
        'content': 'content2-content2-content2-content2-content2-content2',
        'imageUrl': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      }
    ]
  },
  {
    'groupTitle': 'groupTitle_2',
    'num': '22',
    'data': [
      {
        'title': 'group2_title33',
        'num': '20',
        'phone': '333xxxx',
        'content': 'content2-content2-content2-content2-content2-content2',
        'imageUrl': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      },
      {
        'title': 'group2_title44',
        'num': '1',
        'phone': '444xxxx',
        'content': 'content2-content2-content2-content2-content2-content2',
        'imageUrl': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      }
    ]
  }
];

// 3.x 版本 EasyRefresh
class ListViewGroupPage3 extends StatefulWidget {
  const ListViewGroupPage3({Key? key}) : super(key: key);

  @override
  State<ListViewGroupPage3> createState() => _ListViewGroupPage3State();
}

class _ListViewGroupPage3State extends State<ListViewGroupPage3> with SingleTickerProviderStateMixin {
  List _groupDataArr = [];
  int _pageIndex = 0;
  final int _limit = 10;

  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  TabController? _tabController;
  List tabs = ['近30日', '近7日', '今日'];
  final _rowHeight = 44.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController!.addListener(() {
      // _tabController.indexIsChanging     监听不到滑动
      if (_tabController!.index.toDouble() == _tabController!.animation!.value) {
        print(_tabController!.index);
        _requestData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  void _requestData({isShowLoading = false, isLoadMore = false}) {
    _pageIndex = isLoadMore ? _pageIndex + 1 : 0;
    var params = {
      'page': _pageIndex,
      'limit': _limit,
    };
    var loadingText = isShowLoading == true ? 'Loading...' : null;
    HttpUtils.get(APIs.getGroupPage, params, loadingText: loadingText, success: (res) {
      var tempData = res['data'];
      setState(() {
        if (isLoadMore) {
          _groupDataArr = _groupDataArr + tempData;
          _controller.finishLoad(tempData.length == _limit ? IndicatorResult.success : IndicatorResult.noMore);
        } else {
          _groupDataArr = tempData;
          _controller.finishRefresh();
          _controller.resetFooter();
        }
      });
    }, fail: (code, msg) {
      if (isLoadMore) {
        _controller.finishLoad();
      } else {
        _controller.finishRefresh();
        _controller.resetFooter();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'ListViewGroupPage3 - 分组分页',
        bottomWidget: PreferredSize(preferredSize: Size.fromHeight(_rowHeight), child: _topTabBar()),
      ),
      // body: _content(),
      body: _body(),
    );
  }

// 顶部
  Widget _topTabBar() {
    return Container(
      height: _rowHeight,
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        indicatorColor: Colors.blueAccent,
        labelColor: const Color(0xFF646464),
        unselectedLabelColor: const Color(0xFF9B9B9B),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  // 刷新
  Widget _body() {
    return EasyRefresh(
      controller: _controller,
      refreshOnStart: true,
      child: _listWidget(),
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
    );
  }

  // content
  Widget _listWidget() {
    return ListView.builder(
      itemCount: _groupDataArr.length + 1,
      itemBuilder: (context, index) {
        return index == 0
            ? _topHeader()
            : StickyHeader(
                header: Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    // border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(width: 8),
                      Text(_groupDataArr[index - 1]['groupTitle']),
                      const SizedBox(width: 8),
                      Text('(${_groupDataArr[index - 1]['id']})',
                          style: const TextStyle(color: Colors.red, fontSize: 22))
                    ],
                  ),
                ),
                content: Column(
                  children: buildGroup(_groupDataArr[index - 1]['data'], _groupDataArr[index - 1]['groupNum']),
                ),
              );
      },
    );
  }

  // _topHeader
//  Widget _topHeader() {
//    return Container(
//      height: 200,
//      color: Colors.yellow,
//      padding: EdgeInsets.all(15),
//      child: Text('Header'),
//    );
//  }

  Widget _topHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    SizedBox(width: 8),
                    Text('这是title', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 8)
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('assets/images/lufei.png', width: 60, height: 60),
                ),
              ],
            ),
          ),
          Container(color: Colors.white, height: 1, child: const Divider(thickness: 1, indent: 15, endIndent: 15)),
          Container(
            height: 200,
            padding: const EdgeInsets.fromLTRB(50, 15, 50, 25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
            ),
          )
        ],
      ),
    );
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

      var width = MediaQuery.of(context).size.width;
      var bgW = width * 0.5;
      var num = item['num'];
      var ratio = double.parse(num.toString()) / double.parse(groupNum.toString());
//      print(ratio);
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(flex: 20, child: Text(item['name'], style: const TextStyle(color: Colors.grey))),
            Expanded(
              flex: 60,
              child: LinearPercentIndicator(
                width: bgW,
                lineHeight: 10.0,
                percent: ratio,
                backgroundColor: const Color(0xFFDCDCE6),
                progressColor: color,
              ),
            ),
            Expanded(flex: 20, child: Text('$num次', style: const TextStyle(color: Colors.grey))),
          ],
        ),
      );
    }).toList();
  }
}
