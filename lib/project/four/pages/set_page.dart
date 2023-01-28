// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/project/configs/project_config.dart';
import '/project/login/login_router.dart';
import '/project/login/pages/login_page.dart';

final List titleData = [
  '原我的界面',
  '个人信息',
  '图片下拉放大',
  '图片下拉放大2',
  '图片下拉放大3 - 图片固定顶部',
  '个人主页 - SliverAppBar+tabbar',
  '个人主页2',
  '导航条渐变显隐',
  '主题设置',
  '关于',
  '关于iOS',
  'web版',
  '退出登录'
];

class SetPage extends StatelessWidget {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '设置',
      dataArr: titleData,
      callBack: (index, str) {
        if (str == '原我的界面') {
          JhNavUtils.pushNamed(context, 'MinePage');
        }
        if (str == '个人信息') {
          JhNavUtils.pushNamed(context, 'InfoPage');
        }
        if (str == '图片下拉放大') {
          JhNavUtils.pushNamed(context, 'ImgPullDownBigPage');
        }
        if (str == '图片下拉放大2') {
          JhNavUtils.pushNamed(context, 'ImgPullDownBigPage2');
        }
        if (str == '图片下拉放大3 - 图片固定顶部') {
          JhNavUtils.pushNamed(context, 'ImgPullDownBigPage3');
        }
        if (str == '个人主页 - SliverAppBar+tabbar') {
          JhNavUtils.pushNamed(context, 'PersonCenterPage');
        }
        if (str == '个人主页2') {
          JhNavUtils.pushNamed(context, 'PersonCenterPage2');
        }
        if (str == '导航条渐变显隐') {
          JhNavUtils.pushNamed(context, 'FadeAppBarPage');
        }
        if (str == '主题设置') {
          JhNavUtils.pushNamed(context, 'ThemePage');
        }
        if (str == '关于') {
          JhNavUtils.pushNamed(context, 'AboutPage');
        }
        if (str == '关于iOS') {
          JhNavUtils.pushNamed(context, 'AboutIOSPage');
        }
        if (str == 'web版') {
          var title = 'jh_flutter_demo';
          var url = 'https://iotjin.github.io/jh_flutter_demo';
          if (JhDeviceUtils.isWeb) {
            JhCommonUtils.launchWebURL(url);
          } else {
            JhNavUtils.jumpWebViewPage(context, title, url);
          }
        }

        if (str == '退出登录') {
          JhBottomSheet.showText(context, title: '请选择操作', redBtnTitle: '退出登录', clickCallback: (index, str) {
            if (str == '退出登录') {
              var hide = JhToast.showIOSLoadingText(
                context,
                msg: '正在退出...',
              );
              Future.delayed(const Duration(seconds: 1), () {
                // 退出时清除用户信息
                JhAESStorageUtils.remove(kUserDefault_UserInfo);

                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                //   (route) => false,
                // );

                JhNavUtils.pushReplacement(context, LoginRouter.pLoginPage);

                hide();
              });
            }
          });
        }
      },
    );
  }
}
