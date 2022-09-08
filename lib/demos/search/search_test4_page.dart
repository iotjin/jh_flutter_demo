import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../jh_common/widgets/Jh_highlight_text.dart';
import '/jh_common/jh_form/jh_searchbar.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/configs/project_config.dart';

const _headerHeight = 50.0;

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
    Future.delayed(Duration(seconds: 3), () {
      var tempArr = [];
      for (var i = 0; i < 20; i++) {
        tempArr.add({'id': i.toString() + '---' + _keyWord, 'name': 'name$i'});
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
      appBar: baseAppBar(
        context,
        'SearchTest4Page',
        isBack: true,
        bottom: PreferredSize(preferredSize: Size.fromHeight(_headerHeight), child: _header()),
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
        setState(() {
          _keyWord = value;
          if (value.length == 0) {
            _searchData = [];
          }
          if (value.length >= 3) {
            _requestKeywordList(value);
          }
        });
      },
      inputCompletionCallBack: (value, isSubmitted) {
        if (isSubmitted) {
          setState(() {
            _keyWord = value;
            _searchData = [];
            if (value.length >= 3) {
              _requestData(isShowLoading: true);
            }
          });
        }
      },
    );
  }

  Widget _body() {
    if (_searchData.length > 0) {
      return Container(
        child: ListView.builder(
          itemBuilder: (_, index) {
            return _searchResultItem(index);
          },
          itemCount: _searchData.length,
        ),
      );
    } else {
      return EasyRefresh(
        header: BallPulseHeader(),
        onRefresh: () async => _requestData(),
        child: _listWidget(_dataArr),
      );
    }
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.length == 0) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      );
    } else {
      return ListView.separated(
        itemCount: dataArr.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              var params = dataArr[index];
              print('params: $params');
              JhProgressHUD.showText(params['name']);
            },
            child: _cell(dataArr[index]),
          );
        },
        separatorBuilder: (context, index) => KStyles.cellLineStyle,
      );
    }
  }

  Widget _cell(item) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
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
                Container(
                  width: 60,
                  child: Text('Code:', style: KStyles.textBold15),
                ),
                Expanded(
                  child: Text(item['id'].toString()),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
        padding: EdgeInsets.symmetric(vertical: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: KColors.kLineColor, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: JhHighlightText(text: _searchData[index]['name'], highlightText: _keyWord),
            ),
            Icon(Icons.north_west, size: 15, color: Colors.black),
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
