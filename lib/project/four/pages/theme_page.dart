///  theme_page.dart
///
///  Created by iotjin on 2022/07/28.
///  description:

// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/project/configs/project_config.dart';
import '/project/provider/theme_provider.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  var _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('主题设置'),
      body: _body(),
    );
  }

  // 只有主题列表
  // ignore: unused_element
  Widget _body2() {
    final provider = Provider.of<ThemeProvider>(context);
    List dataArr = provider.getThemeList();
    return ListView.separated(
      itemCount: dataArr.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        var item = dataArr[index];
        return _cell(item);
      },
    );
  }

  Widget _body() {
    final provider = Provider.of<ThemeProvider>(context);
    _isOpen = provider.isFollowSystem;

    Widget topWidget = JhSetCell(
      title: '跟随系统',
      hiddenLine: true,
      hiddenArrow: true,
      rightWidget: CupertinoSwitch(
        value: _isOpen,
        onChanged: (value) {
          setState(() {
            _isOpen = value;
            if (_isOpen) {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeMethod.themeSystem);
            } else {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeMethod.themeLight);
            }
          });
        },
      ),
    );

    List dataArr = provider.getThemeList();
    List<Widget> widgetList = dataArr.map((item) => _cell(item)).toList();
    widgetList.insert(0, topWidget);

    return ListView(
      children: widgetList,
    );
  }

  Widget _cell(item) {
    final provider = Provider.of<ThemeProvider>(context);
    return Visibility(
      visible: !_isOpen,
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          color: item['value'],
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(item['label'], style: const TextStyle(color: Colors.white)),
              ),
              Opacity(
                opacity: provider.getThemeColor() == item['value'] ? 1 : 0,
                child: const Icon(Icons.done, color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () => _onClickCell(item),
      ),
    );
  }

  _onClickCell(item) {
    print('选中主题: $item');
    setState(() {
      Provider.of<ThemeProvider>(context, listen: false).setTheme(item['themeMode']);
    });
  }
}
