import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:badges/badges.dart';

class RedDotPage extends StatefulWidget {
  @override
  _RedDotPageState createState() => _RedDotPageState();
}

class _RedDotPageState extends State<RedDotPage> {
  var _count = 999;
  var _rowHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
          appBar: baseAppBar(
            context, "小红点",
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(_rowHeight), child: _tabBar()),
//            elevation: 3,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Badge(
                badgeContent: Text('3'),
                child: Icon(Icons.settings),
              ),
              SizedBox(
                height: 15,
              ),
              Badge(
                child: Icon(Icons.settings),
              ),
              SizedBox(
                height: 15,
              ),
              Badge(
                child: Icon(Icons.settings),
                showBadge: false,
              ),
              SizedBox(
                height: 15,
              ),
              Badge(
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(5),
                position: BadgePosition.topEnd(top: -12, end: -20),
                padding: EdgeInsets.all(2),
                badgeContent: Text('New',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
                child: Text(
                  'MUSIC',
                  style: TextStyle(color: Colors.grey[600]),
                ),
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
              child: Icon(Icons.event),
            )),
        BottomNavigationBarItem(
            label: 'Messages',
            icon: Badge(
              toAnimate: false,
              position: BadgePosition.topEnd(top: -20, end: -20),
              badgeContent: Text(
                _count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: Icon(Icons.message),
            )),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Badge(
            shape: BadgeShape.circle,
            borderRadius: BorderRadius.circular(100),
            child: Icon(Icons.settings),
            badgeContent: Container(
              height: 5,
              width: 5,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
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
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.red),
                ),
                child: Icon(Icons.account_balance_wallet, color: Colors.white),
              ),
            ),
            Tab(
              icon: Badge(
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(5),
                position: BadgePosition.topEnd(top: -12, end: -20),
                padding: EdgeInsets.all(2),
                badgeContent: Text('NEW',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
                child: Text(
                  'MUSIC',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.label,
        ));
  }
}
