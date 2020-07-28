import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

class AlertDemoListsPage extends StatelessWidget {

  final List titleData = ["底部弹框","中间弹框","toast","JhToast","JhDialog"];
  final List routeData = ["BottomSheetTest","AlertTestPage","ToastDemoListsPage","ToastTestPage","JhDialogTestPage"];

  @override
  Widget build(BuildContext context) {
    return  JhTextList(
        title: "AlertDemoLists",dataArr: titleData,
        callBack: (index,str){
          NavigatorUtils.pushNamed(context, routeData[index]);
        },
    );

  }
}
