import 'package:flutter/material.dart';
import '/jh_common/widgets/base_refresh_view.dart';
import '/jh_common/widgets/jh_shimmer_view.dart';
import '/project/configs/project_config.dart';

class BaseGridViewShimmerTestPage extends StatefulWidget {
  const BaseGridViewShimmerTestPage({Key? key}) : super(key: key);

  @override
  State<BaseGridViewShimmerTestPage> createState() => _BaseGridViewShimmerTestPageState();
}

class _BaseGridViewShimmerTestPageState extends State<BaseGridViewShimmerTestPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  int _limit = 15;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      _requestData(isShowLoading: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'BaseGridView - 骨架屏',
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

  Widget _body() {
    Widget child = GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 可以直接指定每行（列）显示多少个Item
        crossAxisCount: 2, // 一行的Widget数量
        crossAxisSpacing: 5, // 水平间距
        mainAxisSpacing: 5, // 垂直间距
        childAspectRatio: 1.0, // 子Widget宽高比例
      ),
      //GridView内边距
      padding: EdgeInsets.all(5),
      itemCount: _dataArr.length,
      itemBuilder: (context, index) {
        return _itemWidget(index);
      },
    );

    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      enableShimmer: true,
      shimmerView: JhShimmerView.gridShimmerView1(context),
      child: child,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
    );
  }

  Widget _itemWidget(index) {
    var cell = InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.red : Colors.yellow,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 5, top: 5),
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
