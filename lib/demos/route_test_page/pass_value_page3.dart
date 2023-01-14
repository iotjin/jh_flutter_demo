// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_nav_router_utils.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class PassValuePage3 extends StatefulWidget {
  const PassValuePage3({Key? key}) : super(key: key);

  @override
  State<PassValuePage3> createState() => _PassValuePage3State();
}

class _PassValuePage3State extends State<PassValuePage3> {
  dynamic _value;

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    _value = ModalRoute.of(context)!.settings.arguments;
    print('接收传值_jumpParams: $_value');

    return Scaffold(
      appBar: const BaseAppBar('回传'),
      body: _body(context),
    );
  }

  _body(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('接收的值:'),
        const SizedBox(height: 10),
        Text(_value.toString()),
        const SizedBox(height: 20),
        ElevatedButton(
          child: const Text('点击回传参数 - pop带参数'),
          onPressed: () {
            // 返回上级带参数，以下效果一样
            // Navigator.pop<Object>(context, {'isRefresh': false, 'value2': 4567});
            // Navigator.of(context).pop({'isRefresh': false, 'value2': 4567});

            // 效果同上，基于Navigator封装
            JhNavRouterUtils.goBackWithParams(context, {'isRefresh': false, 'value2': 4567});
          },
        ),
        ElevatedButton(
          child: const Text('点击返回 - pop'),
          onPressed: () {
            // 返回上级，以下效果一样
            // Navigator.of(context).pop();
            // Navigator.pop(context);

            // 效果同上，基于Navigator封装
            JhNavRouterUtils.goBack(context);
          },
        ),
        ElevatedButton(
          child: const Text('返回多级 - JhNavUtils'),
          onPressed: () {
            JhNavUtils.goBack(context);
            JhNavUtils.goBack(context);
            JhNavUtils.goBackWithParams(context, '456');
          },
        ),
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
