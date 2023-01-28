///  person_center_page.dart
///
///  Created by iotjin on 2020/09/04.
///  description:

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/project_config.dart';

double _scrollMaxOffSet = 1000;

class PersonCenterPage extends StatefulWidget {
  const PersonCenterPage({Key? key}) : super(key: key);

  @override
  State<PersonCenterPage> createState() => _PersonCenterPageState();
}

class _PersonCenterPageState extends State<PersonCenterPage> with SingleTickerProviderStateMixin {
  TabController? tabController;
  double _topH = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double y = _scrollController.offset;
//      print('滑动距离: $y');
      if (y < 0 && y > -_scrollMaxOffSet) {
        setState(() {
          _topH = y.abs();
//          print(_topH);
        });
      }
    });
  }

  @override
  void dispose() {
    // 为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          expandedHeight: _topH + 200,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Sliver-sticky效果', style: TextStyle(color: KColors.kNavTitleColor)),
            background: JhNetworkImage('http://img1.mukewang.com/5c18cf540001ac8206000338.jpg'),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyTabBarDelegate(
            child: TabBar(
              labelColor: KColors.dynamicColor(context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor),
              controller: tabController,
              tabs: const <Widget>[
                Tab(text: 'Home'),
                Tab(text: 'Profile'),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: tabController,
            children: const <Widget>[
              Center(child: Text('Content of Home')),
              Center(child: Text('Content of Profile')),
            ],
          ),
        ),
      ],
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  StickyTabBarDelegate({
    required this.child,
  });

  final TabBar child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
