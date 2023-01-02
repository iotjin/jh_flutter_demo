///  wx_contacts_cell.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信通讯录 cell

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/project/configs/project_config.dart';
import '../models/wx_contacts_model.dart';

const double _cellHeight = 50;

class WxContactsCell extends StatelessWidget {
  const WxContactsCell({
    Key? key,
    required this.model,
    required this.index,
    required this.dataArr,
    required this.bottomContactsCountText,
    this.onClickCell,
    this.onClickTopCell,
  }) : super(key: key);

  final WxContactsModel model;
  final int index;
  final List dataArr;
  final String bottomContactsCountText;
  final Function(dynamic model)? onClickCell;
  final Function(dynamic model)? onClickTopCell;

  @override
  Widget build(BuildContext context) {
    if (index == 0) return _buildHeader(context);
    return _buildCell();
  }

  // 头部：新的朋友、群聊、标签、公众号
  Widget _buildHeader(context) {
    List _topData = [
      {
        'title': '新的朋友',
        'imgUrl': 'assets/wechat/contacts/ic_new_friend.png',
      },
      {
        'title': '群聊',
        'imgUrl': 'assets/wechat/contacts/ic_group_chat.png',
      },
      {
        'title': '标签',
        'imgUrl': 'assets/wechat/contacts/ic_tag.png',
      },
      {
        'title': '公众号',
        'imgUrl': 'assets/wechat/contacts/ic_public_account.png',
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
        clickCallBack: () => onClickTopCell?.call(itemData),
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

  // Cell
  Widget _buildCell() {
    String susTag = model.getSuspensionTag();
    double _cellH = _cellHeight;
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
      clickCallBack: () => onClickCell?.call(model.toJson()),
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
          offstage: dataArr[dataArr.length - 1].id != model.id,
          child: Container(
            width: double.infinity,
            height: _cellH,
            alignment: Alignment.center,
            child: Text(
              bottomContactsCountText,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
