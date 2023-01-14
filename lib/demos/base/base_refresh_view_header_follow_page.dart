import 'package:flutter/material.dart';
import '/jh_common/widgets/base_refresh_view.dart';
import '/jh_common/widgets/jh_shimmer_view.dart';
import '/project/configs/project_config.dart';

const _headerHeight = 50.0;

class BaseRefreshViewHeaderFollowPage extends StatefulWidget {
  const BaseRefreshViewHeaderFollowPage({Key? key}) : super(key: key);

  @override
  State<BaseRefreshViewHeaderFollowPage> createState() => _BaseRefreshViewHeaderFollowPageState();
}

class _BaseRefreshViewHeaderFollowPageState extends State<BaseRefreshViewHeaderFollowPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  final int _limit = 15;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      _requestData(isShowLoading: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'BaseRefreshView - header/footer跟随',
        titleWidget: const TwoLinesTitle(title: 'BaseRefreshView', subtitle: 'header/footer跟随'),
        rightText: '空数据',
        rightItemCallBack: () {
          if (!mounted) return;
          setState(() {
            _dataArr = [];
          });
        },
      ),
      body: _body(),
    );
  }

  Widget _header() {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        color: Colors.orange,
        height: _headerHeight,
        child: const Text('header', style: TextStyle(color: Colors.white)),
      )
    ]);
  }

  Widget _footer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange,
      height: _headerHeight,
      child: const Text('footer', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _listView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dataArr.length,
      itemBuilder: (context, index) {
        return _itemWidget(index);
      },
      separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
    );
  }

  Widget _body() {
    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      enableShimmer: true,
      shimmerView: JhShimmerView.listShimmerView1(context),
      headerView: _header(),
      footerView: _footer(),
      emptyText: '暂无数据',
      refreshType: RefreshType.material,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      child: _listView(),

      /// child: _listView() 等同于下面两行代码
      // itemBuilder: (context, index) => _itemWidget(index),
      // separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
    );
  }

  Widget _itemWidget(index) {
    var cell = InkWell(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.red : Colors.yellow,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: Text(_dataArr[index]['title']),
        ),
      ),
      onTap: () => JhProgressHUD.showText(_dataArr[index]['title']),
    );
    return cell;
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
