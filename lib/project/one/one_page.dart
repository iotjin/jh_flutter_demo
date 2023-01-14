///  one_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 首页

import 'package:flutter/material.dart';
import './pages/wx_home_page.dart';

class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  Widget build(BuildContext context) {
    return const WxHomePage();
  }
}

/*
--enable-software-rendering

Flutter中的Offstage与Visibility都可以将子widget进行隐藏，
不同的是Visibility可以设置隐藏之后是否还占据原来的控件、设置隐藏后是否响应事件，
Offstage隐藏后之前所占的空间就会消失。

一、Offstage

Offstage中控制显示隐藏的重要属性是offstage，默认为true。当offstage 为true时，其child控件是隐藏的。

二、Visibility

Visibility构造器

const Visibility({
    Key key,
    @required this.child,
    this.replacement = const SizedBox.shrink(), // 不可见时显示的组件，只有maintainState=false才会显示。
    this.visible = true, // 是否可见
    this.maintainState = false, // 隐藏后是否位置组件状态
    this.maintainAnimation = false, // 隐藏后是否维持子组件中的动画
    this.maintainSize = false, // 隐藏后所占空间是否释放
    this.maintainSemantics = false,
    this.maintainInteractivity = false, // 隐藏后是否能够照常响应事件
  })

 */
