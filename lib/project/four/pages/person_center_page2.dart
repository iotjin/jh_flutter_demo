/**
 *  person_center_page2.dart
 *
 *  Created by iotjin on 2020/09/04.
 *  description:
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_screen_utils.dart';

double _scrollMaxOffSet = 1000;

class PersonCenterPage2 extends StatefulWidget {
  @override
  _PersonCenterPage2State createState() => _PersonCenterPage2State();
}

class _PersonCenterPage2State extends State<PersonCenterPage2>
    with SingleTickerProviderStateMixin {
  double _topH = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
      print("滑动距离: $_y");
      if (_y < 0 && _y > -_scrollMaxOffSet) {
        setState(() {
          _topH = _y.abs();
          print(_topH);
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
    return Scaffold(body: _body());
  }

  Widget _body() {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
        color: Colors.yellow,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: 100,
              itemExtent: 50.0,
              //强制高度为50.0
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("$index"));
              }),
        ),
      ),
      Positioned(
        top: 0,
        width: JhScreenUtils.screenWidth,
        height: _topH + 200,
        child: Container(
//            color: Colors.yellow,
            color: Colors.white,
            child: Image.network(
              'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: JhScreen.topSafeHeight + 18,
        left: 18,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
