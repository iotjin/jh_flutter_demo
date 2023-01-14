///  wx_home_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信首页

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/utils/jh_qr_code_utils.dart';
import '/jh_common/widgets/jh_pop_menus.dart';
import '/project/configs/project_config.dart';
import '../models/wx_home_model.dart';
import '../widgets/wx_home_cell.dart';

List _dataArr = [
  {
    'title': 'Demo 列表',
    'subtitle': '点击跳转demo列表',
    'img': 'assets/images/ic_demo1.png',
    'time': '',
    'isNew': false,
    'type': '0',
  },
  {
    'title': '微信运动',
    'subtitle': '[应用消息]',
    'img': 'assets/wechat/home/wechat_motion.png',
    'time': '22:23',
    'isNew': true,
    'type': '1',
  },
  {
    'title': '订阅号消息',
    'subtitle': '新闻联播开始啦',
    'img': 'assets/wechat/home/ic_subscription_number.png',
    'time': '19:00',
    'isNew': true,
    'type': '1',
  },
  {
    'title': 'QQ邮箱提醒',
    'subtitle': '您有一封新的邮件，请前往查收',
    'img': 'assets/wechat/home/Ic_email.png',
    'time': '17:30',
    'isNew': false,
    'type': '3',
  },
  {
    'title': '张三',
    'subtitle': '欢迎欢迎',
    'img': 'assets/images/picture/touxiang_1.jpeg',
    'time': '17:30',
    'isNew': false,
    'type': '2',
  },
  {
    'title': '李四',
    'subtitle': 'hello',
    'img': 'assets/images/picture/touxiang_2.jpeg',
    'time': '17:30',
    'isNew': false,
    'type': '2',
  },
  {
    'title': '王五',
    'subtitle': '[图片]',
    'img': 'assets/images/picture/touxiang_3.jpeg',
    'time': '17:30',
    'isNew': false,
    'type': '2',
  },
  {
    'title': '赵六',
    'subtitle': '[动画表情]',
    'img': 'assets/images/picture/touxiang_4.jpeg',
    'time': '17:30',
    'isNew': false,
    'type': '2',
  },
  {
    'title': '微信团队',
    'subtitle': '安全登录提醒',
    'img': 'assets/wechat/home/ic_about.png',
    'time': '2020/8/8',
    'isNew': false,
    'type': '1',
  },
];

class WxHomePage extends StatefulWidget {
  const WxHomePage({Key? key}) : super(key: key);

  @override
  State<WxHomePage> createState() => _WxHomePageState();
}

class _WxHomePageState extends State<WxHomePage> {
  @override
  Widget build(BuildContext context) {
    // // 1.首先先需要对控件进行渲染  初始化GlobalKey ：
    // GlobalKey anchorKey = GlobalKey();

    return Scaffold(
      appBar: BaseAppBar(
        KStrings.oneTabTitle,
        leftWidget: Container(),
        rightImgPath: 'assets/images/ic_nav_add.png',
        rightItemCallBack: () => _showPop(),
      ),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),

//        appBar: AppBar(
//          title:
//              Text(KStrings.oneTabTitle, style: TextStyle(color: Colors.white)),
//          elevation: 0.0,
//          actions: <Widget>[
//            // 2.在需要测量的控件的下面添加key：
//            IconButton(
//              key: anchorKey,
//              icon: Image.asset(
//                'assets/images/ic_nav_add.png',
//                width: 26,
//                height: 26,
//              ),
//              onPressed: () {
//                // 3.获取控件的坐标：
//                // 控件的横坐标：offset.dx
//                // 控件的纵坐标：offset.dy
//                RenderBox renderBox =
//                    anchorKey.currentContext.findRenderObject();
//                var offset = renderBox.localToGlobal(Offset.zero);
//                print('控件的坐标：${offset}');
//                // 控件正下方的坐标：
//                var offset2 =
//                    renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
//                print('控件正下方的坐标：${offset2}');
//                JhPopMenus.show(context);
//              },
//            )
//          ],
//        ),
    );
  }

  // 右上角pop
  void _showPop() {
//    // 不带分割线，不带背景
//    JhPopMenus.show(context, clickCallback: (index, selText) {
//      print('选中index: ${index}');
//      print('选中text: ${selText}');
//    });
//    // 带分割线带背景
//    JhPopMenus.showLinePop(context, isShowBg: true,
//        clickCallback: (index, selText) {
//      print('选中index: ${index}');
//      print('选中text: ${selText}');
//    });

    // 带分割线不带背景
    JhPopMenus.showLinePop(context, clickCallback: (index, selText) {
      print('选中index: $index');
      print('选中text: $selText');

      if (selText == '添加朋友') {
        JhNavUtils.pushNamed(context, 'WxAddFriendPage');
      }
      if (selText == '扫一扫') {
        _scan();
      }
    });
  }

  // body
  Widget _body() {
    var dataArr = _dataArr;
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        // 列表项构造器
        itemCount: dataArr.length,
        // 分割器构造器
        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
            indent: 70,
            endIndent: 0,
            color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
          );
        },
        itemBuilder: (context, index) {
          WxHomeModel model = WxHomeModel.fromJson(dataArr[index]);
          return WxHomeCell(
            model: model,
            onClickCell: (model) {
              _clickCell(model);
            },
          );
        },
      ),
    );
  }

  // 点击cell
  void _clickCell(item) {
    // JhToast.showText(context, msg: '点击 $item['title']');
    if (item['title'] == 'Demo 列表') {
      JhNavUtils.pushNamed(context, 'DemoListPage');
    } else if (item['title'] == 'QQ邮箱提醒') {
      JhNavUtils.pushNamed(context, 'WxQQMessagePage');
    } else if (item['title'] == '订阅号消息') {
      JhNavUtils.pushNamed(context, 'WxSubscriptionNumberPage');
    } else if (item['title'] == '微信运动') {
      JhNavUtils.pushNamed(context, 'WxMotionPage');
    } else {
      JhNavUtils.pushNamed(context, 'DemoListPage');
    }
  }

  // // 点击侧滑按钮
  // void _showSnackBar(text) {
  //   print(text);
  //   JhToast.showText(context, msg: text);
  // }

  void _scan() {
    JhQrCodeUtils.jumpScan(context, isShowGridLine: true, isShowScanLine: false, callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
    });
  }
}
