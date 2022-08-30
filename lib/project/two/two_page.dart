///  two_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description:  通讯录

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:lpinyin/lpinyin.dart';
import '/jh_common/utils/jh_color_utils.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/project/configs/project_config.dart';
import '/project/model/contacts_model.dart';

const Color bgColor = Colors.black87;
const double radius = 3.0;

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  List<ContactsModel> _dataList = [];

  // 联系人总数
  String _contactsCount = '';

  double _suspensionHeight = 40;
  double _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  void _loadData() async {
    // 获取用户信息列表
    final jsonStr = await rootBundle.loadString('lib/res/wx_contacts.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    dataArr.forEach((item) {
//      print('name: ${item['name']}');
//      _dataList.add(ContactsModel(name: item['name']));
      ContactsModel model = ContactsModel.fromJson(item);
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

  void _handleList(List<ContactsModel> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (list[i].isStar == true) {
        list[i].tagIndex = "★";
      } else if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
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
    _dataList.insert(0, ContactsModel(name: 'header', tagIndex: '🔍'));

    _contactsCount = "${_dataList.length} 位朋友及联系人";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: isDark
          ? baseAppBar(context, KStrings.twoTabTitle,
              backgroundColor: KColors.kNavBgDarkColor,
              rightImgPath: 'assets/images/tianjiahaoyou.png', rightItemCallBack: () {
              JhNavUtils.pushNamed(context, 'WxAddFriendPage');
            })
          : gradientAppBar(context, KStrings.twoTabTitle, rightImgPath: 'assets/images/tianjiahaoyou.png',
              rightItemCallBack: () {
              JhNavUtils.pushNamed(context, 'WxAddFriendPage');
            }),
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
        if (index == 0) return _buildHeader();
        ContactsModel model = _dataList[index];
        return _buildListItem(model);
      },
      physics: BouncingScrollPhysics(),
      susItemHeight: _suspensionHeight,
      susItemBuilder: (BuildContext context, int index) {
        ContactsModel model = _dataList[index];
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

  // 头部：新的朋友、群聊、标签、公众号
  Widget _buildHeader() {
    List _topData = [
      {
        "title": "新的朋友",
        "imgUrl": "assets/wechat/contacts/ic_new_friend.png",
      },
      {
        "title": "群聊",
        "imgUrl": "assets/wechat/contacts/ic_group_chat.png",
      },
      {
        "title": "标签",
        "imgUrl": "assets/wechat/contacts/ic_tag.png",
      },
      {
        "title": "公众号",
        "imgUrl": "assets/wechat/contacts/ic_public_account.png",
      },
    ];

    Widget _topCell(context, itemData) {
      double _cellH = 55.0;
      double _leftSpace = 65.0;
      double _imgWH = 40;

      return JhSetCell(
        leftImgWH: _imgWH,
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        title: itemData['title'],
        hiddenArrow: true,
        leftWidget: Container(
          height: _imgWH,
          width: _imgWH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                itemData['imgUrl'],
              ),
            ),
          ),
        ),
        clickCallBack: () => _clickCell(context, itemData['title']),
      );
    }

    List<Widget> _topWidgetList = _topData.map((item) => _topCell(context, item)).toList();

    Widget _searchBar = JhSearchBar(
      hintText: '搜索',
      bgColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor),
      textInputAction: TextInputAction.search,
      inputCompletionCallBack: (value, isSubmitted) {
        print('inputCompletionCallBack: $value / $isSubmitted ');
      },
    );

    _topWidgetList.insert(0, _searchBar);

    return Column(children: _topWidgetList);
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

  // Cell
  Widget _buildListItem(ContactsModel model) {
    String susTag = model.getSuspensionTag();
    double _cellH = _itemHeight;
    double _leftSpace = 65.0;
    double _imgWH = 40;
    Widget _cell = JhSetCell(
      titleWidth: 200,
      leftImgWH: _imgWH,
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      title: model.name!,
      hiddenArrow: true,
      leftWidget: Container(
        height: _imgWH,
        width: _imgWH,
        decoration: BoxDecoration(
          color: JhColorUtils.hexColor(model.color!),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(model.name!.substring(0, 1), style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      clickCallBack: () {
        // 跳转个人信息页 跳转传递model
        String jsonStr = Uri.encodeComponent(jsonEncode(model));
        JhNavUtils.pushNamed(context, '${"WxUserInfoPage"}?passValue=$jsonStr');
      },
    );

    return Column(
      children: <Widget>[
//        Offstage(
//          offstage: !model.isShowSuspension,
//          child: _buildSusWidget(susTag),
//        ),
        Slidable(
          child: _cell,
          // 右侧按钮列表
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              CustomSlidableAction(
                backgroundColor: Colors.black54,
                child: Text(
                  '备注',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: (context) {
                  JhToast.showText(context, msg: '点击备注');
                },
              ),
            ],
          ),
        ),
        Offstage(
          offstage: _dataList[_dataList.length - 1].id != model.id,
          child: Container(
            width: double.infinity,
            height: _cellH,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 0.5, color: KColors.kLineColor),
                )),
            child: Text(
              _contactsCount,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ],
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

//class BaseScrollView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scrollbar(
//        child: SingleChildScrollView(
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 1500,
//            width: double.infinity,
//            color: Colors.white,
//            child: Text("往下滑动"),
//          ),
//          RichText(
//            text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
//                children: <InlineSpan>[
//                  TextSpan(text: '登录即视为同意'),
//                  TextSpan(
//                    text: '《xxx服务协议》',
//                    style: TextStyle(color: Colors.red),
//                    recognizer: new TapGestureRecognizer()
//                      ..onTap = () => print('Tap Here onTap'),
//                  ),
//                ]),
//          ),
//          Text("data"),
//          Text("data"),
//          Text("data"),
//          Text("data"),
//          Text("data"),
//        ],
//      ),
//    ));
//  }
//}
