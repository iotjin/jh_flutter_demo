// ignore_for_file: unused_local_variable, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/project/configs/project_config.dart';
import 'http_page_test_cell.dart';
import 'http_page_test_model.dart';

const _headerHeight = 50.0;

// 3.x 版本 EasyRefresh
class HttpPageTestHeaderFollowPage extends StatefulWidget {
  const HttpPageTestHeaderFollowPage({Key? key}) : super(key: key);

  @override
  _HttpPageTestHeaderFollowPageState createState() => _HttpPageTestHeaderFollowPageState();
}

class _HttpPageTestHeaderFollowPageState extends State<HttpPageTestHeaderFollowPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  int _limit = 15;

  EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    _requestData(isShowLoading: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _requestData({isShowLoading = false, isLoadMore = false}) {
    _pageIndex = isLoadMore ? _pageIndex + 1 : 0;
    var params = {
      'page': _pageIndex,
      'limit': _limit,
    };
    var loadingText = isShowLoading == true ? 'Loading...' : null;
    HttpUtils.get(APIs.getPage, params, loadingText: loadingText, success: (res) {
      var tempData = res['data'];
      setState(() {
        if (isLoadMore) {
          _dataArr = _dataArr + tempData;
          _controller.finishLoad(tempData.length == _limit ? IndicatorResult.success : IndicatorResult.noMore);
        } else {
          _dataArr = tempData;
          _controller.finishRefresh();
          _controller.resetFooter();
        }
      });
    }, fail: (code, msg) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('分页加载 - header/footer跟随'),
      // body: _body(),
      body: _body2(),
    );
  }

  Widget _body() {
    return EasyRefresh(
      controller: _controller,
      header: _refreshHeader(),
      footer: _refreshFooter(),
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      child: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(child: _header()),
          _listWidget2(_dataArr),
          SliverToBoxAdapter(child: _footer()),
        ],
      ),
    );
  }

  Widget _body2() {
    return EasyRefresh.builder(
      controller: _controller,
      header: _refreshHeader(),
      footer: _refreshFooter(),
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView(
          physics: physics,
          children: [
            _header(),
            _listWidget(_dataArr),
            _footer(),
          ],
        );
      },
    );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.orange,
          height: _headerHeight,
          child: Text('header', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  Widget _footer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange,
      height: _headerHeight,
      child: Text('footer', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.length == 0) {
      return JhEmptyView();
      // return Container(
      //   alignment: Alignment.topCenter,
      //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      //   child: Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
      // );
    } else {
      return ListView.separated(
        // 加header要加上这两个属性
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // 加header要加上这两个属性
        itemCount: dataArr.length,
        itemBuilder: (context, index) {
          HttpPageTestModel model = HttpPageTestModel.fromJson(dataArr[index]);
          return HttPageTestCell(
            model: model,
            onClickCell: (model) {
              print('点击的index $index');
              print('点击的地点' + model['place']);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: .5, indent: 15, endIndent: 15, color: Colors.purple);
        },
      );
    }
  }

  Widget _listWidget2(List dataArr) {
    if (dataArr.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return JhEmptyView();
            // return Container(
            //   alignment: Alignment.topCenter,
            //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            //   child: Text("暂无数据", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
            // );
          },
          childCount: 1,
        ),
      );
    } else {
      // // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
      // return SliverFixedExtentList(
      //   delegate: SliverChildBuilderDelegate(
      //     (BuildContext context, int index) {
      //       // 列表cell
      //       HttpPageTestModel model = HttpPageTestModel.fromJson(dataArr[index]);
      //       return HttPageTestCell(
      //         model: model,
      //         onClickCell: (model) {
      //           print('点击的index $index');
      //           print('点击的地点' + model['place']);
      //         },
      //       );
      //     },
      //     childCount: dataArr.length,
      //   ),
      //   itemExtent: 48.0,
      // );
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // 列表cell
            HttpPageTestModel model = HttpPageTestModel.fromJson(_dataArr[index]);
            return HttPageTestCell(
              model: model,
              onClickCell: (model) {
                print('点击的index $index');
                print('点击的地点' + model['place']);
              },
            );
          },
          childCount: _dataArr.length,
        ),
      );
    }
  }

  _refreshHeader() {
    var header = BezierHeader(
      triggerOffset: 60,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      // 固定
      clamping: false,
      // 显示小球
      showBalls: false,
      // 弹簧回弹
      springRebound: false,
      spinWidget: SpinKitThreeBounce(size: 32, color: Colors.blue),
    );

    var materialHeader = MaterialHeader(triggerOffset: 60, clamping: false, showBezierBackground: false);
    var cupertinoHeader = CupertinoHeader();
    var deliveryHeader = DeliveryHeader();

    return materialHeader;
  }

  _refreshFooter() {
    var footer = BezierFooter(
      triggerOffset: 60,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      // 固定
      clamping: false,
      // 显示小球
      showBalls: false,
      // 弹簧回弹
      springRebound: false,
      spinWidget: SpinKitThreeBounce(size: 32, color: Colors.blue),
    );

    var materialFooter = MaterialFooter(triggerOffset: 60, clamping: false, showBezierBackground: false);
    var cupertinoFooter = CupertinoFooter();
    var deliveryFooter = DeliveryFooter();

    return materialFooter;
  }
}
