import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/project_config.dart';
import '../http/http_page_test_cell.dart';
import '../http/http_page_test_model.dart';

const _headerHeight = 50.0;

class PersonalCenterPage5 extends StatefulWidget {
  const PersonalCenterPage5({Key? key}) : super(key: key);

  @override
  State<PersonalCenterPage5> createState() => _PersonalCenterPage5State();
}

class _PersonalCenterPage5State extends State<PersonalCenterPage5> {
  final ScrollController _scrollController = ScrollController();

  // 图片下拉放大
  final double _imgNormalHeight = 300;
  double _imgExtraHeight = 0;
  double _imgAllHeight = 0;
  double _scrollMinOffSet = 0;
  double _navHeight = 0;

  // 导航条透明度
  double _appbarOpacity = 0.0;

  // 刷新
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final int _limit = 15;
  List _dataArr = [];
  int _pageIndex = 0;

  int _pageType = 0;

  // 自定义指示器相关
  final _listenable = IndicatorStateListenable();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageType = JhCommonUtils.getRandomInt(0, 1);
    _initAndAddListener();
    _requestData(isShowLoading: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 滚动监听
  _initAndAddListener() {
    _navHeight = JhScreenUtils.navigationBarHeight;
    _imgAllHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navHeight;
    _scrollController.addListener(() {
      // y小于0，是在下拉放大
      double y = _scrollController.offset;
      // debugPrint('滑动距离: $y');
      // debugPrint('_scrollMinOffSet: $_scrollMinOffSet');
      // 图片
      if (y < _scrollMinOffSet) {
        _imgExtraHeight = -y;
        setState(() {
          _imgAllHeight = _imgNormalHeight + _imgExtraHeight;
        });
      } else {
        setState(() {
          _imgAllHeight = _navHeight;
        });
      }
      // appbar 透明度
      double appBarOpacity = y / _navHeight;
      if (appBarOpacity < 0) {
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        appBarOpacity = 1.0;
      }
      // 更新透明度
      setState(() {
        _appbarOpacity = appBarOpacity;
        // debugPrint('_appbarOpacity=: $_appbarOpacity');
      });
    });
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
    return Scaffold(
      body: EasyRefresh.builder(
        scrollController: _scrollController,
        controller: _controller,
        header: ListenerHeader(clamping: false, triggerOffset: 70, listenable: _listenable),
        // footer: const MaterialFooter(),
        onRefresh: () async => _requestData(),
        onLoad: () async => _requestData(isLoadMore: true),
        childBuilder: (BuildContext context, ScrollPhysics physics) {
          return _body(physics);
        },
      ),
    );
  }

  Widget _body(physics) {
    var navBgColor = KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor);
    navBgColor = navBgColor.withOpacity(_appbarOpacity);

    var iconColor = KColors.kNavTitleColor;
    // 如果背景透明或者是白色，设置字体和图标、状态栏字体为黑色
    if (navBgColor == Colors.transparent || navBgColor == Colors.white || navBgColor == KColors.kNavWhiteBgColor) {
      iconColor = Colors.black;
    }

    return Stack(
      children: <Widget>[
        _pageType == 0 ? _mainBody(physics) : _mainBody2(physics),
        Positioned(
          top: 0,
          width: JhScreenUtils.screenWidth,
          height: _imgAllHeight,
          child: JhNetworkImage(KStrings.headBgImage),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BaseAppBar(
            'Title',
            bgColor: navBgColor,
            brightness: _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightWidgets: [_customRightItem(iconColor)],
          ),
        ),
      ],
    );
  }

  _mainBody(physics) {
    var dataList = _dataArr;
    if (dataList.isEmpty) {
      return ListView(
        padding: EdgeInsets.only(top: _imgNormalHeight),
        controller: _scrollController,
        physics: physics,
        children: const [
          JhEmptyView(),
        ],
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: _imgNormalHeight),
      controller: _scrollController,
      itemCount: dataList.length,
      shrinkWrap: true,
      physics: physics,
      itemBuilder: (context, index) {
        var model = dataList[index];
        var image = '${KStrings.avatarImage}?random=$index';
        return ListTile(
          leading: JhNetworkImage(image, width: 50, height: 50, borderRadius: 25),
          title: Text(model['name2']),
          subtitle: Text(model['dateTime']),
          trailing: Text(model['city']),
        );
      },
    );
  }

  _mainBody2(physics) {
    return ListView(
      padding: EdgeInsets.only(top: _imgNormalHeight),
      controller: _scrollController,
      physics: physics,
      children: [
        _header(),
        _listWidget(_dataArr),
        _footer(),
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

  _customRightItem(iconColor) {
    var normalItem = Center(
      child: IconButton(
        icon: Image.asset('assets/images/ic_more_black.png', width: 22, height: 22, color: iconColor),
        onPressed: () => JhProgressHUD.showText('点击更多'),
      ),
    );

    var rightItem = ValueListenableBuilder<IndicatorState?>(
      valueListenable: _listenable,
      builder: (context, state, _) {
        if (state == null) {
          return normalItem;
        }
        final mode = state.mode;
        final offset = state.offset;
        final actualTriggerOffset = state.actualTriggerOffset;
        double? value;
        if (mode == IndicatorMode.inactive) {
          value = 0;
        } else if (mode == IndicatorMode.processing) {
          value = null;
        } else if (mode == IndicatorMode.drag || mode == IndicatorMode.armed) {
          value = math.min(offset / actualTriggerOffset, 1) * 0.75;
        } else if (mode == IndicatorMode.ready || mode == IndicatorMode.processing) {
          value == null;
        } else {
          value = 1;
        }
        Widget indicator;
        if (value != null && value < 0.1) {
          indicator = normalItem;
        } else if (value == 1) {
          indicator = Icon(Icons.done, color: iconColor);
        } else {
          indicator = RefreshProgressIndicator(value: value);
        }
        return SizedBox(
          width: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: indicator,
              ),
            ],
          ),
        );
      },
    );
    return rightItem;
  }
}
