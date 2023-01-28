import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/base_appbar.dart';

class UIPage2 extends StatefulWidget {
  const UIPage2({Key? key}) : super(key: key);

  @override
  State<UIPage2> createState() => _UIPage2State();
}

class _UIPage2State extends State<UIPage2> {
  bool _switchSelected = false;
  bool _checkboxSelected = false;
  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('UITest2'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        /*
                      activeColor → Color - 激活时原点的颜色。
                      activeThumbImage → ImageProvider - 原点还支持图片，激活时的效果。
                      activeTrackColor → Color - 激活时横条的颜色。
                      inactiveThumbColor → Color - 非激活时原点的颜色。
                      inactiveThumbImage → ImageProvider - 非激活原点的图片效果。
                      inactiveTrackColor → Color - 非激活时横条的颜色。
                      onChanged → ValueChanged - 改变时触发。
                      value → bool - 切换按钮的值。
                    * */
        Switch(
          // 当前状态
          value: _switchSelected,
          // 激活时原点颜色
          activeColor: Colors.blue,
          inactiveTrackColor: Colors.blue.shade50,
          onChanged: (value) {
            // 重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        CupertinoSwitch(
          value: _switchSelected,
          onChanged: (value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.snooze),
          activeColor: Colors.red,
          title: const Text('闹钟1'),
          value: _switchSelected,
          onChanged: (bool value) {
            setState(() {
              _switchSelected = !_switchSelected;
            });
          },
        ),

        /*
                    Checkbox 复选框
                    value	是否选中此复选框
                    onChanged	监听 当复选框的值应该更改时调用
                    tristate	默认false，如果为true，复选框的值可以为true、false或null。
                    activeColor	选中此复选框时要使用的颜色
                    checkColor	选中此复选框时用于复选图标的颜色
                    materialTapTargetSize	配置tap目标的最小大小


                    CheckboxListTile 复选框
                    value	是否选中此复选框
                    onChanged	监听 当复选框的值应该更改时调用
                    activeColor	选中此复选框时要使用的颜色
                    title	列表主标题
                    subtitle	列表副标题
                    isThreeLine	默认false
                    dense	此列表平铺是否是垂直密集列表的一部分。
                    secondary	显示在复选框前面的小部件
                    selected	选中后文字高亮，默认false
                    controlAffinity
                    控件相对于文本的位置，
                    默认 ListTileControlAffinity.platform

                    * */
        Checkbox(
          value: _checkboxSelected,
          // 选中时的颜色
          activeColor: Colors.red,
          onChanged: (bool? value) {
            setState(() {
              _checkboxSelected = value!;
            });
          },
        ),
        CheckboxListTile(
          secondary: const Icon(Icons.snooze),
          title: const Text('闹钟2'),
          activeColor: Colors.red,
          value: _checkboxSelected,
          onChanged: (bool? value) {
            setState(() {
              _checkboxSelected = !_checkboxSelected;
            });
          },
        ),
        Radio(
            value: 1,
            activeColor: Colors.red,
            groupValue: radioValue,
            onChanged: (int? value) {
              setState(() {
                radioValue = value!;
              });
            }),
        RadioListTile(
            title: const Text('第二个单选按钮'),
            value: 2,
            activeColor: Colors.red,
            groupValue: radioValue,
            onChanged: (int? value) {
              setState(() {
                radioValue = value!;
              });
            }),
        RadioListTile(
            title: const Text('第三个单选按钮'),
            value: 3,
            activeColor: Colors.red,
            groupValue: radioValue,
            onChanged: (int? value) {
              setState(() {
                radioValue = value!;
              });
            })
      ],
    );
  }
}
