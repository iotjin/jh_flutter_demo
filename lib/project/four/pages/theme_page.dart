///  theme_page.dart
///
///  Created by iotjin on 2022/07/28.
///  description:

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
      appBar: BaseAppBar('主题设置'),
      body: _body(context),
    );
  }

  // 只有主题列表
  // ignore: unused_element
  Widget _body2(context) {
    final provider = Provider.of<ThemeProvider>(context);
    List _dataArr = provider.getThemeList();
    return ListView.separated(
      itemCount: _dataArr.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        var item = _dataArr[index];
        return _cell(context, item);
      },
    );
  }

  Widget _body(context) {
    final provider = Provider.of<ThemeProvider>(context);
    _isOpen = provider.isFollowSystem;

    Widget _topWidget = JhSetCell(
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

    List _dataArr = provider.getThemeList();
    List<Widget> _widgetList = _dataArr.map((item) => _cell(context, item)).toList();
    _widgetList.insert(0, _topWidget);

    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: _widgetList,
        ),
      ),
    );
  }

  Widget _cell(context, item) {
    final provider = Provider.of<ThemeProvider>(context);
    return Visibility(
      visible: !_isOpen,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          color: item['value'],
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(item['label'], style: TextStyle(color: Colors.white)),
              ),
              Opacity(
                opacity: provider.getThemeColor() == item['value'] ? 1 : 0,
                child: const Icon(Icons.done, color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () => _onClickCell(context, item),
      ),
    );
  }

  _onClickCell(context, item) {
    print('选中主题: $item');
    setState(() {
      Provider.of<ThemeProvider>(context, listen: false).setTheme(item['themeMode']);
    });
  }
}
