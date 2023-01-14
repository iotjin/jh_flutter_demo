// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/base_appbar.dart';

final List titleData = [
  '继承',
];

class GrammarTestPage extends StatelessWidget {
  const GrammarTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'Grammar',
      dataArr: titleData,
      callBack: (index, str) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const Demo1()))); // 普通路由
        }
      },
    );
  }
}

/// 子类
class Demo1 extends BaseA {
  const Demo1({Key? key}) : super(key: key);

  @override
  State<Demo1> createState() => _Demo1State();
}

class _Demo1State extends BaseAState<Demo1> {
  @override
  void initState() {
    super.initState();

    testMethodA();
    testMethodB();
    super.testMethodA();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('继承'),
      body: Text('控制台查看日志'),
    );
  }

  @override
  void testMethodA() {
    super.testMethodA();
    print('子类 - testMethodA');
  }

  @override
  void testMethodB() {
    print('子类 - testMethodB');
  }
}

/// 基类 widget abstract
class BaseA extends StatefulWidget {
  const BaseA({Key? key}) : super(key: key);

  @override
  State<BaseA> createState() => BaseAState();
}

/// 基础 state
class BaseAState<T extends BaseA> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void testMethodA() {
    print('父类 - testMethodA');
  }

  void testMethodB() {
    print('父类 - testMethodB');
  }
}
