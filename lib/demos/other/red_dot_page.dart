// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import '/base_appbar.dart';

class RedDotPage extends StatefulWidget {
  const RedDotPage({Key? key}) : super(key: key);

  @override
  State<RedDotPage> createState() => _RedDotPageState();
}

class _RedDotPageState extends State<RedDotPage> {
  var _count = 999;
  final _rowHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
          appBar: BaseAppBar(
            '小红点',
            bottomWidget: PreferredSize(preferredSize: Size.fromHeight(_rowHeight), child: _tabBar()),
//            elevation: 3,
          ),
          body: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              Badge(
                badgeContent: const Text('3'),
                child: const Icon(Icons.settings),
              ),
              const SizedBox(height: 15),
              Badge(child: const Icon(Icons.settings)),
              const SizedBox(height: 15),
              Badge(
                showBadge: false,
                child: const Icon(Icons.settings),
              ),
              const SizedBox(height: 15),
              Badge(
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(5),
                position: BadgePosition.topEnd(top: -12, end: -20),
                padding: const EdgeInsets.all(2),
                badgeContent:
                    const Text('New', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                child: Text('MUSIC', style: TextStyle(color: Colors.grey[600])),
              ),
            ],
          ),
        ));
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          label: 'Events',
          icon: Badge(
            child: const Icon(Icons.event),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Messages',
          icon: Badge(
            toAnimate: false,
            position: BadgePosition.topEnd(top: -20, end: -20),
            badgeContent: Text(
              _count.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: const Icon(Icons.message),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Badge(
            shape: BadgeShape.circle,
            borderRadius: BorderRadius.circular(100),
            badgeContent: Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
            child: const Icon(Icons.settings),
          ),
        ),
      ],
      onTap: (int index) {
        print(index);
        if (index == 1 && _count > 0) {
          setState(() {
            _count--;
          });
        }
      },
    );
  }

  Widget _tabBar() {
    return Container(
        height: _rowHeight,
        color: Colors.yellow,
        child: TabBar(
          tabs: [
            Tab(
              icon: Badge(
                badgeColor: Colors.blue,
                badgeContent: const Text('3', style: TextStyle(color: Colors.red)),
                child: const Icon(Icons.account_balance_wallet, color: Colors.white),
              ),
            ),
            Tab(
              icon: Badge(
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(5),
                position: BadgePosition.topEnd(top: -12, end: -20),
                padding: const EdgeInsets.all(2),
                badgeContent:
                    const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                child: const Text('MUSIC', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.label,
        ));
  }
}
