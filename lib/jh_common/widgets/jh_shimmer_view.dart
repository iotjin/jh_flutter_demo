///  jh_shimmer_view.dart
///
///  Created by iotjin on 2022/11/05.
///  description: 骨架屏页面

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '/project/configs/colors.dart';

class JhShimmerView {
  /// 骨架屏
  static baseShimmer(BuildContext context, Widget child) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: KColors.dynamicColor(context, Colors.grey[300]!, Colors.grey[900]!),
      highlightColor: KColors.dynamicColor(context, Colors.grey[100]!, Colors.grey[850]!),
      child: child,
    );
  }

  /// listShimmerView - 只有矩形cell
  static listShimmerView1(
    BuildContext context, {
    EdgeInsetsGeometry margin = const EdgeInsets.fromLTRB(15, 15, 15, 0),
    double borderRadius = 5,
    double height = 100,
  }) {
    var cell = Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height,
    );

    var listView = ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => cell,
    );
    return baseShimmer(context, listView);
  }

  /// listShimmerView - 左侧头像，右侧3行文字(两长一短)
  static listShimmerView2(BuildContext context) {
    var cell = Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 48, height: 48, color: Colors.white),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: double.infinity, height: 10, color: Colors.white),
                const SizedBox(height: 5),
                Container(width: double.infinity, height: 10, color: Colors.white),
                const SizedBox(height: 5),
                Container(width: 60, height: 8, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
    var listView = ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => cell,
    );
    return baseShimmer(context, listView);
  }

  /// gridShimmerView - 只有矩形item(默认2列)
  static gridShimmerView1(
    BuildContext context, {
    EdgeInsetsGeometry margin = const EdgeInsets.all(10),
    double borderRadius = 5,
    int crossAxisCount = 2,
  }) {
    var cell = Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    var gridView = GridView.builder(
      // 是否根据子组件的总长度来设置GridView的长度，默认值为false
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 可以直接指定每行（列）显示多少个Item
        crossAxisCount: crossAxisCount, // 一行的Widget数量
        crossAxisSpacing: 5, // 水平间距
        mainAxisSpacing: 5, // 垂直间距
        childAspectRatio: 1, // 子Widget宽高比例
      ),
      //GridView内边距
      padding: const EdgeInsets.all(5),
      itemCount: 10,
      itemBuilder: (context, index) => cell,
    );
    return baseShimmer(context, gridView);
  }
}
