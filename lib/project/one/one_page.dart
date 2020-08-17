import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/strings.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart' as Luyou;

import 'package:jh_flutter_demo/jh_common/widgets/jh_pop_menus.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_qr_code_utils.dart';

class OnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //1.首先先需要对控件进行渲染  初始化GlobalKey ：
    GlobalKey anchorKey = GlobalKey();

    return Scaffold(

//        appBar: AppBar(
//          title:
//              Text(KString.oneTabTitle, style: TextStyle(color: Colors.white)),
//          elevation: 0.0,
//          actions: <Widget>[
//            //2.在需要测量的控件的下面添加key：
//            IconButton(
//              key: anchorKey,
//              icon: Image.asset(
//                'assets/images/ic_nav_add.png',
//                width: 26,
//                height: 26,
//              ),
//              onPressed: () {
//                //3.获取控件的坐标：
//                //控件的横坐标：offset.dx
//                //控件的纵坐标：offset.dy
//                RenderBox renderBox =
//                    anchorKey.currentContext.findRenderObject();
//                var offset = renderBox.localToGlobal(Offset.zero);
//                print('控件的坐标：${offset}');
//                //控件正下方的坐标：
//                var offset2 =
//                    renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
//                print('控件正下方的坐标：${offset2}');
//                JhPopMenus.show(context);
//              },
//            )
//          ],
//        ),

        appBar: baseAppBar(context, KString.oneTabTitle,
            rightImgPath: 'assets/images/ic_nav_add.png',
            rightItemCallBack: () {
//          //不带分割线，不带背景
//          JhPopMenus.show(context, clickCallback: (index, selText) {
//            print('选中index: ${index}');
//            print('选中text: ${selText}');
//          });

          // 带分割线不带背景
          JhPopMenus.showLinePop(context, clickCallback: (index, selText) {
            print('选中index: ${index}');
            print('选中text: ${selText}');

            if (selText == '扫一扫') {
              // 延时执行
              Future.delayed(Duration(milliseconds: 400), () {
                JhQrCodeUtils.scan().then((value) => () {
                      print(value);
                    });
              });
            }
          });

//          // 带分割线带背景
//          JhPopMenus.showLinePop(context, isShowBg: true,
//              clickCallback: (index, selText) {
//            print('选中index: ${index}');
//            print('选中text: ${selText}');
//          });
        }),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("跳转Demo"),
              onPressed: () {
                NavigatorUtils.pushNamed(context, Luyou.demoListsPage);
              },
            ),
          ],
        ));
  }
}
