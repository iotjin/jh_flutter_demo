// ignore_for_file: unnecessary_import, unused_import
// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import 'listview_test_custom_cell.dart';
import '/base_appbar.dart';

var dataArr = [];
var pageIndex = 0; // 页数
var count = 10; // 每页10条

void getNewData() {
  pageIndex = 0;
  dataArr = [];
  for (int i = pageIndex * count; i < count; i++) {
    var map = <String, dynamic>{};
    map['title'] = 'title$i';
    map['place'] = 'place$i';
    map['state'] = '流转中$i';
    map['content'] = '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容';
    map['phone'] = '$i$i$i' 'xxxxxxx';
    map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    dataArr.add(map);
  }
}

void getMoreData() {
  pageIndex++;
  for (int i = pageIndex * count; i < pageIndex * count + count; i++) {
    var map = <String, dynamic>{};
    map['title'] = 'title$i';
    map['place'] = 'place$i';
    map['state'] = '流转中$i';
    map['content'] = '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容';
    map['phone'] = '$i$i$i' 'xxxxxxx';
    map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    dataArr.add(map);
  }
}

// 2.x版本EasyRefresh，基类或网络请求使用的3.x版本EasyRefresh
class ListViewTestPullDownVC extends StatefulWidget {
  const ListViewTestPullDownVC({Key? key}) : super(key: key);

  @override
  State<ListViewTestPullDownVC> createState() => _ListViewTestPullDownVCState();
}

class _ListViewTestPullDownVCState extends State<ListViewTestPullDownVC> {
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('假数据分页 - header/footer跟随'),
      body: EasyRefresh(
        header: BallPulseHeader(),
        footer: BallPulseFooter(),
        controller: _controller,
        firstRefresh: true,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2), () {
            print('下拉刷新-----');
            getNewData();
            setState(() {
              _count = dataArr.length;
              print('最新条数 ${_count.toString()}');
              _controller.resetLoadState();
            });
          });
        },
        onLoad: () async {
          await Future.delayed(const Duration(seconds: 2), () {
            print('上拉加载-----');
            getMoreData();
            setState(() {
              _count = dataArr.length;
              print('加载更多条数 ${_count.toString()}');
            });
            _controller.finishLoad(noMore: _count >= 30);
          });
        },
        // 不加header
        // child: cell(_count),
        // header跟随，方式1
        // child: ListView(
        //   children: [
        //     _header(),
        //     _listWidget(_count),
        //     _footer(),
        //   ],
        // ),
        // header跟随，方式2
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _header(),
                _listWidget(_count),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _header() {
  return Column(
    children: [
      Container(
        alignment: Alignment.center,
        color: Colors.orange,
        height: 50,
        child: const Text('header', style: TextStyle(color: Colors.white)),
      )
    ],
  );
}

Widget _footer() {
  return Container(
    alignment: Alignment.center,
    color: Colors.orange,
    height: 50,
    child: const Text('footer', style: TextStyle(color: Colors.white)),
  );
}

Widget _listWidget(int dataCount) {
  if (dataCount == 0) {
    return const JhEmptyView();
    // return Container(
    //   alignment: Alignment.topCenter,
    //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
    //   child: Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
    // );
  } else {
    return ListView.separated(
      // 加header要加上这两个属性
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // 加header要加上这两个属性
      // 取消footer和cell之间的空白
      padding: const EdgeInsets.all(0),
      itemCount: dataCount,
      itemBuilder: (context, index) {
        CustomViewModel model = CustomViewModel.fromJson(dataArr[index]);
        print('title${model.title!}');
        return ListViewTestCustomCell(data: model);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: .5,
          indent: 15,
          endIndent: 15,
          // color: Color(0xFFDDDDDD),
          color: Colors.purple,
        );
      },
    );
  }
}
