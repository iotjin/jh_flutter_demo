// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/widgets/jh_highlight_text.dart';
import '/project/configs/project_config.dart';

class SearchTest4Page extends StatefulWidget {
  const SearchTest4Page({Key? key}) : super(key: key);

  @override
  State<SearchTest4Page> createState() => _SearchTest4PageState();
}

class _SearchTest4PageState extends State<SearchTest4Page> {
  List _dataArr = [];
  List _searchData = [];
  var _keyWord = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _requestData({isShowLoading = false}) {
    // var params = {
    //   'keyWord': _keyWord,
    //   'id': '123',
    // };

    if (isShowLoading) {
      JhProgressHUD.showLoadingText();
    }
    Future.delayed(const Duration(seconds: 3), () {
      var tempArr = [];
      for (var i = 0; i < 20; i++) {
        tempArr.add({'id': '$i---$_keyWord', 'name': 'name$i'});
      }
      setState(() {
        _dataArr = tempArr;
      });
      if (isShowLoading) {
        JhProgressHUD.hide();
      }
    });
  }

  void _requestKeywordList(filter) {
    // var params = {
    //   'filter': filter,
    // };

    var tempArr = [];
    for (var i = 0; i < 20; i++) {
      tempArr.add({'name': filter + i.toString()});
    }
    setState(() {
      _searchData = tempArr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        '搜索框4-带防抖节流',
        bottomWidget: PreferredSize(preferredSize: const Size.fromHeight(kSearchViewHeight), child: _header()),
      ),
      body: _body(),
      // backgroundColor: KColors.kBgColor,
    );
  }

  Widget _header() {
    return JhSearchBar(
      text: _keyWord,
      hintText: 'code',
      maxLength: 140,
      textInputAction: TextInputAction.search,
      inputCallBack: (value) {
        print('未处理1 value : $value');
        JhCommonUtils.debounce(() => _inputCallBack(value, false), 500);
      },
      inputCompletionCallBack: (value, isSubmitted) {
        print('未处理2 value : $value');
        if (isSubmitted) {
          print('未处理3 value : $value');
          JhCommonUtils.debounce(() => _inputCallBack(value, true), 500);
        }
      },
    );
  }

  _inputCallBack(value, isSubmitted) {
    print('防抖后 value : $value');
    var beforeKeyWord = _keyWord;
    setState(() {
      _keyWord = value;
      if (value.isEmpty || isSubmitted) {
        _searchData = [];
      }
      if (value.length >= 3) {
        if (isSubmitted) {
          _requestData(isShowLoading: true);
        } else if (beforeKeyWord != _keyWord) {
          _requestKeywordList(value);
        }
      }
    });
  }

  Widget _body() {
    if (_searchData.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (_, index) {
          return _searchResultItem(index);
        },
        itemCount: _searchData.length,
      );
    } else {
      return EasyRefresh(
        onRefresh: () async => _requestData(),
        child: _listWidget(_dataArr),
      );
    }
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: const Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.separated(
        itemCount: dataArr.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: JhCommonUtils.throttle2(() {
              var params = dataArr[index];
              print('params: $params');
              JhProgressHUD.showText(params['name']);
            }, 3000),
            child: _cell(dataArr[index]),
          );
        },
        separatorBuilder: (context, index) => KStyles.cellLineStyle,
      );
    }
  }

  Widget _cell(item) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, // 阴影颜色
              spreadRadius: 1.5, // 阴影浓度
              blurRadius: 1.5, // 阴影范围
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('Code:', style: KStyles.textBold15),
                ),
                Expanded(
                  child: Text(item['id'].toString()),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('Name:', style: KStyles.textBold15),
                ),
                Expanded(
                  child: Text(item['name']),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _searchResultItem(index) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: KColors.kLineColor, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: JhHighlightText(text: _searchData[index]['name'], highlightText: _keyWord),
            ),
            const Icon(Icons.north_west, size: 15, color: Colors.black),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _keyWord = _searchData[index]['name'];
          _searchData = [];
          JhNavUtils.unFocus();
          _requestData(isShowLoading: true);
        });
      },
    );
  }
}
