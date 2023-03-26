///  jh_cascade_picker.dart
///
///  Created by iotjin on 2022/07/23.
///  description: 级联选择器（多维数组结构数据）

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';
import '/project/routes/jh_nav_utils.dart';

const String _labelKey = 'label';
const String _titleText = '请选择';
const String _tabText = '请选择';
const double _headerHeight = 50.0;
const double _headerRadius = 10.0;
const double _lineHeight = 0.5;
const double _itemHeight = 50.0;
const double _titleFontSize = 18.0;
const double _textFontSize = 16.0;

class JhCascadePicker {
  static bool _isShowPicker = false;

  static void show(
    BuildContext context, {
    required List data, // 多维数组，根据维数决定列数
    String labelKey = _labelKey, // 对象数组的文字字段
    String title = _titleText,
    String tabText = _tabText,
    bool isShowRadius = true,
    Function(dynamic selectValue)? clickCallBack, // 选择回调，返回选中对象
  }) {
    if (_isShowPicker || data.isEmpty) {
      return;
    }
    _isShowPicker = true;
    var radius = isShowRadius ? _headerRadius : 0.0;

    showModalBottomSheet<void>(
      context: context,
      // 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      // 设置圆角
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return SafeArea(
          child: JhCascadePickerView(
            data: data,
            labelKey: labelKey,
            title: title,
            tabText: tabText,
            clickCallBack: clickCallBack,
          ),
        );
      },
    ).then((value) => _isShowPicker = false);
  }
}

class JhCascadePickerView extends StatefulWidget {
  const JhCascadePickerView({
    Key? key,
    required this.data,
    this.labelKey = _labelKey,
    this.title = _titleText,
    this.tabText = _tabText,
    this.clickCallBack,
  }) : super(key: key);

  final List? data; // 多维数组，根据维数决定列数
  final String labelKey; // 对象数组的文字字段
  final String title;
  final String tabText;
  final Function(dynamic selectValue)? clickCallBack; // 选择回调，返回选中对象

  @override
  State<JhCascadePickerView> createState() => _JhCascadePickerViewState();
}

class _JhCascadePickerViewState extends State<JhCascadePickerView> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  // TabBar 数组
  final List<Tab> _myTabs = <Tab>[];

  // 当前列表数据
  List _mList = [];

  // 多级联动选择的position
  final List<int> _positions = [];

  // 索引
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _initData();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initData() {
    if (widget.data != null) {
      List dataArr = widget.data!;
      for (int i = 0; i < dataArr.length; i++) {
        _myTabs.add(Tab(text: i == 0 ? widget.tabText : ''));
        _positions.add(0);
      }
      _mList = dataArr[0];
      _tabController = TabController(vsync: this, length: dataArr.length);
      _tabController?.animateTo(_index, duration: Duration.zero);
    }
  }

  void _setIndex(int index) {
    _index = index;
  }

  void _indexIncrement() {
    _index++;
  }

  /// tabBar点击后更新数据
  void _setList(int index) {
    if (widget.data != null) {
      List dataArr = widget.data!;
      if (dataArr.length > index) {
        _mList = dataArr[index];
      }
    }
  }

  /// 选项点击后设置下一级数据并改变tabBar
  void _setListAndChangeTab() {
    // 这里的index已经+1
    if (widget.data != null) {
      List dataArr = widget.data!;
      if (dataArr.length > _index - 1 && dataArr.length != _index) {
        _mList = dataArr[_index];
        _myTabs.asMap().forEach((i, e) {
          if (i > _index - 1) {
            if (i == _index) {
              _myTabs[i] = Tab(text: widget.tabText);
            } else {
              _myTabs[i] = const Tab(text: '');
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 默认颜色
    var bgColor = KColors.dynamicColor(context, KColors.kPickerBgColor, KColors.kPickerBgDarkColor);
    var headerColor = KColors.dynamicColor(context, KColors.kPickerHeaderColor, KColors.kPickerHeaderDarkColor);
    var titleColor = KColors.dynamicColor(context, KColors.kPickerTitleColor, KColors.kPickerTitleDarkColor);
    var lineColor = KColors.dynamicColor(context, KColors.kPickerHeaderLineColor, KColors.kPickerHeaderLineDarkColor);
    var textColor = KColors.dynamicColor(context, KColors.kPickerTextColor, KColors.kPickerTextDarkColor);

    return Container(
      color: bgColor,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 11.0 / 16.0,
          child: Stack(
            children: [
              // header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: _headerHeight,
                  color: headerColor,
                  alignment: Alignment.center,
                  child: Text(widget.title, style: TextStyle(fontSize: _titleFontSize, color: titleColor)),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () => JhNavUtils.goBack(context),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: _headerHeight,
                    width: _headerHeight * 2,
                    child: Icon(
                      Icons.close,
                      color: titleColor,
                    ),
                  ),
                ),
              ),
              _mainWidget(bgColor, textColor, lineColor),
            ],
          )),
    );
  }

  Widget _mainWidget(Color bgColor, Color textColor, Color lineColor) {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var indicatorColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var labelColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var unselectedLabelColor = KColors.dynamicColor(context, KColors.kBlackTextColor, KColors.kBlackTextDarkColor);

    return Container(
      margin: const EdgeInsets.only(top: _headerHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: _lineHeight, child: Container(color: lineColor)),
          Container(
            color: bgColor,
            child: TabBar(
              // key: UniqueKey(),
              tabs: _myTabs,
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              indicatorColor: indicatorColor,
              onTap: (index) {
                if ((_myTabs[index].text ?? '').isEmpty) {
                  // 拦截点击事件
                  _tabController?.animateTo(_index);
                  return;
                }
                setState(() {
                  _setList(index);
                  _setIndex(index);
                  _scrollController.animateTo(
                    _positions[_index] * _itemHeight,
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.ease,
                  );
                });
              },
            ),
          ),
          SizedBox(height: _lineHeight, child: Container(color: lineColor)),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemExtent: _itemHeight,
              itemBuilder: (_, index) {
                return _buildItem(index, bgColor, textColor, labelColor);
              },
              itemCount: _mList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(int index, Color bgColor, Color textColor, Color themeColor) {
    final bool flag = _mList[index][widget.labelKey] == _myTabs[_index].text;
    return InkWell(
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Text(
              _mList[index][widget.labelKey],
              style: TextStyle(fontSize: _textFontSize, color: flag ? themeColor : textColor),
            ),
            const SizedBox(width: 8),
            Visibility(
              visible: flag,
              child: Icon(Icons.check, size: 15, color: themeColor),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _myTabs[_index] = Tab(text: _mList[index][widget.labelKey]);
          _positions[_index] = index;
          _indexIncrement();
          _setListAndChangeTab();
          if (_index > widget.data!.length - 1) {
            _setIndex(widget.data!.length - 1);
            // 只取最后一级
            // widget.clickCallBack?.call(_mList[index]);

            // 取所有
            var selectArr = [];
            for (int i = 0; i < _positions.length; i++) {
              selectArr.add(widget.data![i][_positions[i]]);
            }

            widget.clickCallBack?.call(selectArr);
            JhNavUtils.goBack(context);
          }
          _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 100), curve: Curves.ease);
          _tabController?.animateTo(_index);
        });
      },
    );
  }
}
