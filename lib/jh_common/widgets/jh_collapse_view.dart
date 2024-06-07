///  jh_collapse_view.dart
///
///  Created by iotjin on 2024/04/12.
///  description:  折叠面板

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';

enum JhCollapseStyle {
  flat,
  card,
}

enum JhCollapseType {
  rightArrow, // 标题 ▶▼ 右侧箭头，下方折叠展开
  centerArrow, // --- 标题▶▼ --- 中间箭头分割线，下方折叠展开
  seeMore, // --- 标题▼▲ ---查看更多 底部查看更多按钮，上方折叠展开
}

const _flatMargin = EdgeInsets.symmetric(horizontal: 3, vertical: 8);
const _cardMargin = EdgeInsets.all(10);
const _headerPadding = EdgeInsets.all(10);
const _lineColor = Color(0xFFE6E6E6); // (230, 230, 230)

class JhCollapseView extends StatefulWidget {
  const JhCollapseView({
    Key? key,
    this.isFold = false,
    this.content,
    this.titleWidget,
    this.margin,
    this.padding,
    this.headerPadding,
    this.decoration,
    this.title = '',
    this.titleStyle,
    this.titleCrossAxisAlignment = CrossAxisAlignment.start,
    this.arrowColor,
    this.bgColor,
    this.headerColor,
    this.hiddenDivider = false,
    this.collapseType = JhCollapseType.rightArrow,
    this.collapseStyle = JhCollapseStyle.flat,
    this.onChange,
  }) : super(key: key);

  final bool isFold;
  final Widget? content;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? margin; // margin，默认 flat样式: EdgeInsets.symmetric(horizontal: 3, vertical: 8), card样式: EdgeInsets.all(10)，传值则覆盖默认值
  final EdgeInsetsGeometry? padding; // padding,默认 flat样式: 0, card样式: 10，传值则覆盖默认值
  final EdgeInsetsGeometry? headerPadding; // header padding,默认 flat样式: 10, card样式:展开8,折叠0，传值则覆盖默认值
  final Decoration? decoration;
  final String title;
  final TextStyle? titleStyle;
  final CrossAxisAlignment titleCrossAxisAlignment;
  final Color? arrowColor; // 箭头颜色
  final Color? bgColor;
  final Color? headerColor;
  final bool hiddenDivider; // 是否隐藏分割线，仅对 JhCollapseType.centerArrow、JhCollapseType.seeMore 生效
  final JhCollapseType collapseType; // 折叠类型
  final JhCollapseStyle collapseStyle; // 折叠样式。flat: 扁平 card: 卡片
  final Function(bool value)? onChange; // 折叠状态改变回调

  @override
  State<JhCollapseView> createState() => _JhCollapseViewState();
}

class _JhCollapseViewState extends State<JhCollapseView> {
  bool _isFold = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFold = widget.isFold;
  }

  @override
  void didUpdateWidget(covariant JhCollapseView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isFold != oldWidget.isFold) {
      _isFold = widget.isFold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    var bgColor = widget.bgColor ?? KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCardBgDarkColor);
    var shadowColor = KColors.dynamicColor(context, Colors.black12, Colors.white24);
    var cardBorderStyle = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(3),
      boxShadow: [BoxShadow(color: shadowColor, spreadRadius: 1.5, blurRadius: 1.5)],
    );

    return Container(
      margin: widget.margin ?? (widget.collapseStyle == JhCollapseStyle.card ? _cardMargin : _flatMargin),
      padding: widget.padding ?? (widget.collapseStyle == JhCollapseStyle.card ? EdgeInsets.all(10) : EdgeInsets.all(0)),
      decoration: widget.decoration ?? (widget.collapseStyle == JhCollapseStyle.card ? cardBorderStyle : null),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.collapseType != JhCollapseType.seeMore ? _headerW() : Container(),
          Visibility(
            visible: !_isFold,
            child: widget.content ?? Container(),
          ),
          widget.collapseType == JhCollapseType.seeMore ? _headerW() : Container(),
        ],
      ),
    );
  }

  _headerW() {
    var headerColor = widget.headerColor ?? KColors.dynamicColor(context, KColors.kCardBgColor, KColors.kCardBgDarkColor);
    var textColor = KColors.dynamicColor(context, KColors.kBlackTextColor, KColors.kBlackTextDarkColor);
    var lineColor = KColors.dynamicColor(context, KColors.kLineColor, KColors.kGreyTextDarkColor);
    var titleStyle = widget.titleStyle ?? TextStyle(color: textColor);

    var isExpand = !_isFold;
    Widget w = Container();
    var padding = EdgeInsets.all(0);
    if (widget.collapseType == JhCollapseType.rightArrow) {
      w = Row(
        crossAxisAlignment: widget.titleCrossAxisAlignment,
        children: [
          Expanded(flex: 9, child: widget.titleWidget ?? _title(titleStyle)),
          // Icon(isExpand ? Icons.arrow_drop_down : Icons.arrow_drop_up, size: 22, color: widget.arrowColor),
          Icon(isExpand ? Icons.arrow_drop_down : Icons.arrow_right, size: 22, color: widget.arrowColor),
        ],
      );
      padding = EdgeInsets.only(bottom: isExpand ? 8 : 0);
    }
    if (widget.collapseType == JhCollapseType.centerArrow) {
      w = separatorView(isExpand,
          title: widget.title, titleStyle: titleStyle, arrowColor: widget.arrowColor, lineColor: lineColor, hiddenDivider: widget.hiddenDivider);
      padding = EdgeInsets.only(bottom: isExpand ? 8 : 0);
    }
    if (widget.collapseType == JhCollapseType.seeMore) {
      w = separatorView(isExpand,
          title: widget.title,
          titleStyle: titleStyle,
          arrowColor: widget.arrowColor,
          isSeeMore: true,
          lineColor: lineColor,
          hiddenDivider: widget.hiddenDivider);
      padding = EdgeInsets.only(top: isExpand ? 8 : 0);
    }

    return GestureDetector(
      child: Container(
        padding: widget.headerPadding ?? (widget.collapseStyle == JhCollapseStyle.card ? padding : _headerPadding),
        color: headerColor,
        child: w,
      ),
      onTap: () {
        setState(() {
          _isFold = !_isFold;
          widget.onChange?.call(_isFold);
        });
      },
    );
  }

  _title(titleStyle) {
    return Row(
      children: [
        Flexible(child: Text(widget.title, style: titleStyle)),
        SizedBox(width: 10),
      ],
    );
  }
}

Widget separator({Color? color = _lineColor, EdgeInsetsGeometry? margin = const EdgeInsets.only(top: 2, bottom: 10)}) {
  return Container(margin: margin, height: 1, color: color);
}

Widget separatorView(isExpand,
    {String title = '',
    TextStyle? titleStyle,
    Color? arrowColor,
    Color? lineColor = _lineColor,
    bool hiddenDivider = false,
    bool isSeeMore = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Visibility(
        visible: !hiddenDivider,
        child: Expanded(flex: 1, child: Container(height: 1, color: lineColor, margin: EdgeInsets.only(left: 15))),
      ),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Flexible(child: Text(title, style: titleStyle)),
            isSeeMore
                ? Icon(isExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 22, color: arrowColor)
                : Icon(isExpand ? Icons.arrow_drop_down : Icons.arrow_right, size: 22, color: arrowColor),
            SizedBox(width: 2),
          ],
        ),
      ),
      Visibility(
        visible: !hiddenDivider,
        child: Expanded(flex: 1, child: Container(height: 1, color: lineColor, margin: EdgeInsets.only(right: 15))),
      ),
    ],
  );
}
