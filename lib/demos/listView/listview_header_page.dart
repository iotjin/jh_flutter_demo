import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/base_appbar.dart';

class ListViewHeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('ListViewHeader'),
      body: _body(),
    );
  }

  _body() {
    var _dataArr = [];
    for (var i = 0; i < 30; i++) {
      _dataArr.add(i);
    }

    return CustomScrollView(
      slivers: <Widget>[
        // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
        SliverToBoxAdapter(child: _header()),
        _listWidget(_dataArr),
        SliverToBoxAdapter(child: _footer()),
      ],
    );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.yellow,
          height: 120,
          child: Text('header', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  Widget _footer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange,
      height: 120,
      child: Text('footer', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return JhEmptyView();
            // return Container(
            //   alignment: Alignment.topCenter,
            //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            //   child: Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
            // );
          },
          childCount: 1,
        ),
      );
    } else {
      // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
      return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _cell(index);
          },
          childCount: dataArr.length,
        ),
        itemExtent: 48.0,
      );
      // 不固定高度
      // return SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (BuildContext context, int index) {
      //       return _cell(index);
      //     },
      //     childCount: dataArr.length,
      //   ),
      // );
    }
  }

  // 列表项
  _cell(int index) {
    return ListTile(title: Text('list tile index $index'));
  }
}
