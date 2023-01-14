// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_empty_view.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/base_appbar.dart';

final List titleData = [
  '空数据-默认',
  '空数据-只有图片',
  '空数据-只有文字',
  '网络错误-默认',
  '网络错误-自定义',
];

class EmptyDemoListPage extends StatelessWidget {
  const EmptyDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'JhEmptyView',
      dataArr: titleData,
      callBack: (index, str) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo1()))); // 普通路由
        }
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo2()))); // 普通路由
        }
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo3()))); // 普通路由
        }
        if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo4()))); // 普通路由
        }
        if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo5()))); // 普通路由
        }
      },
    );
  }
}

class Demo1 extends StatelessWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('空数据-默认'),
      body: JhEmptyView(),
    );
  }
}

class Demo2 extends StatelessWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('空数据-只有图片'),
      body: JhEmptyView(
        image: 'assets/images/common/empty/空.png',
        text: '',
      ),
    );
  }
}

class Demo3 extends StatelessWidget {
  const Demo3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('空数据-只有文字'),
      body: JhEmptyView(
        verticalTop: 20,
        image: '',
        text: '暂无数据2',
      ),
    );
  }
}

class Demo4 extends StatelessWidget {
  const Demo4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('网络错误-默认'),
      body: JhEmptyView(
        type: EmptyType.error,
        clickCallBack: () {
          print('点击重新加载');
          JhProgressHUD.showText('点击重新加载');
        },
      ),
    );
  }
}

class Demo5 extends StatelessWidget {
  const Demo5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('网络错误-自定义'),
      body: JhEmptyView(
        type: EmptyType.error,
        verticalTop: 40,
        image: 'assets/images/common/empty/网络错误.png',
        text: '网络不给力，点击重新加载2',
        btnTitle: '重新加载',
        clickCallBack: () {
          print('点击重新加载');
          JhProgressHUD.showText('点击重新加载');
        },
      ),
    );
  }
}
