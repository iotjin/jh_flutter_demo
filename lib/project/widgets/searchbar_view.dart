///  searchbar_view.dart
///
///  Created by iotjin on 2023/09/13.
///  description:

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/project/configs/colors.dart';
import '/project/routes/jh_nav_utils.dart';

const String _hintText = 'keyword';
const EdgeInsetsGeometry _contentPadding = EdgeInsets.symmetric(vertical: 4);

class SearchBarView extends StatefulWidget {
  const SearchBarView({
    Key? key,
    this.text = '',
    this.hintText = _hintText,
    this.maxLength = 40,
    this.bgColor,
    this.isShowDeleteBtn = true,
    this.isShowBorder = true,
    this.contentPadding = _contentPadding,
    this.textInputAction = TextInputAction.search,
    this.focusNode,
    this.tapCallBack,
    this.inputCallBack,
    this.clickBtnCallBack,
  }) : super(key: key);

  final String text;
  final String hintText;
  final int maxLength; // 最大长度，默认40
  final Color? bgColor;
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认显示
  final bool isShowBorder; // 是否显示边框，默认不显示
  final EdgeInsetsGeometry contentPadding; // 当父组件固定高度时，文本一行显示文本过多会出现文字显示不全bug,可设置EdgeInsets.symmetric(vertical: 4)
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function()? tapCallBack;
  final void Function(String value)? inputCallBack;
  final void Function(String value)? clickBtnCallBack;

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  var _keyWord = '';

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    var searchBar = JhSearchBar(
      text: widget.text,
      hintText: widget.hintText,
      maxLength: widget.maxLength,
      textInputAction: TextInputAction.search,
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      inputCallBack: (value) {
        JhCommonUtils.debounce(() => _inputCallBack(value, false), 500);
      },
      inputCompletionCallBack: (value, isSubmitted) {
        if (isSubmitted) {
          JhCommonUtils.debounce(() => _inputCallBack(value, true), 500);
        }
      },
    );

    var viewBgColor = KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);

    return Row(
      children: [
        Expanded(
          child: searchBar,
        ),
        GestureDetector(
          child: Container(
            width: 50,
            height: 58,
            color: viewBgColor,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: const Icon(Icons.search, size: 30),
          ),
          onTap: () {
            _requestData(isShowLoading: true);
          },
        )
      ],
    );
  }

  _inputCallBack(value, isSubmitted) {
    var beforeKeyWord = _keyWord;
    setState(() {
      _keyWord = value;
      if (isSubmitted) {
        _requestData(isShowLoading: true);
      } else if (beforeKeyWord != _keyWord) {
        _searchCodeList(value);
      }
    });
  }

  _searchCodeList(value) {
    widget.inputCallBack?.call(value);
  }

  _requestData({isShowLoading = false}) {
    JhNavUtils.unFocus();
    widget.clickBtnCallBack?.call(_keyWord);
  }
}
