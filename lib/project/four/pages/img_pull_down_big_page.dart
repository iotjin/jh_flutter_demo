///  img_pull_down_big_page.dart
///
///  Created by iotjin on 2020/09/04.
///  description: 图片下拉放大   https://zhuanlan.zhihu.com/p/85549830

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';

class ImgPullDownBigPage extends StatefulWidget {
  const ImgPullDownBigPage({Key? key}) : super(key: key);

  @override
  State<ImgPullDownBigPage> createState() => _ImgPullDownBigPageState();
}

class _ImgPullDownBigPageState extends State<ImgPullDownBigPage> with TickerProviderStateMixin {
  double imgHeight = 200;
  double imgExtraHeight = 0;
  double imgMaxHeight = 400;
  double? prevDy;
  AnimationController? animationController;
  Animation<double>? anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    prevDy = 0;
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController!);
  }

  // 更新图片高度
  updatePicHeight(changed) {
    if (prevDy == 0) {
      prevDy = changed;
    }
    imgExtraHeight += changed - prevDy;

    setState(() {
      prevDy = changed;
      imgExtraHeight = imgExtraHeight;
    });
  }

  runAnimate() {
    setState(() {
      anim = Tween(begin: imgExtraHeight, end: 0.0).animate(animationController!)
        ..addListener(() {
          setState(() {
            imgExtraHeight = anim!.value;
          });
        });
      prevDy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // 248
      body: _body(),
    );
  }

  Widget _body() {
    return Listener(
      onPointerMove: (result) {
        if (imgHeight + imgExtraHeight > imgMaxHeight) {
          return;
        }
        print('object: $result');
//          print('result.position.dy: ${ result.position.dy }');
        updatePicHeight(result.position.dy);
      },
      onPointerUp: (_) {
        runAnimate();
        animationController!.forward(from: 0);
      },
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
//          controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: imgHeight + imgExtraHeight,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('图片下拉放大', style: TextStyle(color: Colors.white, fontSize: 18)),
              background: JhNetworkImage('http://img1.mukewang.com/5c18cf540001ac8206000338.jpg'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _cell(context, index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _cell(context, index) {
    return Container(
      color: Colors.redAccent,
      child: Text('This is item $index', style: const TextStyle(fontSize: 20)),
    );
  }
}

/* 全屏背景图片

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent, // 把scaffold的背景色改成透明
            appBar: AppBar(
              backgroundColor: Colors.transparent, // 把appbar的背景色改成透明
               elevation: 0,// appbar的阴影
              title: Text('widget.title'),
            ),
            body: Center(
              child: Text('Hello World'),
            )));

* */
