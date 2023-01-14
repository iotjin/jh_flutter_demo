///  wx_subscription_number_list_page.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号列表

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/project/configs/project_config.dart';
import '../models/wx_subscription_number_list_model.dart';
import '../widgets/wx_subscription_number_list_cell.dart';

var _dataArr = [];

List _getData() {
  _dataArr = [];
  for (int i = 0; i < 50; i++) {
    var map = <String, dynamic>{};
    map['title'] = 'title$i';
    map['subtitle'] = '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容';
    map['img'] = 'assets/images/ic_demo1.png';
    map['time'] = '17:30';
    _dataArr.add(map);
  }
  return _dataArr;
}

class WxSubscriptionNumberListPage extends StatefulWidget {
  const WxSubscriptionNumberListPage({Key? key}) : super(key: key);

  @override
  State<WxSubscriptionNumberListPage> createState() => _WxSubscriptionNumberListPageState();
}

class _WxSubscriptionNumberListPageState extends State<WxSubscriptionNumberListPage> {
  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        '订阅号',
        rightImgPath: 'assets/images/ic_more_black.png',
        bgColor: Colors.transparent,
        rightItemCallBack: () => _clickCell('更多'),
      ),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  // body
  Widget _body() {
    var dataArr = _dataArr;
    Widget searchBar = JhSearchBar(
      hintText: '微信号/手机号',
      bgColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor),
    );

    return ListView.separated(
      // 列表项构造器
      itemCount: dataArr.length + 1,
      // 分割器构造器
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          indent: 70,
          endIndent: 0,
          color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
        );
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return searchBar;
        }
        WxSubscriptionNumberListModel model = WxSubscriptionNumberListModel.fromJson(dataArr[index - 1]);
        return WxSubscriptionNumberListCell(
          model: model,
          onClickCell: (model) {
            _clickCell(model['title']);
          },
        );
      },
    );
  }

  // 点击cell
  _clickCell(text) {
    JhToast.showText(context, msg: '点击 $text');
  }

// // 点击侧滑按钮
// void _showSnackBar(text) {
//   print(text);
//   JhToast.showText(context, msg: text);
// }
}
