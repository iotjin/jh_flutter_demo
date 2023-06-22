///  gradient_appbar.dart
///
///  Created by iotjin on 2020/08/25.
///  description:  渐变导航条

// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/project/configs/colors.dart';

const double _kLeadingWidth = kToolbarHeight;
const Color appbarStartColor = KColors.kGradientStartColor; // 默认appBar 渐变开始色
const Color appbarEndColor = KColors.kGradientEndColor; // 默认appBar 渐变结束色

/// 建议使用base_appbar
/// 带有渐变色的  APPBar
class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
  GradientAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.gradientStart = appbarStartColor,
    this.gradientEnd = appbarEndColor,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? backgroundColor;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool? centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;

  final Color gradientStart;
  final Color gradientEnd;

  @override
  final Size preferredSize;

  bool _getEffectiveCenterTitle(ThemeData themeData) {
    if (centerTitle != null) return centerTitle!;
    switch (themeData.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
        return actions == null || actions!.length < 2;
      case TargetPlatform.linux:
        // TODO: Handle this case.
        break;
      case TargetPlatform.macOS:
        // TODO: Handle this case.
        break;
      case TargetPlatform.windows:
        // TODO: Handle this case.
        break;
    }
    return false;
  }

  @override
  State<GradientAppBar> createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  static const double _defaultElevation = 4.0;

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context)!;

    final bool hasDrawer = scaffold.hasDrawer;
    final bool hasEndDrawer = scaffold.hasEndDrawer;
    final bool canPop = parentRoute.canPop;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData? appBarIconTheme = widget.iconTheme ?? appBarTheme.iconTheme ?? themeData.primaryIconTheme;
    TextStyle? centerStyle =
        widget.textTheme?.subtitle1 ?? Theme.of(context).textTheme.subtitle1 ?? themeData.primaryTextTheme.subtitle1;
    TextStyle? sideStyle =
        widget.textTheme?.subtitle1 ?? Theme.of(context).textTheme.bodyText1 ?? themeData.primaryTextTheme.bodyText1;

//    IconThemeData appBarIconTheme =
//        widget.iconTheme ?? appBarTheme.iconTheme ?? themeData.primaryIconTheme;
//    TextStyle centerStyle = widget.textTheme?.title ??
//        appBarTheme.textTheme?.title ??
//        themeData.primaryTextTheme.title;
//    TextStyle sideStyle = widget.textTheme?.body1 ??
//        appBarTheme.textTheme?.body1 ??
//        themeData.primaryTextTheme.body1;

    Widget? leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop) leading = useCloseButton ? const CloseButton() : const BackButton();
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
        child: leading,
      );
    }

    Widget? title = widget.title;
    if (title != null) {
      bool? namesRoute;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
          break;
        case TargetPlatform.linux:
          // TODO: Handle this case.
          break;
        case TargetPlatform.macOS:
          // TODO: Handle this case.
          break;
        case TargetPlatform.windows:
          // TODO: Handle this case.
          break;
      }
      title = DefaultTextStyle(
        style: centerStyle!,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute!,
          header: true,
          child: title,
        ),
      );
    }

    Widget? actions;
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions!,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    final Widget toolbar = NavigationToolbar(
      middle: title,
      leading: leading,
      trailing: actions,
      centerMiddle: widget._getEffectiveCenterTitle(themeData),
      middleSpacing: widget.titleSpacing,
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: const _ToolbarContainerLayout(),
        child: IconTheme.merge(
          data: appBarIconTheme,
          child: DefaultTextStyle(
            style: sideStyle!,
            child: toolbar,
          ),
        ),
      ),
    );
    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: kToolbarHeight),
              child: appBar,
            ),
          ),
          widget.bottomOpacity == 1.0
              ? widget.bottom!
              : Opacity(
                  opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.bottomOpacity),
                  child: widget.bottom,
                ),
        ],
      );
    }

    if (widget.primary) {
      appBar = SafeArea(
        top: true,
        child: appBar,
      );
    }

    appBar = Align(
      alignment: Alignment.topCenter,
      child: appBar,
    );

    if (widget.flexibleSpace != null) {
      appBar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          widget.flexibleSpace!,
          appBar,
        ],
      );
    }

    appBar = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [widget.gradientStart, widget.gradientEnd]),
      ),
      child: appBar,
    );

    final Brightness brightness = widget.brightness ?? Theme.of(context).brightness;
    final SystemUiOverlayStyle overlayStyle =
        brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return Material(
      color: Colors.transparent,
      elevation: widget.elevation ?? appBarTheme.elevation ?? _defaultElevation,
      child: appBar,
    );
  }
}

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: kToolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}
