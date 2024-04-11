///  locale_utils.dart
///
///  Created by iotjin on 2024/03/15.
///  description: 多语言工具类

import 'dart:ui';
import 'package:get/get.dart';
import '/jh_common/utils/jh_storage_utils.dart';

const String _appLocaleKey = 'AppLocale';
const Locale chineseLocale = Locale('zh', 'CN');
const Locale englishLocale = Locale('en', 'US');

class LocaleUtils {
  /// 获取系统语言
  // static Locale? get deviceLocale => Get.deviceLocale;
  static Locale? get deviceLocale => PlatformDispatcher.instance.locale;

  /// 当指定语言不存在时，使用的语言
  static final fallbackLocale = chineseLocale;

  /// 支持的语言列表
  static final supportedLocales = [
    chineseLocale,
    englishLocale,
  ];

  /// 获取当前语言
  static Locale? get currentLocale {
    final String localeMode = getLocaleMode();
    var locale = getLocaleList().firstWhere((item) => item['localeMode'] == localeMode, orElse: () => null);
    if (locale != null) {
      return locale['value'];
    }
    return deviceLocale;
    // return const Locale('zh', 'CN');
    // return const Locale('en', 'US');
  }

  /// 设置语言
  static void setLocale(String localeMode) {
    JhAESStorageUtils.saveString(_appLocaleKey, localeMode);
    var locale = getLocaleList().firstWhere((item) => item['localeMode'] == localeMode, orElse: () => null);
    if (locale != null) {
      // Get.updateLocale(Locale('zh', 'CN'));
      // Get.updateLocale(Locale('en', 'US'));
      Get.updateLocale(locale['value']);
    }
  }

  /// 获取语言列表
  static List getLocaleList() {
    return [
      {'label': '跟随系统', 'value': deviceLocale, 'localeMode': 'system'},
      {'label': '简体中文', 'value': const Locale('zh', 'CN'), 'localeMode': 'zhCN'},
      {'label': 'English', 'value': const Locale('en', 'US'), 'localeMode': 'enUS'},
    ];
  }

  /// 获取当前语言类型
  static String getLocaleMode() {
    final String locale = JhAESStorageUtils.getString(_appLocaleKey) ?? '';
    return locale;
  }

  /// 当前语言是否是中文
  static bool get isChinese => currentLocale?.languageCode == chineseLocale;
}

/*
    // 获取系统语言
    // Locale locale = ui.window.locale; // 已过时
    // Locale systemLocale = PlatformDispatcher.instance.locale;
    // var languageCode = systemLocale.languageCode; // 获取语言代码
    // var countryCode = systemLocale.countryCode; // 获取国家/地区代码
    // print('System language: $languageCode-$countryCode');

*/
