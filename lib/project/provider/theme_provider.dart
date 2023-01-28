///  theme_provider.dart
///
///  Created by iotjin on 2022/07/10.
///  description: 主题管理

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/jh_common/utils/jh_color_utils.dart';
import '/jh_common/utils/jh_status_bar_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/project/configs/colors.dart';

const String _appThemeKey = 'AppTheme';
const String _themeSystem = 'System';
const String _themeLight = 'Light';
const String _themeDark = 'Dark';
const String _themeBlue = 'Blue';
const String _themePurple = 'Purple';
const Color _lightThemeColor = KColors.kThemeColor;
const Color _darkThemeColor = KColors.kThemeDarkColor;
const Color _blueThemeColor = KColors.kThemeBlueColor;
const Color _purpleThemeColor = KColors.kThemePurpleColor;

enum ThemeMethod { themeSystem, themeLight, themeDark, themeBlue, themePurple }

/// 使用：_methodValues[ThemeMethod.themeSystem]
const _methodValues = {
  ThemeMethod.themeSystem: _themeSystem,
  ThemeMethod.themeLight: _themeLight,
  ThemeMethod.themeDark: _themeDark,
  ThemeMethod.themeBlue: _themeBlue,
  ThemeMethod.themePurple: _themePurple,
};

/// app的设置是否高于系统设置
/// 需要设置为true,并在 lib/project/configs/colors.dart 调用 provider.isDark()方法
const bool isPriorityApp = true;

class ThemeProvider extends ChangeNotifier {
  /// 是否跟随系统
  bool get isFollowSystem =>
      getThemeMode() == ThemeMode.system && getThemeColor() != _blueThemeColor && getThemeColor() != _purpleThemeColor;

  /// 获取主题列表
  List getThemeList() {
    return [
      {'label': '浅色', 'value': _lightThemeColor, 'themeMode': ThemeMethod.themeLight},
      {'label': '深色', 'value': _darkThemeColor, 'themeMode': ThemeMethod.themeDark},
      {'label': '蓝色', 'value': _blueThemeColor, 'themeMode': ThemeMethod.themeBlue},
      {'label': '紫色', 'value': _purpleThemeColor, 'themeMode': ThemeMethod.themePurple}
    ];
  }

  /// 设置主题
  void setTheme([ThemeMethod themeMode = ThemeMethod.themeLight]) {
    JhAESStorageUtils.saveString(_appThemeKey, _methodValues[themeMode]!);
    notifyListeners();
  }

  /// 暗黑模式判断
  bool isDark(BuildContext context) {
    if (!isPriorityApp) {
      return Theme.of(context).brightness == Brightness.dark;
    } else {
      if (isFollowSystem) {
        return Theme.of(context).brightness == Brightness.dark;
      } else {
        return getThemeColor() == KColors.kThemeDarkColor;
      }
    }
  }

  /// 获取当前主题模式
  ThemeMode getThemeMode() {
    final String theme = JhAESStorageUtils.getString(_appThemeKey) ?? '';
    switch (theme) {
      case _themeLight:
        return ThemeMode.light;
      case _themeDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// 获取当前主题色
  Color getThemeColor() {
    final String theme = JhAESStorageUtils.getString(_appThemeKey) ?? '';
    switch (theme) {
      case _themeLight:
        return _lightThemeColor;
      case _themeDark:
        return _darkThemeColor;
      case _themeBlue:
        return _blueThemeColor;
      case _themePurple:
        return _purpleThemeColor;
      default:
        return _lightThemeColor;
    }
  }

  /// 获取主题配置
  ThemeData getThemeData({bool isDarkMode = false}) {
    // return MyThemes.lightTheme;
    if (isPriorityApp && !isFollowSystem && getThemeColor() != _darkThemeColor) {
      isDarkMode = false;
    }
    return MyThemes.getThemeData(getThemeColor(), isDarkMode: isDarkMode);
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
    primarySwatch: JhColorUtils.materialColor(KColors.kThemeColor),
    primaryColor: KColors.kThemeColor,
  );

  static getThemeData(Color themeColor, {bool isDarkMode = false}) {
    // 暗黑模式高亮显示颜色
    var darkPrimaryThemeColor = KColors.kThemeColor;

    return ThemeData(
      primarySwatch: JhColorUtils.materialColor(themeColor),
      primaryColor: themeColor,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? KColors.kBgDarkColor : KColors.kBgColor,
      // 导航条在base_appbar页面配置（没使用base_appbar的按下面配置的）
      appBarTheme: AppBarTheme(
        systemOverlayStyle: JhStatusBarUtils.getStatusBarStyle(isDark: isDarkMode),
        color: isDarkMode ? KColors.kNavBgDarkColor : themeColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // 主界面tabbar，在base_tabbar页面配置
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: KColors.kTabBarSelectTextColor,
      //   unselectedItemColor: KColors.kTabBarNormalTextColor,
      // ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        secondary: isDarkMode ? KColors.kThemeDarkColor : themeColor,
      ),
      // 分割线
      dividerTheme: DividerThemeData(color: isDarkMode ? KColors.kLineDarkColor : KColors.kLineColor),
      // Tab指示器颜色
      indicatorColor: isDarkMode ? darkPrimaryThemeColor : themeColor,
      // 文字选择色（输入框选择文字等）
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkMode ? darkPrimaryThemeColor.withAlpha(70) : themeColor.withAlpha(70),
        selectionHandleColor: isDarkMode ? darkPrimaryThemeColor : themeColor,
        cursorColor: isDarkMode ? darkPrimaryThemeColor : themeColor, // 光标
      ),

      // 主要用于Material背景色
      // canvasColor: isDarkMode ? KColors.kMaterialBgDarkColor : KColors.kMaterialBgColor,
      // errorColor: isDarkMode ? KColors.kErrorTextDarkColor : KColors.kErrorTextColor,
      // cupertinoOverrideTheme: CupertinoThemeData(
      //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // ),
      // visualDensity: VisualDensity.standard,
    );
  }
}

/*

factory ThemeData({
  Brightness brightness, // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色。
  MaterialColor primarySwatch,// 定义一个单一的颜色以及十个色度的色块。
  Color primaryColor, // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
  Brightness primaryColorBrightness, // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
  Color primaryColorLight, // primaryColor的浅色版
  Color primaryColorDark, // primaryColor的深色版
  Color accentColor, // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
  Brightness accentColorBrightness, // accentColor的亮度。
  Color canvasColor, //  MaterialType.canvas 的默认颜色
  Color scaffoldBackgroundColor, // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
  Color bottomAppBarColor, // BottomAppBar的默认颜色
  Color cardColor, // Card的颜色
  Color dividerColor, // Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等。
  Color highlightColor, // 选中在泼墨动画期间使用的突出显示颜色，或用于指示菜单中的项。
  Color splashColor,  // 墨水飞溅的颜色。InkWell
  InteractiveInkFeatureFactory splashFactory, // 定义由InkWell和InkResponse反应产生的墨溅的外观。
  Color selectedRowColor, // 用于突出显示选定行的颜色。
  Color unselectedWidgetColor, // 用于处于非活动(但已启用)状态的小部件的颜色。例如，未选中的复选框。通常与accentColor形成对比。也看到disabledColor。
  Color disabledColor, // 禁用状态下部件的颜色，无论其当前状态如何。例如，一个禁用的复选框(可以选中或未选中)。
  Color buttonColor, // RaisedButton按钮中使用的Material 的默认填充颜色。
  ButtonThemeData buttonTheme, // 定义按钮部件的默认配置，如RaisedButton和FlatButton。
  Color secondaryHeaderColor, // 选定行时PaginatedDataTable标题的颜色。
  Color textSelectionColor, // 文本框中文本选择的颜色，如TextField
  Color cursorColor, // 文本框中光标的颜色，如TextField
  Color textSelectionHandleColor,  // 用于调整当前选定的文本部分的句柄的颜色。
  Color backgroundColor, // 与主色形成对比的颜色，例如用作进度条的剩余部分。
  Color dialogBackgroundColor, // Dialog 元素的背景颜色
  Color indicatorColor, // 选项卡中选定的选项卡指示器的颜色。
  Color hintColor, // 用于提示文本或占位符文本的颜色，例如在TextField中。
  Color errorColor, // 用于输入验证错误的颜色，例如在TextField中
  Color toggleableActiveColor, // 用于突出显示Switch、Radio和Checkbox等可切换小部件的活动状态的颜色。
  String fontFamily, // 文本字体
  TextTheme textTheme, // 文本的颜色与卡片和画布的颜色形成对比。
  TextTheme primaryTextTheme, // 与primaryColor形成对比的文本主题
  TextTheme accentTextTheme, // 与accentColor形成对比的文本主题。
  InputDecorationTheme inputDecorationTheme, // 基于这个主题的 InputDecorator、TextField和TextFormField的默认InputDecoration值。
  IconThemeData iconTheme, // 与卡片和画布颜色形成对比的图标主题
  IconThemeData primaryIconTheme, // 与primaryColor形成对比的图标主题
  IconThemeData accentIconTheme, // 与accentColor形成对比的图标主题。
  SliderThemeData sliderTheme,  // 用于呈现Slider的颜色和形状
  TabBarTheme tabBarTheme, // 用于自定义选项卡栏指示器的大小、形状和颜色的主题。
  CardTheme cardTheme, // Card的颜色和样式
  ChipThemeData chipTheme, // Chip的颜色和样式
  TargetPlatform platform,
  MaterialTapTargetSize materialTapTargetSize, // 配置某些Material部件的命中测试大小
  PageTransitionsTheme pageTransitionsTheme,
  AppBarTheme appBarTheme, // 用于自定义Appbar的颜色、高度、亮度、iconTheme和textTheme的主题。
  BottomAppBarTheme bottomAppBarTheme, // 自定义BottomAppBar的形状、高度和颜色的主题。
  ColorScheme colorScheme, // 拥有13种颜色，可用于配置大多数组件的颜色。
  DialogTheme dialogTheme, // 自定义Dialog的主题形状
  Typography typography, // 用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何TextTheme值。
  CupertinoThemeData cupertinoOverrideTheme
})

*/
