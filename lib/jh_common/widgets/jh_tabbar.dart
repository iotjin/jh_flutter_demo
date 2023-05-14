///  jh_tabbar.dart
///
///  Created by iotjin on 2023/05/07.
///  description: 自定义tabbar

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';
import 'jh_badge.dart';

// const Color _bgColor = Color(0xFFF2F2F2); // 242
// const Color _indicatorColor = KColors.kThemeColor;
// const Color _labelColor = KColors.kThemeColor;
// const Color _unselectedLabelColor = Color(0xFF333333); // 51
// const Color _centerLineColor = Color(0xFFC8C8C8); // 200

class JhTabBarModel {
  final String? title; // 标题
  final Widget? widget; // 对应的widget
  final JhBadge? badge; // 设置badge，不用设置title

  const JhTabBarModel({this.title, this.widget, this.badge});
}

class JhTabBarView extends StatelessWidget {
  const JhTabBarView({
    Key? key,
    required this.tabModelList,
    required this.tabController,
  }) : super(key: key);

  final List<JhTabBarModel> tabModelList; // tab对象数组
  final TabController tabController; // TabController对象

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: tabModelList.map((item) => item.widget ?? Container()).toList(),
    );
  }
}

class JhTabBar extends StatefulWidget implements PreferredSizeWidget {
  const JhTabBar({
    Key? key,
    required this.tabModelList,
    this.bgColor,
    this.tabController,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWeight = 2,
    this.height = 40.0,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicator,
    this.showCenterLine = false,
    this.switchPageCallBack,
  }) : super(key: key);

  final List<JhTabBarModel> tabModelList; // tab对象数组
  final Color? bgColor; // TabBar背景颜色，
  final TabController? tabController; // TabController对象
  final Color? indicatorColor; // 指示器颜色
  final Color? labelColor; // 选中label颜色
  final Color? unselectedLabelColor; // 未选中label颜色
  final double indicatorWeight; // 指示器 高度 默认2
  final double height; // tab高度 默认35
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Decoration? indicator; // 指示器样式
  final bool showCenterLine;
  final Function? switchPageCallBack; // 页面切换的回调，返回index

  @override
  State<JhTabBar> createState() => _JhTabBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _JhTabBarState extends State<JhTabBar> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _addTabListener();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  _addTabListener() {
    _tabController = widget.tabController ?? TabController(length: widget.tabModelList.length, vsync: this);
    _tabController!.addListener(() {
      // print(_tabController!.index);
      if (widget.switchPageCallBack != null) {
        // _tabController.indexIsChanging 监听不到滑动
        if (_tabController!.index.toDouble() == _tabController!.animation!.value) {
          widget.switchPageCallBack!(_tabController!.index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _customTabBar();
  }

  Widget _customTabBar() {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var bgColor = KColors.dynamicColor(context, const Color(0xFFF2F2F2), KColors.kTabBarBgDarkColor); // 242
    var indicatorColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var labelColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var unselectedLabelColor = KColors.dynamicColor(context, KColors.kBlackTextColor, KColors.kBlackTextDarkColor);
    var centerLineColor = const Color(0xFFC8C8C8); // 200

    // 设置的颜色优先级高于暗黑模式
    bgColor = widget.bgColor ?? bgColor;
    indicatorColor = widget.indicatorColor ?? indicatorColor;
    labelColor = widget.labelColor ?? labelColor;
    unselectedLabelColor = widget.unselectedLabelColor ?? unselectedLabelColor;

    return Stack(
      children: <Widget>[
        Material(
          child: Container(
            height: widget.height,
            color: bgColor, // 这里设置tab的背景色
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: indicatorColor,
              indicatorWeight: widget.indicatorWeight,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              labelStyle: widget.labelStyle,
              unselectedLabelStyle: widget.unselectedLabelStyle,
              indicator: widget.indicator,
              tabs: widget.tabModelList.map((item) => Tab(text: item.title, icon: item.badge)).toList(),
            ),
          ),
        ),
        SizedBox(
          height: widget.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              color: centerLineColor,
              height: 20,
              width: widget.showCenterLine == true ? 1 : 0,
            ),
          ),
        )
      ],
    );
  }
}

/**
    const TabBar({
    Key key,
    @required this.tabs,// 显示的标签内容，一般使用Tab对象,也可以是其他的Widget
    this.controller,// TabController对象
    this.isScrollable = false,// 是否可滚动
    this.indicatorColor,// 指示器颜色
    this.indicatorWeight = 2.0,// 指示器高度
    this.indicatorPadding = EdgeInsets.zero,// 底部指示器的Padding
    this.indicator,// 指示器decoration，例如边框等
    this.indicatorSize,// 指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
    this.labelColor,// 选中label颜色
    this.labelStyle,// 选中label的Style
    this.labelPadding,// 每个label的padding值
    this.unselectedLabelColor,// 未选中label颜色
    this.unselectedLabelStyle,// 未选中label的Style
    }) : assert(tabs != null),
    assert(isScrollable != null),
    assert(indicator != null || (indicatorWeight != null && indicatorWeight > 0.0)),
    assert(indicator != null || (indicatorPadding != null)),
    super(key: key);
 */
