// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';
import '/project/configs/project_config.dart';
import '/project/two/models/wx_contacts_model.dart';

const Color bgColor = Colors.black87;
const double radius = 3.0;

class CitySelectListPage extends StatefulWidget {
  const CitySelectListPage({Key? key}) : super(key: key);

  @override
  State<CitySelectListPage> createState() => _CitySelectListPageState();
}

class _CitySelectListPageState extends State<CitySelectListPage> {
  final List<WxContactsModel> _cityList = [];
  final double _suspensionHeight = 40;
  final double _itemHeight = 50;
  final String _suspensionTag = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  void _loadData() async {
    //加载城市列表
    rootBundle.loadString('lib/res/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      for (var item in list) {
//        print('name: ${item['name']}');
        _cityList.add(WxContactsModel(name: item['name']));
      }
      _handleList(_cityList);
      setState(() {});
    });
  }

  void _handleList(List<WxContactsModel> list) {
//    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_cityList);

    // add header.
    _cityList.insert(0, WxContactsModel(name: 'header', tagIndex: '★'));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar('城市选择列表', rightText: '选择', rightItemCallBack: () {
        print('object: ');
      }),
      body: SafeArea(
        child: _body(),
      ),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        ListTile(
            title: const Text('当前城市'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.place, size: 20.0),
                Text(' 成都市'),
              ],
            )),
        const Divider(height: .0),
        Expanded(
          flex: 1,
          child: AzListView(
            data: _cityList,
            itemCount: _cityList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return _buildHeader();
              WxContactsModel model = _cityList[index];
              return _buildListItem(model);
            },
            susItemHeight: _suspensionHeight,
            susItemBuilder: (BuildContext context, int index) {
              WxContactsModel model = _cityList[index];
              String tag = model.getSuspensionTag();
              if ('★' == model.getSuspensionTag()) {
                return Container();
              }
              return _buildSusWidget(tag);
            },
            indexBarData: SuspensionUtil.getTagIndexList(_cityList),
            // indexBarOptions: IndexBarOptions(
            //   needRebuild: true,
            //   color: Colors.transparent,
            //   downColor: Color(0xFFEEEEEE), //local images.
            // ),
            indexHintBuilder: (context, hint) {
              return Container(
                alignment: Alignment.center,
                width: 80.0,
                height: 80.0,
                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                child: Text(hint, style: const TextStyle(color: Colors.white, fontSize: 30.0)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    List<WxContactsModel> hotCityList = [];
    hotCityList.addAll([
      WxContactsModel(name: '北京市'),
      WxContactsModel(name: '广州市'),
      WxContactsModel(name: '成都市'),
      WxContactsModel(name: '深圳市'),
      WxContactsModel(name: '杭州市'),
      WxContactsModel(name: '武汉市'),
    ]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.center,
        spacing: 10.0,
        children: hotCityList.map((e) {
          return TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              print('OnItemClick: ${e.name}');
//              Navigator.pop(context, e);
            },
            child: Text(e.name!),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight,
      width: JhScreenUtils.screenWidth,
      padding: const EdgeInsets.only(left: 15.0),
      color: const Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        susTag,
        softWrap: false,
        style: const TextStyle(fontSize: 14.0, color: Color(0xff999999)),
      ),
    );
  }

  Widget _buildListItem(WxContactsModel model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
//        Offstage(
//          offstage: !model.isShowSuspension,
//          child: _buildSusWidget(susTag),
//        ),
        SizedBox(
          height: _itemHeight,
          child: ListTile(
            title: Text(model.name!),
            onTap: () {
              print('OnItemClick: ${model.name}');
            },
          ),
        )
      ],
    );
  }
}
