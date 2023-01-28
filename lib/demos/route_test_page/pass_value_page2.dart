// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_nav_router_utils.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class PassValuePage2 extends StatefulWidget {
  const PassValuePage2(this.jumpParams, {Key? key}) : super(key: key);
  final dynamic jumpParams;

  @override
  State<PassValuePage2> createState() => _PassValuePage2State();
}

class _PassValuePage2State extends State<PassValuePage2> {
  dynamic _value;

  @override
  Widget build(BuildContext context) {
    _value = widget.jumpParams;
    print('接收传值_jumpParams: $_value');

    return Scaffold(
      appBar: const BaseAppBar('回传'),
      body: _body(),
    );
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('接收的值:'),
        const SizedBox(height: 10),
        Text(_value.toString()),
        const SizedBox(height: 20),
        Visibility(
          visible: widget.jumpParams['type'] == '1',
          child: ElevatedButton(
            child: const Text('点击回传刷新页面 - goBackWithParams'),
            onPressed: () {
              // 返回上级带参数
              JhNavUtils.goBackWithParams(context, {'isRefresh': true});
            },
          ),
        ),
        Visibility(
          visible: widget.jumpParams['type'] == '2',
          child: ElevatedButton(
            child: const Text('点击回传参数 - goBackWithParams'),
            onPressed: () {
              // 返回上级带参数
              JhNavUtils.goBackWithParams(context, {'isRefresh': false, 'value2': 456});
            },
          ),
        ),
        Visibility(
          visible: widget.jumpParams['type'] == '3',
          child: ElevatedButton(
            child: const Text('点击返回 - JhNavUtils.goBack'),
            onPressed: () {
              // 返回上级
              JhNavUtils.goBack(context);
            },
          ),
        ),
        Visibility(
          visible: widget.jumpParams['type'] == '4' || widget.jumpParams['type'] == '6',
          child: ElevatedButton(
            child: const Text('点击回传参数 - pop带参数'),
            onPressed: () {
              // 返回上级带参数，以下效果一样
              // Navigator.pop<Object>(context, {'isRefresh': false, 'value2': 4567});
              // Navigator.of(context).pop({'isRefresh': false, 'value2': 4567});

              // 效果同上，基于Navigator封装
              JhNavRouterUtils.goBackWithParams(context, {'isRefresh': false, 'value2': 4567});
            },
          ),
        ),
        Visibility(
          visible: widget.jumpParams['type'] == '5',
          child: ElevatedButton(
            child: const Text('点击返回 - pop'),
            onPressed: () {
              // 返回上级，以下效果一样
              // Navigator.of(context).pop();
              // Navigator.pop(context);

              // 效果同上，基于Navigator封装
              JhNavRouterUtils.goBack(context);
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Text('返回多级 - JhNavUtils'),
          onPressed: () {
            JhNavUtils.goBack(context);
            JhNavUtils.goBack(context);
            JhNavUtils.goBackWithParams(context, '456');
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Text('返回多级 - Navigator'),
          onPressed: () {
            Navigator.of(context)
              ..pop()
              ..pop({'isRefresh': false, 'value2': 4567});
          },
        )
      ],
    );
  }
}
