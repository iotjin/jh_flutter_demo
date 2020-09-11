/**
 *  person_center_page.dart
 *
 *  Created by iotjin on 2020/09/04.
 *  description:
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double _scrollMaxOffSet = 1000;

class PersonCenterPage extends StatefulWidget {
  @override
  _PersonCenterPageState createState() => _PersonCenterPageState();
}

class _PersonCenterPageState extends State<PersonCenterPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  double _topH = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);

    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print("滑动距离: $_y");
      if (_y < 0 && _y > -_scrollMaxOffSet) {
        setState(() {
          _topH = _y.abs();
//          print(_topH);
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: _topH + 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver-sticky效果'),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
