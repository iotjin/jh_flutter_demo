///  jh_top_tabbar.dart
///
///  Created by iotjin on 2020/04/24.
///  description:  顶部分页效果的tabBar(类似新闻APP顶部切换效果)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';
import '/base_appbar.dart';
import 'jh_badge.dart';

// const Color _bgColor = Color(0xFFF2F2F2); //242
// const Color _indicatorColor = KColors.kThemeColor;
// const Color _labelColor = KColors.kThemeColor;
// const Color _unselectedLabelColor = Color(0xFF333333); //51
// const Color _centerLineColor = Color(0xFFC8C8C8); //200

class JhTopTabBarModel {
  final String? title; // 标题
  final Widget? widget; // 对应的widget
  final JhBadge? badge; // 设置badge，不用设置title

  const JhTopTabBarModel({this.title, this.widget, this.badge});
}

class JhTopTabBar extends StatefulWidget {
  const JhTopTabBar({
    Key? key,
    this.title = '',
    required this.tabModelArr,
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
    this.rightText,
    this.rightImgPath,
    this.leftWidget,
    this.titleWidget,
    this.rightWidgets,
    this.elevation = 3,
    this.rightItemCallBack,
    this.leftItemCallBack,
    this.switchPageCallBack,
  }) : super(key: key);

  final String title;
  final List<JhTopTabBarModel> tabModelArr; // tab对象数组
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

  // appbar参数
  final String? rightText; // 右侧按钮文字
  final String? rightImgPath; // 右侧按钮图片路径，优先级高于rightText
  final Widget? leftWidget; // 左侧Widget，为空显示返回按钮
  final Widget? titleWidget; // 标题Widget，优先级高于title
  final List<Widget>? rightWidgets; // 优先级高于rightText和rightImgPath
  final double elevation;
  final Function? rightItemCallBack;
  final Function? leftItemCallBack;
  final Function? switchPageCallBack; // 页面切换的回调，返回index

  @override
  State<JhTopTabBar> createState() => _JhTopTabBarState();
}

class _JhTopTabBarState extends State<JhTopTabBar> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: widget.tabModelArr.length, vsync: this);
    _tabController!.addListener(() {
//      print(_tabController.index);
      if (widget.switchPageCallBack != null) {
//          _tabController.indexIsChanging     监听不到滑动
        if (_tabController!.index.toDouble() == _tabController!.animation!.value) {
          widget.switchPageCallBack!(_tabController!.index);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: BaseAppBar(
        widget.title,
        rightText: widget.rightText,
        rightImgPath: widget.rightImgPath,
        leftWidget: widget.leftWidget,
        titleWidget: widget.titleWidget,
        rightWidgets: widget.rightWidgets,
        elevation: widget.elevation,
        rightItemCallBack: widget.rightItemCallBack,
        leftItemCallBack: widget.leftItemCallBack,
        bottomWidget: PreferredSize(
          preferredSize: Size.fromHeight(widget.height),
          child: Stack(
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
                    tabs: widget.tabModelArr.map((item) => Tab(text: item.title, icon: item.badge)).toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, (widget.height - 20) / 2, 0, (widget.height - 20) / 2),
                  child: Container(
                    color: centerLineColor,
                    height: widget.height - 20,
                    width: widget.showCenterLine == true ? 1 : 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),

//        AppBar(
//          title: Text(widget.title, style: TextStyle(fontSize: 18.0, color: Colors.white)),
//          backgroundColor: Theme.of(context).primaryColor,
//          elevation: 4,
//          bottom:
//          PreferredSize(
//              preferredSize: Size.fromHeight(widget.height),
//              child:
//              Material(
//                child:
//                Container(
//                  height: widget.height,
//                  color: widget.bgColor,// 这里设置tab的背景色
//                  child: TabBar(
//                    controller: _tabController,
//                    indicatorSize:TabBarIndicatorSize.label,
//                    indicatorColor:widget.indicatorColor,
//                    indicatorWeight : widget.indicatorWeight,
//                    labelColor:widget.labelColor,
//                    unselectedLabelColor:widget.unselectedLabelColor,
//                    labelStyle: widget.labelStyle,
//                    unselectedLabelStyle: widget.unselectedLabelStyle,
//                    tabs: widget.tabModelArr.map((item) => Tab(text: item.title)).toList(),
//                  ),
//                ),
//              )
//          ),
//        ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabModelArr.map((item) => item.widget!).toList(),
      ),
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
