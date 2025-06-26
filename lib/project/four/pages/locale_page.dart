///  locale_page.dart
///
///  Created by iotjin on 2024/03/15.
///  description:

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/intl/locale_utils.dart';
import '/project/provider/theme_provider.dart';
import '/project/configs/project_config.dart';

class LocalePage extends StatefulWidget {
  const LocalePage({super.key});

  @override
  State<LocalePage> createState() => _LocalePageState();
}

class _LocalePageState extends State<LocalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(IntlKeys.language.tr),
      body: _body(),
    );
  }

  Widget _body() {
    List dataArr = LocaleUtils.getLocaleList();
    // TODO: 通过ThemeProvider进行主题管理
    final themeProvider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, themeProvider.getThemeColor(), KColors.kThemeColor);

    var localeMode = LocaleUtils.getLocaleMode();

    return ListView.separated(
      itemCount: dataArr.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, int index) {
        var item = dataArr[index];
        return InkWell(
          onTap: () {
            print('选中语言: ${item['label']}');
            setState(() {
              LocaleUtils.setLocale(item['localeMode']);
            });
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 50.0,
            child: Row(
              children: <Widget>[
                Expanded(child: Text(item['label'])),
                Opacity(
                  opacity: (localeMode == item['localeMode'] || (localeMode == '' && item['localeMode'] == 'system')) ? 1 : 0,
                  child: Icon(Icons.done, color: themeColor),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
