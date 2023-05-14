import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/project_config.dart';
import '../http/http_page_test_cell.dart';
import '../http/http_page_test_model.dart';

const _headerHeight = 50.0;

Widget buildListView() {
  return ListView.builder(
    padding: const EdgeInsets.all(10),
    itemCount: 150,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(KStrings.avatarImage),
        ),
        title: Text('这是一条消息，来自Flutter - $index'),
        subtitle: const Text('20分钟前'),
      );
    },
  );
}

Widget buildGridView() {
  return GridView.builder(
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: 119,
    itemBuilder: (context, index) {
      return JhNetworkImage('${KStrings.avatarImage}?random=$index');
    },
  );
}

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _HttpPageTestHeaderFollowPageState();
}

class _HttpPageTestHeaderFollowPageState extends State<ContentPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _dataArr = [];
  int _pageIndex = 0;
  final int _limit = 15;

  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  // final ScrollController _scrollController = ScrollController();

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
    }, fail: (code, msg) {
      if (isLoadMore) {
        _controller.finishLoad();
      } else {
        _controller.finishRefresh();
        _controller.resetFooter();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return EasyRefresh.builder(
      controller: _controller,
      header: _refreshHeader(),
      footer: _refreshFooter(),
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView(
          padding: const EdgeInsets.all(0),
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
          child: const Text('header', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  Widget _footer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange,
      height: _headerHeight,
      child: const Text('footer', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _listWidget(List dataArr) {
    if (dataArr.isEmpty) {
      return const JhEmptyView();
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(0),
        // 加header要加上这两个属性
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // 加header要加上这两个属性
        itemCount: dataArr.length,
        itemBuilder: (context, index) {
          HttpPageTestModel model = HttpPageTestModel.fromJson(dataArr[index]);
          return HttPageTestCell(
            model: model,
            onClickCell: (model) {
              debugPrint('点击的index $index');
              debugPrint('点击的地点${model['place']}');
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: .5, indent: 15, endIndent: 15, color: Colors.purple);
        },
      );
    }
  }

  _refreshHeader() {
    var materialHeader = const MaterialHeader(triggerOffset: 60, clamping: false, showBezierBackground: false);
    return materialHeader;
  }

  _refreshFooter() {
    var materialFooter = const MaterialFooter(triggerOffset: 60, clamping: false, showBezierBackground: false);
    return materialFooter;
  }
}
