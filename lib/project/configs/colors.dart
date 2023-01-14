///  colors.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  颜色 配置

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/provider/theme_provider.dart';

/// 暗黑模式判断
extension ThemeExtension on BuildContext {
  // bool get jhIsDark => Theme.of(this).brightness == Brightness.dark;

  bool get jhIsDark => Provider.of<ThemeProvider>(this).isDark(this);
}

class KColors {
  /// 设置动态颜色
  static Color dynamicColor(BuildContext context, Color lightColor, [Color? darkColor]) {
    var isDark = context.jhIsDark;
    return isDark ? darkColor ?? lightColor : lightColor;
  }

  // 主题色（导航条背景、提交按钮背景、弹框确认文字、表单图标录入光标）
  // 暗黑模式高亮显示颜色按kThemeColor设置，如tabBar选中文字图标、提交按钮背景色、指示器选中下划线、光标等
  static const Color kThemeColor = Color(0xFF3BB815);
  static const Color kThemeDarkColor = Color(0xFF0A0A0A); // (10, 10, 10)
  static const Color kThemeBlueColor = Color(0xFF4688FA);
  static const Color kThemePurpleColor = Colors.purple;

  // 渐变色（appBar和按钮）
  static const Color kGradientStartColor = Color(0xFF2683BE); // 渐变开始色
  static const Color kGradientEndColor = Color(0xFF34CABE); // 渐变结束色

  // 渐变色
  // static const Color kGradientStartColor = Color(0xFF2171F5); // 渐变开始色
  // static const Color kGradientEndColor = Color(0xF000A2FC); // 渐变结束色

  // 导航条背景色（主题色背景白色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static const Color kNavThemeBgColor = kThemeColor;

  // 导航条背景色（白色背景色黑色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static const Color kNavWhiteBgColor = Color(0xFFEDEDED); //(237, 237, 237)
  static const Color kNavBgDarkColor = kThemeDarkColor; // (10, 10, 10)
  static const Color kNavTitleColor = Colors.white;

  // tabBar背景颜色
  static const Color kTabBarBgColor = Colors.white;
  static const Color kTabBarBgDarkColor = Color(0xFF1D1D1D); // (29, 29, 29)

  // tabBar默认文字颜色
  static const Color kTabBarNormalTextColor = kBlackTextColor;
  static const Color kTabBarNormalTextDarkColor = kBlackTextDarkColor;

  // tabBar选中文字颜色
  static const Color kTabBarSelectTextColor = kThemeColor;
  static const Color kTabBarSelectTextDarkColor = kThemeColor;

  // 背景色
  static const Color kBgColor = Color(0xFFF8F8F8); // (248, 248, 248)
  static const Color kBgDarkColor = Color(0xFF111111); // (17, 17, 17)

  // cell背景
  static const Color kCellBgColor = Colors.white;
  static const Color kCellBgDarkColor = Color(0xFF191919); // (25, 25, 25)

  static const Color kMaterialBgColor = Color(0xFFFFFFFF); // (255, 255, 255)
  static const Color kMaterialBgDarkColor = Color(0xFF303233); // (48, 50, 51)

  // btn背景颜色
  // static const Color kBtnBgColor = kThemeColor;
  // static const Color kBtnBgDarkColor = Color(0xFF2B2B2B); // (43, 43, 43)

  // 黑色文字
  static const Color kBlackTextColor = Color(0xFF333333); // (51, 51, 51)
  static const Color kBlackTextDarkColor = Color(0xFFC6C6C6); // (198, 198, 198)

  // 灰色文字
  static const Color kGreyTextColor = Color(0xFF777777); // (119, 119, 119)
  static const Color kGreyTextDarkColor = Color(0xFF787878); // (120, 120, 120)

  // 浅灰色文字
  static const Color kLightGreyTextColor = Color(0xFF999999); // (153, 153, 153)
  static const Color kLightGreyTextDarkColor = Color(0xFF666666); // (102, 102, 102)

  // 表单title文字
  static const Color kFormTitleColor = kBlackTextColor;
  static const Color kFormTitleDarkColor = kBlackTextDarkColor;

  // 表单info文字
  static const Color kFormInfoColor = kBlackTextColor;
  static const Color kFormInfoDarkColor = kBlackTextDarkColor;

  // 表单hint文字
  static const Color kFormHintColor = Color(0xFFBBBBBB); // (187, 187, 187)
  static const Color kFormHintDarkColor = Color(0xFF575757); // (87, 87, 87)

  // 表单分割线
  static const Color kFormLineColor = kLineColor;
  static const Color kFormLineDarkColor = kLineDarkColor;

  // 表单暗黑模式Focused状态下划线颜色
  static const Color kFocusedBorderDarkColor = kLineColor;

  // error颜色
  static const Color kErrorTextColor = Color(0xFFFF4759); // (255, 71, 89)
  static const Color kErrorTextDarkColor = Color(0xFFE03E4E); // (224, 62, 78)

  // 分割线
  static const Color kLineColor = Color(0xFFE6E6E6); // (230, 230, 230)
  static const Color kLineDarkColor = Color(0xFF232323); // (35, 35, 35)

  // 搜索框颜色
  static const Color kSearchBarBgColor = kCellBgColor;
  static const Color kSearchBarBgDarkColor = kCellBgDarkColor;

  // textView背景颜色
  static const Color kTextViewBgColor = Color(0xFFFAFAFA); // (250, 250, 250)
  static const Color kTextViewBgDarkColor = Color(0xFF323232); // (50, 50, 50)

  // toast背景颜色
  static const Color kToastBgColor = Colors.black87;
  static const Color kToastBgDarkColor = Color(0xFF2F2F2F); // (47, 47, 47)

  // alert背景颜色
  static const Color kAlertBgColor = Colors.white;
  static const Color kAlertBgDarkColor = Color(0xFF2C2C2C); // (44, 44, 44)
  static const Color kAlertInputBgColor = Colors.white;
  static const Color kAlertInputBgDarkColor = Color(0xFF1E1E1E); // (30, 30, 30)

  // picker、bottomSheet颜色
  static const Color kPickerBgColor = Colors.white;
  static const Color kPickerBgDarkColor = Color(0xFF1E1E1E); // (30, 30, 30)
  static const Color kPickerTitleColor = Color(0xFF787878); // (120, 120, 120)
  static const Color kPickerTitleDarkColor = Color(0xFF878787); // (135, 135, 135)
  static const Color kPickerTextColor = kBlackTextColor;
  static const Color kPickerTextDarkColor = kBlackTextDarkColor;
  static const Color kPickerRedTextDarkColor = Color(0xFFE64242); // (230, 66, 66)
  static const Color kPickerHeaderColor = kPickerBgColor;
  static const Color kPickerHeaderDarkColor = kPickerBgDarkColor;
  static const Color kPickerHeaderLineColor = kLineColor;
  static const Color kPickerHeaderLineDarkColor = kLineDarkColor;
  static const Color kPickerBtnColor = kBlackTextColor;
  static const Color kPickerBtnDarkColor = kBlackTextDarkColor;

  // icon颜色
  static const Color kIconColor = Color(0xFF646464); // (100, 100, 100)
  static const Color kIconDarkColor = Color(0xFFC8C8C8); // (200, 200, 200)

  // 微信主题色 rgb(59,184,21)
  static const Color wxThemeColor = Color(0xFF3BB815);
  static const Color wxThemeDarkColor = Color(0xFF00BE66);

  // rgb(50, 179, 116)
  static const Color wxPayColor = Color(0xFF32B374);

  // rgb(0, 174, 91)
  static const Color wxTextColor = Color(0xFF00AE5B);

  // rgb(255, 139, 34)
  static const Color wxTextOrangeColor = Color(0xFFFF8B22);

  static const Color wxTitleColor = Colors.white;

  // 微信背景色 rgb(237,237,237)
  static const Color wxBgColor = Color(0xFFEDEDED);

  // 深蓝色
  static const Color wxTextBlueColor = Color(0xFF586D98);

  static const Color transparent = Colors.transparent;
}

class Colours {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);
}
