import 'package:flutter/material.dart';

import 'package:jhtoast/jhtoast.dart';
import 'package:flustars/flustars.dart';

import 'package:jh_flutter_demo/jh_common/utils/jh_storage_utils.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';
import 'package:jh_flutter_demo/project/login/pages/login_page.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class SetPage extends StatelessWidget {
  final List titleData = ['我的 - 带点击事件', '我的2', "个人信息", "关于", "关于iOS", "退出登录"];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "设置",
      dataArr: titleData,
      callBack: (index, str) {
        if (str == "我的 - 带点击事件") {
          NavigatorUtils.pushNamed(context, "MinePage");
        }
        if (str == "我的2") {
          NavigatorUtils.pushNamed(context, "MinePage2");
        }
        if (str == "个人信息") {
          NavigatorUtils.pushNamed(context, "InfoPage");
        }

        if (str == "关于") {
          NavigatorUtils.pushNamed(context, "AboutPage");
        }
        if (str == "关于iOS") {
          NavigatorUtils.pushNamed(context, "AboutIOSPage");
        }

        if (str == "退出登录") {
          JhBottomSheet.showText(context, title: "请选择操作", redBtnTitle: "退出登录",
              clickCallback: (index, str) {
            if (str == "退出登录") {
              var hide = JhToast.showIOSLoadingText(
                context,
                msg: "正在退出...",
              );
              Future.delayed(Duration(seconds: 1), () {
                //退出时清除用户信息
                JhStorageUtils.removeWithKey(kUserDefault_UserInfo);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => route == null);

                hide();
              });
            }
          });
        }
      },
    );
  }
}
