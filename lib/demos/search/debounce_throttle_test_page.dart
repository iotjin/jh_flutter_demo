// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/configs/project_config.dart';

class DebounceThrottleTestPage extends StatefulWidget {
  const DebounceThrottleTestPage({Key? key}) : super(key: key);

  @override
  State<DebounceThrottleTestPage> createState() => _DebounceThrottleTestPageState();
}

class _DebounceThrottleTestPageState extends State<DebounceThrottleTestPage> {
  var _keyWord = '';
  var _keyWord1 = '';
  var _keyWord2 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('防抖/节流'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: <Widget>[
        _input(),
        _input1(),
        _input2(),
        const SizedBox(height: 30),
        JhButton(
            text: '按钮-未处理',
            onPressed: () {
              print('点击按钮-未处理');
              JhProgressHUD.showText('点击按钮-未处理');
            }),
        const SizedBox(height: 15),
        JhButton(
            text: '按钮-防抖1',
            onPressed: () {
              print('点击按钮-防抖1');
              JhCommonUtils.debounce(() => _clickDebounceBtn1(), 1000);
            }),
        const SizedBox(height: 15),
        JhButton(
            text: '按钮-防抖2',
            onPressed: JhCommonUtils.debounce2(() {
              print('防抖后 - 点击按钮-防抖2');
              JhProgressHUD.showText('点击按钮-防抖2，2000ms');
            }, 2000)),
        const SizedBox(height: 15),
        JhButton(
          text: '按钮-节流1',
          onPressed: () {
            print('点击按钮-节流1');
            JhCommonUtils.throttle(() => _clickThrottleBtn1(), 2000);
          },
        ),
        const SizedBox(height: 15),
        JhButton(
          text: '按钮-节流2',
          onPressed: JhCommonUtils.throttle2(() {
            print('节流后 - 点击按钮-节流2');
            JhProgressHUD.showText('点击按钮-节流2，2000ms');
          }, 2000),
        ),
      ],
    );
  }

  _clickDebounceBtn1() {
    print('防抖后 - 点击按钮-防抖1');
    JhProgressHUD.showText('点击按钮-防抖1，1000ms');
  }

  _clickThrottleBtn1() {
    print('节流后 - 点击按钮-节流1');
    JhProgressHUD.showText('点击按钮-节流1，2000ms');
  }

  _input() {
    return JhFormInputCell(
      title: '未处理:',
      text: _keyWord,
      hintText: '请输入',
      maxLength: 140,
      textInputAction: TextInputAction.search,
      inputCallBack: (value) {
        print('未处理 _keyWord : $value');
        setState(() {
          _keyWord = value;
          // 其他操作
          JhProgressHUD.showText('未处理 _keyWord : $value');
        });
      },
    );
  }

  _input1() {
    return JhFormInputCell(
      title: '防抖1:',
      text: _keyWord1,
      hintText: '请输入',
      maxLength: 140,
      textInputAction: TextInputAction.search,
      inputCallBack: (value) {
        print('防抖1 未处理1 _keyWord1 : $value');
        JhCommonUtils.debounce(() => _inputCallBack1(value, false), 500);
      },
      inputCompletionCallBack: (value, isSubmitted) {
        print('防抖1 未处理2 _keyWord1 : $value');
        if (isSubmitted) {
          print('防抖1 未处理3 _keyWord1 : $value');
          JhCommonUtils.debounce(() => _inputCallBack1(value, true), 500);
        }
      },
    );
  }

  _input2() {
    return JhFormInputCell(
      title: '防抖2:',
      text: _keyWord2,
      hintText: '请输入',
      maxLength: 140,
      textInputAction: TextInputAction.search,
      inputCallBack: JhCommonUtils.debounceInput((value) {
        print('防抖后 防抖2 _keyWord2 : $value');
        JhProgressHUD.showText('防抖2 _keyWord2 : $value');
        setState(() {
          _keyWord2 = value;
          // 其他操作
        });
      }, 500),
      inputCompletionCallBack: (value, isSubmitted) {
        print('防抖2 未处理2 _keyWord2 : $value');
        if (isSubmitted) {
          print('防抖2 未处理3 _keyWord2 : $value');
          JhCommonUtils.debounce(() => _inputCallBack2(value, true), 500);
        }
      },
    );
  }

  _inputCallBack1(value, isSubmitted) {
    print('防抖后 防抖1 _keyWord1 : $value');
    JhProgressHUD.showText('防抖1 _keyWord1 : $value');
    setState(() {
      _keyWord1 = value;
      // 其他操作
    });
  }

  _inputCallBack2(value, isSubmitted) {
    print('防抖后 防抖2 _keyWord2 : $value');
    JhProgressHUD.showText('防抖2 _keyWord2 : $value');
    setState(() {
      _keyWord2 = value;
      // 其他操作
    });
  }
}
