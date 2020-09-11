/**
 *  info_page.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description: 基本信息
 */

import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';

import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_storage_utils.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/project/model/user_model.dart';

double _scrollMaxOffSet = 1000;

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  UserModel model;

  double _topH = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    model = SpUtil.getObj(kUserDefault_UserInfo, (v) => userModel.fromJson(v));
    var modelJson = JhStorageUtils.getModelWithKey(kUserDefault_UserInfo);
    model = UserModel.fromJson(modelJson);
    //监听滚动
    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print("滑动距离: $_y");

//      if (_y > 0 && _y < _scrollMaxOffSet) {
//        setState(() {
//          _topH = _y;
//        });
//      }
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
      appBar: baseAppBar(context, ''),
      backgroundColor: Color(0xFFF8F8F8), //248
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(children: <Widget>[
      Positioned(
        top: 0,
        child: Container(
          color: KColor.kWeiXinThemeColor,
//          color: Colors.white,
          constraints: BoxConstraints(
            minWidth: JhScreen.width,
            maxHeight: _topH,
          ),
        ),
      ),
      _cell(),
    ]);
  }

  Widget _cell() {
    return ListView(
      controller: _scrollController,
      // physics: const AlwaysScrollableScrollPhysics(),
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        Container(
          height: 100,
          color: kThemeColor,
          alignment: Alignment.center,
          child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
//                        color: Colors.pink,
                  image: DecorationImage(
                    image: NetworkImage(model.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                model.userName,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                model.phone,
                style: TextStyle(color: Colors.white),
              ),
//                    trailing: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white),
              contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              onTap: () {}),
        ),
        JhSetCell(
          title: '用户名',
          text: model.userName,
          hiddenArrow: true,
        ),
        JhSetCell(title: '手机号', text: model.phone, hiddenArrow: true),
      ],
    );
  }
}
