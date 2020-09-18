/**
 *  two_page.dart
 *
 *  Created by iotjin on 2019/08/14.
 *  description:  通讯录
 */

import 'dart:convert';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_color_utils.dart';
import 'package:jh_flutter_demo/project/two/wx/mh_index_bar.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/strings.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/model/contacts_model.dart';

const Color bgColor = Colors.black87;
const double radius = 3.0;

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  List<ContactsModel> _dataList = List();

  // 联系人总数
  String _contactsCount = '';

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
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
    setState(() {});
  }

  void _handleList(List<ContactsModel> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
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
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_dataList);

    //把星标移到最前
    _dataList.forEach((item) {
      if (item.isStar == true) {
        _dataList.remove(item);
        _dataList.insert(0, item);
      }
    });

    _contactsCount = "${_dataList.length} 位朋友及联系人";
  }

  void _onSusTagChanged(String tag) {
//    print('tag: ${tag}');
    setState(() {
      _suspensionTag = tag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(context, KString.twoTabTitle,
          rightImgPath: 'assets/images/tianjiahaoyou.png',
          rightItemCallBack: () {
        NavigatorUtils.pushNamed(context, 'WxAddFriendPage');
      }),
      body: _body(),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }

  //body
  Widget _body() {
    return AzListView(
      data: _dataList,
      itemBuilder: (context, model) => _buildListItem(model),
      suspensionWidget: _buildSusWidget(_suspensionTag, isFloat: true),
      isUseRealIndex: true,
      itemHeight: _itemHeight,
      suspensionHeight: _suspensionHeight,
      onSusTagChanged: _onSusTagChanged,
      header: AzListViewHeader(
//          tag: "★",
          tag: "🔍",
          height: 55 * 4 + 60,
          builder: (context) {
            return _buildHeader();
          }),
      indexHintBuilder: (context, hint) {
        return Container(
          alignment: Alignment.center,
          width: 80.0,
          height: 80.0,
          decoration:
              BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
          child:
              Text(hint, style: TextStyle(color: Colors.white, fontSize: 30.0)),
        );
      },
//      //默认
//      indexBarBuilder: (BuildContext context, List<String> tags,
//          IndexBarTouchCallback onTouch) {
//        return Container(
//          color: Colors.transparent,
//          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//          child: IndexBar(
//            color: Colors.transparent,
//            touchDownColor: Colors.transparent,
//            data: tags,
//            itemHeight: 20,
//            onTouch: (details) {
//              onTouch(details);
//            },
//          ),
//        );
//      },

      //仿微信hint效果
      // 隐藏默认提供的
      showIndexHint: false,
      indexBarBuilder: (context, tagList, onTouch) {
        return _buildCustomIndexBarByBuilder(context, tagList, onTouch);
      },
    );
  }

  // 头部
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

    List<Widget> _topWidgetList =
        _topData.map((item) => _topCell(context, item)).toList();

    Widget _searchBar = Container(
      decoration: new BoxDecoration(
//        border: Border.all(color: Colors.grey, width: 0.3), //灰色的一层边框
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      height: 38,
      child: JhLoginTextField(
        leftWidget: Icon(Icons.search, size: 25),
        hintText: '搜索',
        isShowDeleteBtn: true,
        isDense: true,
        border: InputBorder.none,
      ),
    );

    _topWidgetList.insert(0, _searchBar);

    return Column(children: _topWidgetList);
  }

  // 吸顶组件
  Widget _buildSusWidget(String susTag, {bool isFloat = false}) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isFloat ? Colors.white : KColor.kWeiXinBgColor,
        border: isFloat
            ? Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5))
            : null,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '${susTag == '★' ? '★ 星标朋友' : susTag}',
        softWrap: false,
        style: TextStyle(
            fontSize: 18,
            color: isFloat ? KColor.kWeiXinPayColor : Color(0xff777777),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  //Cell
  Widget _buildListItem(ContactsModel model) {
    String susTag = model.getSuspensionTag();
    double _cellH = 50.0;
    double _leftSpace = 65.0;
    double _imgWH = 40;
    Widget _cell = JhSetCell(
      titleWidth: 200,
      leftImgWH: _imgWH,
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      title: model.name,
      hiddenArrow: true,
      leftWidget: Container(
        height: _imgWH,
        width: _imgWH,
        decoration: BoxDecoration(
          color: JhColorUtils.hexColor(model.color),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(model.name.substring(0, 1),
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      clickCallBack: () {
        //跳转个人信息页 跳转传递model
        String jsonStr = Uri.encodeComponent(jsonEncode(model));
        NavigatorUtils.pushNamed(
            context, '${"WxUserInfoPage"}?passValue=${jsonStr}');
      },
    );

    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        Slidable(
          actionPane: SlidableScrollActionPane(),
          //滑出选项的面板 动画
          actionExtentRatio: 0.2,
          child: _cell,
          //右侧按钮列表
          secondaryActions: <Widget>[
            SlideAction(
              color: Colors.black54,
              child: Text(
                '备注',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                JhToast.showText(context, msg: '点击备注');
              },
            ),
          ],
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
                  top: BorderSide(width: 0.5, color: KColor.kLineColor),
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
    // JhToast.showText(context, msg: '点击 ${text}');
    if (text == '新的朋友') {
      NavigatorUtils.pushNamed(context, 'WxNewFriendPage');
    }
    if (text == '群聊') {
      NavigatorUtils.pushNamed(context, 'WxGroupChatPage');
    }
  }

  /********************************* 仿微信hint ********************************/

  /// 🔥🔥🔥 构建自定义IndexBar by builder  使用Builder的形式控件 更加强大 更高定制度
  Widget _buildCustomIndexBarByBuilder(BuildContext context,
      List<String> tagList, IndexBarTouchCallback onTouch) {
    return MHIndexBar(
      data: tagList,
      tag: _suspensionTag,
      onTouch: onTouch,
      indexBarTagBuilder: (context, tag, indexModel) {
        return _buildIndexBarTagWidget(context, tag, indexModel);
      },
      indexBarHintBuilder: (context, tag, indexModel) {
        return _buildIndexBarHintWidget(context, tag, indexModel);
      },
    );
  }

  /// 构建tag
  Widget _buildIndexBarTagWidget(
      BuildContext context, String tag, IndexBarDetails indexModel) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: indexModel.tag == tag
            ? KColor.kWeiXinThemeColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
          color: indexModel.tag == tag ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      width: 16.0,
      height: 16.0,
    );
  }

  /// 构建Hint
  Widget _buildIndexBarHintWidget(
      BuildContext context, String tag, IndexBarDetails indexModel) {
    // 图片名
    return Positioned(
      left: -80,
      top: -(64 - 16) * 0.5,
      child: Offstage(
        offstage: _fetchOffstage(tag, indexModel),
        child: Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/wechat/contacts/contact_index_bar_bubble_0.png'),
              fit: BoxFit.contain,
            ),
          ),
          alignment: Alignment(-0.25, 0.0),
          child: _buildHintChildWidget(tag, indexModel),
        ),
      ),
    );
  }

  /// 构建某个hint中子部件
  Widget _buildHintChildWidget(String tag, IndexBarDetails indexModel) {
    return Text(
      tag,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // 获取Offstage 是否隐居幕后
  bool _fetchOffstage(String tag, IndexBarDetails indexModel) {
    if (indexModel.tag == tag) {
      final List<String> ignoreTags = [];
      return ignoreTags.indexOf(tag) != -1 ? true : !indexModel.isTouchDown;
    }
    return true;
  }

/********************************* 仿微信hint ********************************/

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
//          FlatButton(
//            child: Text("点击"),
//            onPressed: () {},
//          ),
//        ],
//      ),
//    ));
//  }
//}
