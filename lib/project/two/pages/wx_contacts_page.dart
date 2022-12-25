///  wx_contacts_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信通讯录

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';
import '/project/configs/project_config.dart';
import '../models/wx_contacts_model.dart';
import '../widgets/wx_contacts_cell.dart';

const Color bgColor = Colors.black87;
const double radius = 3.0;

class WxContactsPage extends StatefulWidget {
  @override
  _WxContactsPageState createState() => _WxContactsPageState();
}

class _WxContactsPageState extends State<WxContactsPage> {
  List<WxContactsModel> _dataList = [];

  // 联系人总数
  String _contactsCount = '';

  double _suspensionHeight = 40;
  String _suspensionTag = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _requestData();
  }

  void _requestData() {
    JhProgressHUD.showLoadingText();
    Future.delayed(Duration(milliseconds: 500), () {
      _loadData().then((value) {
        JhProgressHUD.hide();
      });
    });
  }

  Future<void> _loadData() async {
    // 获取用户信息列表
    final jsonStr = await rootBundle.loadString('lib/res/wx_contacts.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    dataArr.forEach((item) {
//      print('name: ${item['name']}');
//      _dataList.add(ContactsModel(name: item['name']));
      WxContactsModel model = WxContactsModel.fromJson(item);
      _dataList.add(model);
    });
    _handleList(_dataList);

//    print('_dataList=====');
//    _dataList.forEach((item) {
//      ContactsModel model = item;
//      print(model.toJson());
//    });
    setState(() {});
  }

  void _handleList(List<WxContactsModel> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (list[i].isStar == true) {
        list[i].tagIndex = '★';
      } else if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_dataList);

    // 把星标移到最前
    _dataList.forEach((item) {
      if (item.isStar == true) {
        _dataList.remove(item);
        _dataList.insert(0, item);
      }
    });

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_dataList);

    // add header.
    _dataList.insert(0, WxContactsModel(name: 'header', tagIndex: '🔍'));

    _contactsCount = '${_dataList.length} 位朋友及联系人';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    var appbar = isDark
        ? BaseAppBar(KStrings.twoTabTitle,
            bgColor: KColors.kNavBgDarkColor,
            leftWidget: Container(),
            rightImgPath: 'assets/images/tianjiahaoyou.png', rightItemCallBack: () {
            JhNavUtils.pushNamed(context, 'WxAddFriendPage');
          })
        : GradientAppBar(KStrings.twoTabTitle, leftWidget: Container(), rightImgPath: 'assets/images/tianjiahaoyou.png',
            rightItemCallBack: () {
            JhNavUtils.pushNamed(context, 'WxAddFriendPage');
          });

    return Scaffold(
      appBar: appbar as PreferredSizeWidget,
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor),
    );
  }

  // body
  Widget _body() {
    return AzListView(
      data: _dataList,
      itemCount: _dataList.length,
      itemBuilder: (BuildContext context, int index) {
        WxContactsModel model = _dataList[index];
        return WxContactsCell(
          model: model,
          index: index,
          dataArr: _dataList,
          bottomContactsCountText: _contactsCount,
          onClickCell: (model) {
            // 跳转个人信息页
            JhNavUtils.pushNamed(context, 'WxUserInfoPage', arguments: model);
          },
          onClickTopCell: (itemData) {
            _clickCell(context, itemData['title']);
          },
        );
      },
      physics: BouncingScrollPhysics(),
      susItemHeight: _suspensionHeight,
      susItemBuilder: (BuildContext context, int index) {
        WxContactsModel model = _dataList[index];
        String tag = model.getSuspensionTag();
        if ('🔍' == model.getSuspensionTag()) {
          return Container();
        }
        return _buildSusWidget(tag, isFloat: false);
      },
      indexBarData: SuspensionUtil.getTagIndexList(_dataList),
      indexBarOptions: IndexBarOptions(
        needRebuild: true,
        ignoreDragCancel: true,
        selectTextStyle: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        selectItemDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        indexHintWidth: 120 / 2,
        indexHintHeight: 100 / 2,
        indexHintDecoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wechat/contacts/ic_index_bar_bubble_gray.png'),
            fit: BoxFit.contain,
          ),
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintTextStyle: TextStyle(color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.w700),
        indexHintChildAlignment: Alignment(-0.25, 0.0),
        indexHintOffset: Offset(-10, 0),
      ),
    );
  }

  // 吸顶组件
  Widget _buildSusWidget(String susTag, {bool isFloat = false}) {
    return Container(
      height: _suspensionHeight,
      width: JhScreenUtils.screenWidth,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isFloat ? Colors.white : KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
        border: isFloat ? Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5)) : null,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '${susTag == '★' ? '★ 星标朋友' : susTag}',
        softWrap: false,
        style: TextStyle(
            fontSize: 18, color: isFloat ? KColors.wxPayColor : Color(0xff777777), fontWeight: FontWeight.bold),
      ),
    );
  }

  void _clickCell(context, text) {
    // JhToast.showText(context, msg: '点击 $text');
    if (text == '新的朋友') {
      JhNavUtils.pushNamed(context, 'WxNewFriendPage');
    }
    if (text == '群聊') {
      JhNavUtils.pushNamed(context, 'WxGroupChatPage');
    }
  }
}
