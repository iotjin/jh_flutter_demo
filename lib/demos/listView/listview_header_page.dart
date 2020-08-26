import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';

class ListViewHeaderPage extends StatelessWidget {
// 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(title: Text('list tile index $index'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'ListViewHeader'),
      body: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              color: Colors.yellow,
              child: Text('HeaderView'),
            ),
          ),
          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate(_buildListItem, childCount: 30),
              itemExtent: 48.0)
        ],
      ),
    );
  }
}
