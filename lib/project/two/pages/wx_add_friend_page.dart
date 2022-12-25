///  wx_add_friend_page.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 添加朋友

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/project/configs/project_config.dart';
import '../models/wx_add_friend_model.dart';
import '../widgets/wx_add_friend_cell.dart';

List _dataArr = [
  {
    'title': '雷达加朋友',
    'subtitle': '添加身边的朋友',
    'img': 'assets/wechat/contacts/add/add_friend_icon_reda_36x36_@3x.png',
  },
  {
    'title': '面对面建群',
    'subtitle': '与身边的朋友进入同一个群聊',
    'img': 'assets/wechat/contacts/add/add_friend_icon_addgroup_36x36_@3x.png',
  },
  {
    'title': '扫一扫',
    'subtitle': '扫描二维码名片',
    'img': 'assets/wechat/contacts/add/add_friend_icon_scanqr_36x36_@3x.png',
  },
  {
    'title': '手机联系人',
    'subtitle': '添加手机通讯录中的朋友',
    'img': 'assets/wechat/contacts/add/add_friend_icon_contacts_36x36_@3x.png',
  },
  {
    'title': '公众号',
    'subtitle': '获取更多资讯和服务',
    'img': 'assets/wechat/contacts/add/add_friend_icon_offical_36x36_@3x.png',
  },
  {
    'title': '企业微信联系人',
    'subtitle': '通过手机号搜索企业微信用户',
    'img': 'assets/wechat/contacts/add/add_friend_icon_search_wework_40x40_@2x.png',
  },
];

class WxAddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('添加朋友', bgColor: Colors.transparent),
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
    Widget _searchBar = JhSearchBar(
      hintText: '微信号/手机号',
      bgColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor),
    );
    Widget _myCode = Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('我的微信号：abc'),
          SizedBox(width: 10),
          Image.asset('assets/wechat/contacts/add/add_friend_myQR_20x20_@2x.png', width: 20)
        ],
      ),
    );

    return Column(children: [
      _searchBar,
      _myCode,
    ]);
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.length == 0) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Text('暂无数据', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.builder(
        itemCount: dataArr.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          WxAddFriendModel model = WxAddFriendModel.fromJson(dataArr[index]);
          return WxAddFriendCell(
            model: model,
            onClickCell: (model) {
              _clickCell(context, model['title']);
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
