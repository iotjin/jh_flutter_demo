///  base_appbar.dart
///
///  Created by iotjin on 2020/03/10.
///  description:  导航条基类

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'jh_common/utils/jh_status_bar_utils.dart';
import 'project/configs/colors.dart';
import 'project/provider/theme_provider.dart';

const double _titleFontSize = 18.0;
const double _textFontSize = 16.0;
const double _itemSpace = 15.0; // 右侧item内间距
const double _imgWH = 22.0; // 右侧图片wh
const double _rightSpace = 5.0; // 右侧item右间距
// 默认颜色
const Color _bgColor = KColors.kNavThemeBgColor;
const Color _bgDarkColor = KColors.kNavBgDarkColor;
const Color _titleColor = KColors.kNavTitleColor;
// 状态栏字体颜色，当backgroundColor透明或者是白色，状态栏字体为黑色，暗黑模式为白色
const Brightness _brightness = Brightness.light;

const Color appbarStartColor = KColors.kGradientStartColor; // 默认appBar 渐变开始色
const Color appbarEndColor = KColors.kGradientEndColor; // 默认appBar 渐变结束色

/// 带返回箭头导航条
backAppBar(BuildContext context, String title,
    {String? rightText,
    String? rightImgPath,
    Color? backgroundColor,
    Brightness brightness = _brightness,
    Function? rightItemCallBack,
    Function? backCallBack}) {
  return baseAppBar(
    context,
    title,
    isBack: true,
    rightText: rightText,
    rightImgPath: rightImgPath,
    rightItemCallBack: rightItemCallBack,
    leftItemCallBack: backCallBack,
    backgroundColor: backgroundColor,
    brightness: brightness,
  );
}

/// 带返回箭头的渐变导航条
backGradientAppBar(
  BuildContext context,
  String title, {
  String? rightText,
  String? rightImgPath,
  Function? rightItemCallBack,
  Function? backCallBack,
}) {
  return gradientAppBar(
    context,
    title,
    isBack: true,
    rightText: rightText,
    rightImgPath: rightImgPath,
    rightItemCallBack: rightItemCallBack,
    leftItemCallBack: backCallBack,
  );
}

/// 渐变导航条
gradientAppBar(
  BuildContext context,
  String title, {
  String? rightText,
  String? rightImgPath,
  Widget? leftItem,
  bool isBack: false,
  double elevation: 0,
  PreferredSizeWidget? bottom,
  Function? rightItemCallBack,
  Function? leftItemCallBack,
}) {
  return PreferredSize(
    child: Container(
      child: baseAppBar(
        context,
        title,
        rightText: rightText,
        rightImgPath: rightImgPath,
        leftItem: leftItem,
        isBack: isBack,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: elevation,
        bottom: bottom,
        rightItemCallBack: rightItemCallBack,
        leftItemCallBack: leftItemCallBack,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appbarStartColor,
            appbarEndColor,
          ],
        ),
      ),
    ),
//        preferredSize: Size(MediaQuery.of(context).size.width, 45),
    preferredSize: Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
  );
}

/// baseAppBar
baseAppBar(
  BuildContext context,
  String title, {
  String? rightText,
  String? rightImgPath,
  Widget? leftItem,
  bool isBack: false,
  Color? backgroundColor,
  Brightness brightness = _brightness,
  double elevation: 0,
  PreferredSizeWidget? bottom,
  Function? rightItemCallBack,
  Function? leftItemCallBack,
}) {
  // 默认颜色
  Color titleAndIconColor = _titleColor;
  Color bgColor = backgroundColor ?? _bgColor;

  // 如果背景透明或者是白色，设置字体和图标、状态栏字体为黑色
  if (backgroundColor == Colors.transparent ||
      backgroundColor == Colors.white ||
      backgroundColor == KColors.kNavWhiteBgColor) {
    titleAndIconColor = Colors.black;
    brightness = Brightness.dark;
  } else {
    brightness = Brightness.light;
  }

  // TODO: 通过ThemeProvider进行主题管理
  final provider = Provider.of<ThemeProvider>(context);
  final bool isDark = context.jhIsDark;
  // 设置的颜色优先级高于暗黑模式
  bgColor = backgroundColor ?? (isDark ? _bgDarkColor : provider.getThemeColor());
  if (isDark) {
    titleAndIconColor = _titleColor;
  }

  Widget rightItem = Text('');
  if (rightText != null) {
    rightItem = InkWell(
      child: Container(
          margin: EdgeInsets.all(_itemSpace),
          color: Colors.transparent,
          child: Center(child: Text(rightText, style: TextStyle(fontSize: _textFontSize, color: titleAndIconColor)))),
      onTap: () {
        if (rightItemCallBack != null) {
          rightItemCallBack();
        }
      },
    );
  }
  if (rightImgPath != null) {
    rightItem = IconButton(
      icon: Image.asset(
        rightImgPath,
        width: _imgWH,
        height: _imgWH,
        color: titleAndIconColor,
      ),
      onPressed: () {
        if (rightItemCallBack != null) {
          rightItemCallBack();
        }
      },
    );
  }
  return AppBar(
    title: Text(title, style: TextStyle(fontSize: _titleFontSize, color: titleAndIconColor)),
    centerTitle: true,
    backgroundColor: bgColor,
    systemOverlayStyle: JhStatusBarUtils.getStatusBarStyle(isDark: isDark, brightness: brightness),
    bottom: bottom,
    elevation: elevation,
    leading: isBack == false
        ? leftItem
        : IconButton(
//      icon: Icon(Icons.arrow_back_ios,color: _color),
            icon: ImageIcon(
              AssetImage('assets/images/common/ic_nav_back_white.png'),
              color: titleAndIconColor,
            ),
            iconSize: 18,
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            onPressed: () {
              if (leftItemCallBack == null) {
                _popThis(context);
              } else {
                leftItemCallBack();
              }
            },
          ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rightItem,
          SizedBox(width: _rightSpace),
        ],
      ),
    ],
  );
}

void _popThis(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
