///  wx_friends_circle_page.dart
///
///  Created by iotjin on 2020/09/14.
///  description: 朋友圈

import 'dart:math';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '/jh_common/utils/jh_time_utils.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/project/configs/project_config.dart';
import '/project/two/models/wx_contacts_model.dart';
import '../models/wx_friends_circle_model.dart';
import '../widgets/wx_friends_circle_cell.dart';

class WxFriendsCirclePage extends StatefulWidget {
  const WxFriendsCirclePage({Key? key}) : super(key: key);

  @override
  State<WxFriendsCirclePage> createState() => _WxFriendsCirclePageState();
}

class _WxFriendsCirclePageState extends State<WxFriendsCirclePage> {
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

  // 自定义指示器相关
  final _listenable = IndicatorStateListenable();

  @override
  void initState() {
    super.initState();

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
    HttpUtils.get(APIs.getFriendsCircleList, params, loadingText: loadingText, success: (res) {
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
        _mainBody(physics),
        Positioned(top: 0, left: 0, right: 0, height: _imgAllHeight, child: _header()),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BaseAppBar(
            '朋友圈',
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
        WxFriendsCircleModel model = WxFriendsCircleModel.fromJson(dataList[index]);
        model.time = JhTimeUtils.formatTimeAgo(model.time.jhNullSafe);
        return WxFriendsCircleCell(
          model: model,
          onClickCell: (model) => _clickCell(model['name']),
          onClickHeadPortrait: (model) => _jumpInfo(),
          onClickComment: (model) => _clickCell('评论'),
        );
      },
    );
  }

  _customRightItem(iconColor) {
    var normalItem = Center(
      child: IconButton(
        icon: Image.asset('assets/wechat/discover/ic_camera.png', width: 22, height: 22, color: iconColor),
        onPressed: () => _clickNav(),
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
          value = min(offset / actualTriggerOffset, 1) * 0.75;
        } else if (mode == IndicatorMode.ready || mode == IndicatorMode.processing) {
          value = null;
        } else {
          value = 1;
        }
        Widget indicator;
        if (value != null && value < 0.1) {
          indicator = normalItem;
        } else if (value == 1) {
          indicator = normalItem;
          // indicator = Icon(Icons.done, color: iconColor);
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

  // _header
  Widget _header() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          // child: Image.network(
          //   'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          //   fit: BoxFit.cover,
          // ),
          child: Image.asset(
            'assets/wechat/discover/friends/wx_bg0.jpeg',
            // 'assets/wechat/discover/friends/wx_bg1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  '小于',
                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/lufei.png'),
                    ),
                  ),
                ),
                onTap: () => _jumpInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 点击cell
  _clickCell(text) {
    JhToast.showText(context, msg: '点击 $text');
  }

  _clickNav() {
    JhBottomSheet.showText(context, title: '请选择操作', dataArr: ['拍摄', '从手机相册选择'], clickCallback: (index, text) {});
  }

  // 跳转个人信息页
  _jumpInfo() {
    WxContactsModel model = WxContactsModel();
    model.id = 123;
    model.name = '小于';
    model.namePinyin = '小于';
    model.phone = '17372826674';
    model.sex = '0';
    model.region = '淮北市';
    model.label = '';
    model.color = '#c579f2';
    model.avatarUrl = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    model.isStar = false;

    JhNavUtils.pushNamed(context, 'WxUserInfoPage', arguments: model.toJson());
  }
}
