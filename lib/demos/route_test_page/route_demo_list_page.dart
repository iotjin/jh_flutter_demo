import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = ['跳转传值与回传、多级返回', '监听页面出现与消失', '禁用手势返回和安卓返回键'];
final List routeData = ['PassValuePage', 'RouteTestPage1', 'RouteTestPage2'];

class RouteDemoListPage extends StatelessWidget {
  const RouteDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '路由相关',
      dataArr: titleData,
      callBack: (index, str) {
        if (str == '禁用手势返回和安卓返回键') {
          JhNavUtils.pushNamedResult(context, 'RouteTestPage2', {}, (returnData) {
            if (returnData['isRefresh'] == true) {
              _requestData();
            }
          });
        } else {
          JhNavUtils.pushNamed(context, routeData[index]);
        }
      },
    );
  }

  void _requestData() {
    JhProgressHUD.showLoadingText();
    Future.delayed(const Duration(seconds: 1), () {
      JhProgressHUD.hide();
    });
  }
}
