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
  const WxContactsPage({Key? key}) : super(key: key);

  @override
  State<WxContactsPage> createState() => _WxContactsPageState();
}

class _WxContactsPageState extends State<WxContactsPage> {
  List<WxContactsModel> _dataList = [];

  // 联系人总数
  String _contactsCount = '';

  final double _suspensionHeight = 40;
  final String _suspensionTag = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _requestData();
  }

  void _requestData() {
    JhProgressHUD.showLoadingText();
    Future.delayed(const Duration(milliseconds: 500), () {
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

    // 处理数据
    List<WxContactsModel> tempList = [];
    for (var item in dataArr) {
      // print('name: ${item['name']}');
      WxContactsModel model = WxContactsModel.fromJson(item);
      String pinyin = PinyinHelper.getPinyinE(model.name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      model.namePinyin = pinyin;
      if (model.isStar == true) {
        model.tagIndex = '★';
      } else if (RegExp('[A-Z]').hasMatch(tag)) {
        model.tagIndex = tag;
      } else {
        model.tagIndex = '#';
      }
      tempList.add(model);
    }

    // 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(tempList);

    // 把星标移到最前
    for (var item in tempList) {
      if (item.isStar == true) {
        tempList.remove(item);
        tempList.insert(0, item);
      }
    }

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(tempList);

    // add header.
    tempList.insert(0, WxContactsModel(name: 'header', tagIndex: '🔍'));

    _contactsCount = '${tempList.length} 位朋友及联系人';

    setState(() {
      _dataList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appbar = context.jhIsDark
        ? BaseAppBar(
            KStrings.twoTabTitle,
            bgColor: KColors.kNavBgDarkColor,
            leftWidget: Container(),
            rightImgPath: 'assets/images/tianjiahaoyou.png',
            rightItemCallBack: () => JhNavUtils.pushNamed(context, 'WxAddFriendPage'),
          )
        : GradientAppBar(
            KStrings.twoTabTitle,
            leftWidget: Container(),
            rightImgPath: 'assets/images/tianjiahaoyou.png',
            rightItemCallBack: () => JhNavUtils.pushNamed(context, 'WxAddFriendPage'),
          );

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
            _clickCell(itemData['title']);
          },
        );
      },
      physics: const BouncingScrollPhysics(),
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
      indexBarOptions: const IndexBarOptions(
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
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isFloat ? Colors.white : KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
        border: isFloat ? const Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5)) : null,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        susTag == '★' ? '★ 星标朋友' : susTag,
        softWrap: false,
        style: TextStyle(
          fontSize: 18,
          color: isFloat ? KColors.wxPayColor : const Color(0xff777777),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _clickCell(text) {
    // JhToast.showText(context, msg: '点击 $text');
    if (text == '新的朋友') {
      JhNavUtils.pushNamed(context, 'WxNewFriendPage');
    }
    if (text == '群聊') {
      JhNavUtils.pushNamed(context, 'WxGroupChatPage');
    }
  }
}
