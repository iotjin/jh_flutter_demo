///  wx_new_friend_page.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 新的朋友

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/project/configs/project_config.dart';
import '../models/wx_new_friend_model.dart';
import '../widgets/wx_new_friend_cell.dart';

List _dataArr = [
  {
    'title': '张三',
    'subtitle': '欢迎欢迎',
    'img': 'assets/images/picture/touxiang_1.jpeg',
    'isAdd': true,
  },
  {
    'title': '李四',
    'subtitle': 'hello',
    'img': 'assets/images/picture/touxiang_2.jpeg',
    'isAdd': false,
  },
  {
    'title': '王五',
    'subtitle': '[图片]',
    'img': 'assets/images/picture/touxiang_3.jpeg',
    'isAdd': false,
  },
  {
    'title': '赵六',
    'subtitle': '[动画表情]',
    'img': 'assets/images/picture/touxiang_4.jpeg',
    'isAdd': true,
  },
  {
    'title': '哈哈哈',
    'subtitle': '',
    'img': 'assets/images/picture/touxiang_5.jpeg',
    'isAdd': false,
  },
  {
    'title': '@',
    'subtitle': 'hi',
    'img': 'assets/images/picture/touxiang_6.jpg',
    'isAdd': false,
  },
];

class WxNewFriendPage extends StatelessWidget {
  const WxNewFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('新的朋友', bgColor: Colors.transparent, rightText: '添加朋友', rightItemCallBack: () {
        JhNavUtils.pushNamed(context, 'WxAddFriendPage');
      }),
      body: _body(context),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  Widget _body(context) {
    return ListView(
      children: [
        Column(
          children: <Widget>[
            _header(context),
            _listWidget(_dataArr),
          ],
        ),
      ],
    );
  }

  Widget _header(context) {
    Widget searchBar = JhSearchBar(
      hintText: '微信号/手机号',
      bgColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor),
    );

    Widget myCode = InkWell(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
//        height: 60,
        child: Column(
          children: const <Widget>[
            Icon(Icons.phone_iphone, color: KColors.wxThemeColor),
            SizedBox(height: 10),
            Text('添加手机联系人', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      onTap: () => _clickCell(context, '添加手机联系人'),
    );

    Widget text = Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      alignment: Alignment.centerLeft,
      height: 35,
      child: const Text('三天前', style: TextStyle(color: Colors.grey)),
    );

    return Column(children: [
      searchBar,
      myCode,
      text,
    ]);
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: const Text('暂无数据', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.builder(
        itemCount: dataArr.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          WxNewFriendModel model = WxNewFriendModel.fromJson(dataArr[index]);
          return WxNewFriendCell(
            model: model,
            onClickCell: (model) {
              _clickCell(context, model['title']);
            },
            onClickBtn: (model) {
              _clickCell(context, '接受');
            },
          );
        },
      );
    }
  }

  // 点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 $text');
  }
}
