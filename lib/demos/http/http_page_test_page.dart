import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/project/configs/project_config.dart';
import 'http_page_test_cell.dart';
import 'http_page_test_model.dart';

class HttpPageTestPage extends StatefulWidget {
  const HttpPageTestPage({Key? key}) : super(key: key);

  @override
  _HttpPageTestPageState createState() => _HttpPageTestPageState();
}

class _HttpPageTestPageState extends State<HttpPageTestPage> {
  EasyRefreshController _controller = EasyRefreshController();
  List _dataArr = [];
  int _pageIndex = 0;
  int _limit = 15;

  @override
  void initState() {
    super.initState();

    _requestData(isShowLoading: true);
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
      tempData = tempData.isNotEmpty ? tempData : [];
      setState(() {
        if (isLoadMore) {
          _dataArr = _dataArr + tempData;
          if (tempData.length == _limit) {
            _controller.finishLoad();
          } else {
            _controller.finishLoad(noMore: true);
          }
        } else {
          _dataArr = tempData;
          _controller.resetLoadState();
        }
      });
    }, fail: (code, msg) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('分页加载'),
      body: _body(),
    );
  }

  Widget _body() {
    return EasyRefresh(
      controller: _controller,
      header: DeliveryHeader(),
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      child: _listWidget(_dataArr),
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
}
