///  jh_multi_picker.dart
///
///  Created by iotjin on 2023/08/28.
///  description: 底部多选弹框

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';
import '/project/routes/jh_nav_utils.dart';

const String _labelKey = 'label';
const String _valueKey = 'value';
const String _titleText = '请选择';
const String _cancelText = '取消';
const String _confirmText = '确定';
const String _searchHintText = '搜索';

const double _headerHeight = 50.0;
const double _headerRadius = 10.0;
const double _headerLineHeight = 0.5;
const double _titleFontSize = 18.0;
const double _btnFontSize = 17.0;
const double _textFontSize = 16.0;

/// 选择回调，返回所有选中的values数组和所有item数组
typedef _ClickCallBack = void Function(dynamic selectValues, dynamic selectItemArr);

class JhMultiPicker {
  static bool _isShowPicker = false;

  static void show(
    BuildContext context, {
    required List data, // 数据源数组
    String labelKey = _labelKey, // 数据源数组的文字字段
    String valueKey = _valueKey, // 数据源数组的数值字段
    String title = _titleText,
    List values = const [], // 默认选中的数组(一维数组)，通过valuesKey确定是根据value还是label进行比较，最好使用唯一值作为元素
    String valuesKey = _valueKey, // 选中数组内元素使用的字段，对应valueKey或者labelKey
    bool isShowSearch = true,
    String searchHintText = _searchHintText,
    bool isShowRadius = true,
    _ClickCallBack? clickCallBack,
  }) {
    if (_isShowPicker || data.isEmpty) {
      return;
    }

    var radius = isShowRadius ? _headerRadius : 0.0;

    showModalBottomSheet<void>(
      context: context,
      // 使用true则高度不受16分之9的最高限制
      isScrollControlled: false,
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
          child: JhMultiPickerView(
            data: data,
            labelKey: labelKey,
            valueKey: valueKey,
            title: title,
            values: values,
            valuesKey: valuesKey,
            isShowSearch: isShowSearch,
            searchHintText: searchHintText,
            clickCallBack: clickCallBack,
          ),
        );
      },
    ).then((value) => _isShowPicker = false);
  }
}

class JhMultiPickerView extends StatefulWidget {
  const JhMultiPickerView({
    Key? key,
    required this.data,
    this.labelKey = _labelKey,
    this.valueKey = _valueKey,
    this.title = _titleText,
    this.values = const [],
    this.valuesKey = _valueKey,
    this.isShowSearch = true,
    this.searchHintText = _searchHintText,
    this.clickCallBack,
  }) : super(key: key);

  final List? data; // 数据源数组
  final String labelKey; // 数据源数组的文字字段
  final String valueKey; // 数据源数组的数值字段
  final String title;
  final List values; // 默认选中的数组(一维数组)，通过valuesKey确定是根据value还是label进行比较，最好使用唯一值作为元素
  final String valuesKey; // 选中数组内元素使用的字段，对应valueKey或者labelKey
  final bool isShowSearch;
  final String searchHintText;
  final _ClickCallBack? clickCallBack;

  @override
  State<JhMultiPickerView> createState() => _JhMultiPickerViewState();
}

class _JhMultiPickerViewState extends State<JhMultiPickerView> {
  late List<dynamic> _selectedValues = [];

  // 搜索数据
  List _searchData = [];
  bool _isShowSearchResult = false;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.values);
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    // 默认颜色
    var bgColor = KColors.dynamicColor(context, KColors.kPickerBgColor, KColors.kPickerBgDarkColor);
    var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor);

    return Container(
      color: bgColor,
      child: Column(
        children: <Widget>[
          _header(),
          SizedBox(height: _headerLineHeight, child: Container(color: lineColor)),
          _searchBar(),
          _mainWidget(),
        ],
      ),
    );
  }

  _header() {
    // 默认颜色
    var headerColor = KColors.dynamicColor(context, KColors.kPickerHeaderColor, KColors.kPickerHeaderDarkColor);
    var titleColor = KColors.dynamicColor(context, KColors.kPickerTitleColor, KColors.kPickerTitleDarkColor);
    var btnColor = KColors.dynamicColor(context, KColors.kPickerBtnColor, KColors.kPickerBtnDarkColor);

    return Container(
      height: _headerHeight,
      color: headerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(_cancelText, style: TextStyle(fontSize: _btnFontSize, color: btnColor)),
            ),
            onTap: () {
              widget.clickCallBack?.call([], []);
              JhNavUtils.goBack(context);
            },
          ),
          Text(widget.title, style: TextStyle(fontSize: _titleFontSize, color: titleColor)),
          GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(right: 15),
                child: Text(_confirmText, style: TextStyle(fontSize: _btnFontSize, color: btnColor)),
              ),
              onTap: () {
                widget.clickCallBack?.call(_selectedValues, _getSelectItemList());
                JhNavUtils.goBack(context);
              }),
        ],
      ),
    );
  }

  Widget _mainWidget() {
    List dataArr = _isShowSearchResult ? _searchData : (widget.data ?? []);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataArr.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(dataArr[index], index);
        },
      ),
    );
  }

  _buildItem(item, index) {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    var selectValue = widget.valuesKey == widget.valueKey ? item[widget.valueKey] : item[widget.labelKey];
    return CheckboxListTile(
      title: Text(item[widget.labelKey].toString(), style: const TextStyle(fontSize: _textFontSize)),
      value: _selectedValues.contains(selectValue),
      activeColor: themeColor,
      onChanged: (bool? checked) {
        setState(() {
          if (checked ?? false) {
            _selectedValues.add(selectValue);
          } else {
            _selectedValues.remove(selectValue);
          }
          // widget.clickCallBack?.call(_selectedValues, _getSelectItemList());
        });
      },
    );
  }

  _getSelectItemList() {
    var newList = (widget.data ?? []).where((item) => _selectedValues.contains(item[widget.valueKey])).toList();
    return newList;
  }

  Widget _searchBar() {
    Widget searchbar = JhSearchBar(
      hintText: widget.searchHintText,
      text: _searchKeyword,
      inputCallBack: (value) {
        JhCommonUtils.debounce(() {
          setState(() {
            _searchKeyword = value;
            if (value.isNotEmpty) {
              _searchData = _getSearchData(value);
              _isShowSearchResult = _searchData.isNotEmpty;
            } else {
              _isShowSearchResult = false;
            }
          });
        }, 500);
      },
    );
    return !widget.isShowSearch ? Container() : searchbar;
  }

  /// 根据搜索文字过滤数据
  _getSearchData(keyword) {
    var newList = (widget.data ?? [])
        .where((item) => item[widget.labelKey].toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return newList;
  }
}
