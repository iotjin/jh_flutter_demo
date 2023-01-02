import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/base_appbar.dart';

class ListViewGroupPage2 extends StatefulWidget {
  @override
  _ListViewGroupPage2State createState() => _ListViewGroupPage2State();
}

class _ListViewGroupPage2State extends State<ListViewGroupPage2> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List tabs = ['近30日', '近7日', '今日'];
  var _rowHeight = 44.0;
  var _groupData = [];

  @override
  void initState() {
    super.initState();

    _groupData = _getData();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController!.addListener(() {
      print(_tabController!.index);
    });
  }

  _getData() {
    var dataArr = [];
    for (int i = 0; i < 30; i++) {
      var groupDict = new Map();
      groupDict['groupTitle'] = 'groupTitle_$i';
      groupDict['num'] = JhCommonUtils.getRandom(50, 100).toInt().toString();
      var tempArr = [];
      int length = JhCommonUtils.getRandom(2, 5).toInt();
      for (int j = 0; j < length; j++) {
        var tempDict = new Map();
        tempDict['title'] = 'group$i' + '_title$j';
        tempDict['num'] = JhCommonUtils.getRandom(1, 50).toInt().toString();
        tempDict['phone'] = '$j$j$j' + 'xxxxxxx';
        tempDict['content'] = 'content{$j}-content{$j}-content{$j}-content{$j}-content{$j}-content{$j}';
        tempDict['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
        tempArr.add(tempDict);
      }
      groupDict['data'] = tempArr;
      dataArr.add(groupDict);
    }
    return dataArr;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'ListViewGroupPage2',
        bottomWidget: PreferredSize(preferredSize: Size.fromHeight(_rowHeight), child: _topTabBar()),
      ),
      body: _content(),
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

  // content
  Widget _content() {
    return ListView.builder(
        itemCount: _groupData.length + 1,
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
                          _groupData[index - 1]['groupTitle'],
                        ),
                        SizedBox(width: 8),
                        Text('(${_groupData[index - 1]['num']})', style: TextStyle(color: Colors.red, fontSize: 22))
                      ],
                    ),
                  ),
                  content: Column(children: buildGroup(_groupData[index - 1]['data'], _groupData[index - 1]['num'])),
                );
        });
  }

  //_topHeader
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
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
              ),
            )
          ],
        ));
  }

  List<Widget> buildGroup(List group, var groupNum) {
    return group.map((item) {
      var _width = MediaQuery.of(context).size.width;
      var _bgW = _width * 0.5;
      var _num = item['num'];
      var ratio = double.parse(_num) / double.parse(groupNum);
//      print(ratio);
      return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          child: Row(
            children: <Widget>[
              Expanded(flex: 30, child: Text(item['title'], style: TextStyle(color: Colors.grey))),
              Expanded(
                flex: 55,
                child: LinearPercentIndicator(
                  width: _bgW,
                  lineHeight: 10.0,
                  percent: ratio,
                  backgroundColor: Color(0xFFDCDCE6),
                  progressColor: Colors.red,
                ),
              ),
              Expanded(flex: 15, child: Text('$_num次', style: TextStyle(color: Colors.grey))),
            ],
          ));
    }).toList();
  }
}
