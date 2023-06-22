// ignore_for_file: avoid_print
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/jh_common/widgets/jh_tabbar.dart';
import '/project/configs/project_config.dart';
import '../http/http_page_test_cell.dart';
import '../http/http_page_test_model.dart';

const _headerHeight = 50.0;

class PersonalCenterPage3 extends StatefulWidget {
  const PersonalCenterPage3({Key? key}) : super(key: key);

  @override
  State<PersonalCenterPage3> createState() => _PersonalCenterPage3State();
}

class _PersonalCenterPage3State extends State<PersonalCenterPage3> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<JhTabBarModel> model = [
    const JhTabBarModel(title: '标题一'),
    const JhTabBarModel(title: '标题二'),
  ];

  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  final int _limit = 15;
  List _dataArr = [];
  int _pageIndex = 0;

  List _dataArr2 = [];
  int _pageIndex2 = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: model.length, vsync: this);
    _requestData(isShowLoading: true);
  }

  void _requestData({isShowLoading = false, isLoadMore = false}) {
    int currentIndex = _tabController.index;

    var params = {'limit': _limit};
    if (currentIndex == 0) {
      _pageIndex = isLoadMore ? _pageIndex + 1 : 0;
      params = {'page': _pageIndex, 'limit': _limit};
    } else {
      _pageIndex2 = isLoadMore ? _pageIndex2 + 1 : 0;
      params = {'page': _pageIndex2, 'limit': _limit};
    }

    var loadingText = isShowLoading == true ? 'Loading...' : null;
    HttpUtils.get(APIs.getPage, params, loadingText: loadingText, success: (res) {
      var tempData = res['data'];
      setState(() {
        if (isLoadMore) {
          if (currentIndex == 0) {
            _dataArr = _dataArr + tempData;
          } else {
            _dataArr2 = _dataArr2 + tempData;
          }
          _controller.finishLoad(tempData.length == _limit ? IndicatorResult.success : IndicatorResult.noMore);
        } else {
          if (currentIndex == 0) {
            _dataArr = tempData;
          } else {
            _dataArr2 = tempData;
          }
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
    return Scaffold(
      body: EasyRefresh.builder(
        controller: _controller,
        header: _refreshHeader(),
        footer: _refreshFooter(),
        onRefresh: () async => _requestData(),
        onLoad: () async => _requestData(isLoadMore: true),
        childBuilder: (BuildContext context, ScrollPhysics physics) {
          return _mainBody(physics);
        },
      ),
    );
  }

  _refreshHeader() {
    const classicHeader = ClassicHeader(
      triggerOffset: 60,
      clamping: true,
      position: IndicatorPosition.locator,
      mainAxisAlignment: MainAxisAlignment.end,
      dragText: '下拉刷新',
      armedText: '释放刷新',
      readyText: '加载中...',
      processingText: '加载中...',
      processedText: '加载完成',
      noMoreText: '没有更多',
      failedText: '加载失败',
      messageText: '最后更新于 %T',
    );

    const materialHeader = MaterialHeader(
        triggerOffset: 60, clamping: true, position: IndicatorPosition.locator, showBezierBackground: false);
    return materialHeader;
  }

  _refreshFooter() {
    const classicFooter = ClassicFooter(
      triggerOffset: 60,
      position: IndicatorPosition.locator,
      dragText: '上拉加载',
      armedText: '释放刷新',
      readyText: '加载中...',
      processingText: '加载中...',
      processedText: '加载完成',
      noMoreText: '没有更多',
      failedText: '加载失败',
      messageText: '最后更新于 %T',
      showMessage: false, // 隐藏更新时间
    );

    const materialFooter = MaterialFooter(
        triggerOffset: 60, clamping: false, position: IndicatorPosition.locator, showBezierBackground: false);
    return materialFooter;
  }

  _mainBody(physics) {
    var body = ScrollConfiguration(
      behavior: const ERScrollBehavior(),
      child: ExtendedNestedScrollView(
        physics: physics,
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          return JhScreenUtils.navigationBarHeight;
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const HeaderLocator.sliver(clearExtent: false),
          _buildSliverAppBar(),
        ],
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ContentPage2(physics: physics, dataArr: _dataArr),
            ContentPage2(physics: physics, dataArr: _dataArr2),
            // ExtendedVisibilityDetector(
            //   uniqueKey: const Key('Tab0'),
            //   child: ContentPage2(physics: physics, dataArr: _dataArr),
            // ),
            // ExtendedVisibilityDetector(
            //   uniqueKey: const Key('Tab1'),
            //   child: ContentPage2(physics: physics, dataArr: _dataArr),
            // ),
          ],
        ),
      ),
    );
    return body;
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      title: const Text('Title', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: IconButton(
        icon: const ImageIcon(AssetImage('assets/images/common/ic_nav_back_white.png')),
        iconSize: 18,
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        onPressed: () => JhNavUtils.goBack(context),
      ),
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(background: JhNetworkImage(KStrings.headBgImage)),
      bottom: JhTabBar(
        tabModelList: model,
        tabController: _tabController,
        switchPageCallBack: (index) {
          debugPrint('切换到第$index页');
          if (index == 0 && _dataArr.isEmpty) {
            _requestData(isShowLoading: true);
          }
          if (index == 1 && _dataArr2.isEmpty) {
            _requestData(isShowLoading: true);
          }
        },
      ),
    );
  }
}

class ContentPage2 extends StatefulWidget {
  const ContentPage2({
    Key? key,
    this.physics,
    this.dataArr = const [],
  }) : super(key: key);

  final ScrollPhysics? physics;
  final List dataArr;

  @override
  State<ContentPage2> createState() => _ContentPage2State();
}

class _ContentPage2State extends State<ContentPage2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CustomScrollView(
      physics: widget.physics,
      slivers: [
        SliverToBoxAdapter(child: _header()),
        SliverToBoxAdapter(child: _listWidget(widget.dataArr)),
        SliverToBoxAdapter(child: _footer()),
        const FooterLocator.sliver(),
      ],
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
}
