import 'package:flutter/material.dart';
import '/jh_common/widgets/base_refresh_view.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/configs/project_config.dart';

class BaseListViewTestPage extends StatefulWidget {
  const BaseListViewTestPage(
    this.jumpParams, {
    Key? key,
  }) : super(key: key);

  final dynamic jumpParams;

  @override
  State<BaseListViewTestPage> createState() => _BaseListViewTestPageState();
}

class _BaseListViewTestPageState extends State<BaseListViewTestPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  int _limit = 15;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();

    _isGridView = widget.jumpParams['isGridView'];

    Future.delayed(Duration(milliseconds: 100), () {
      _requestData(isShowLoading: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        _isGridView ? 'BaseGridView' : 'BaseListView',
        rightText: '空数据',
        rightItemCallBack: () {
          if (!mounted) return;
          setState(() {
            _dataArr = [];
          });
        },
      ),
      body: _isGridView ? _gridviewBody() : _listviewBody(),
    );
  }

  Widget _listviewBody() {
    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      // onLoad: _dataArr.length == 0 ? null : () async => _requestData(isLoadMore: true),
      itemBuilder: (context, index) => _itemWidget(index),
      separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
    );
  }

  Widget _gridviewBody() {
    Widget child;
    if (_dataArr.length == 0) {
      child = ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => JhEmptyView(),
      );
    } else {
      child = GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //可以直接指定每行（列）显示多少个Item
          crossAxisCount: 2, //一行的Widget数量
          crossAxisSpacing: 5, //水平间距
          mainAxisSpacing: 5, //垂直间距
          childAspectRatio: 1.0, //子Widget宽高比例
        ),
        //GridView内边距
        padding: EdgeInsets.all(5),
        itemCount: _dataArr.length,
        itemBuilder: (context, index) {
          return _itemWidget(index);
        },
      );
    }
    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      // onLoad: _dataArr.length == 0 ? null : () async => _requestData(isLoadMore: true),
      child: child,
    );
  }

  Widget _itemWidget(index) {
    return InkWell(
      child: Container(
        width: 100,
        height: 100,
        color: index % 2 == 0 ? Colors.red : Colors.yellow,
        child: Text(_dataArr[index]['title']),
      ),
      onTap: () => JhProgressHUD.showText(_dataArr[index]['title']),
    );
  }

  void _requestData({isShowLoading = false, isLoadMore = false}) {
    _pageIndex = isLoadMore ? _pageIndex + 1 : 0;
    var params = {
      'page': _pageIndex,
      'limit': _limit,
    };
    var loadingText = isShowLoading == true ? 'Loading...' : null;
    globalKeyRefresh.currentState?.jhRequestData(APIs.getPage, params, loadingText: loadingText, isLoadMore: isLoadMore,
        success: (res) {
      var tempData = res['data'];
      tempData = tempData.isNotEmpty ? tempData : [];
      if (!mounted) return;
      setState(() {
        if (isLoadMore) {
          _dataArr = _dataArr + tempData;
        } else {
          _dataArr = tempData;
        }
      });
    }, fail: (code, msg) {});
  }
}
