///  one_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 首页

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/utils/jh_qr_code_utils.dart';
import '/jh_common/widgets/jh_pop_menus.dart';
import '/project/configs/project_config.dart';

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

class OnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // // 1.首先先需要对控件进行渲染  初始化GlobalKey ：
    // GlobalKey anchorKey = GlobalKey();

    return Scaffold(
      appBar: baseAppBar(context, KStrings.oneTabTitle,
          rightImgPath: 'assets/images/ic_nav_add.png', rightItemCallBack: () => _showPop(context)),
      body: _body(context, _dataArr),
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
  void _showPop(context) {
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
        _scan(context);
      }
    });
  }

  // body
  Widget _body(context, dataArr) {
//    return ListView.builder(
//        itemCount: dataArr.length,
//        itemExtent: 70.0, // 强制高度为100.0
//        itemBuilder: (context, index) {
//          return _cell(dataArr[index]);
//        });

    Widget noRead = CustomSlidableAction(
      padding: EdgeInsets.all(0),
//      foregroundColor:Colors.white,
      backgroundColor: Colors.black87,
      child: Text(
        '标为未读',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击标为未读');
      },
    );

    Widget noAttention = CustomSlidableAction(
      padding: EdgeInsets.all(0),
      backgroundColor: Colors.black87,
      child: Text(
        '不再关注',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击不再关注');
      },
    );

    Widget delete = CustomSlidableAction(
      backgroundColor: Colors.red,
      child: Text(
        '删除',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        JhToast.showText(context, msg: '点击删除');
      },
    );
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
        List<Widget> tempArr = [];
        if (dataArr[index]['type'] == '1') {
          tempArr.add(delete);
        }
        if (dataArr[index]['type'] == '2') {
          tempArr.addAll([noRead, delete]);
        }
        if (dataArr[index]['type'] == '3') {
          tempArr.addAll([noAttention, delete]);
        }

        var extentRatio = dataArr[index]['type'] == '0' ? 0.00001 : (dataArr[index]['type'] == '1' ? 0.2 : 0.4);

        return Slidable(
          key: Key(dataArr[index]['type']),
          child: _cell(context, dataArr[index]),
          // 右侧按钮列表
          endActionPane: ActionPane(
//            motion: const ScrollMotion(),
            motion: const DrawerMotion(),
            extentRatio: extentRatio,
            children: tempArr,
            // 拖动删除
            dragDismissible: false,
            dismissible: DismissiblePane(
                closeOnCancel: true,
//                dismissThreshold: 0.8,
                onDismissed: () {}),
          ),
        );
      },
    ));
  }

  // cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () => _clickCell(context, item),
        child: Container(
            color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Badge(
                  showBadge: item['isNew'],
                  child: Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          item['img'],
                          width: 60,
                        ),
                      )),
                  padding: EdgeInsets.all(5),
                  position: BadgePosition.topEnd(top: 5, end: 5),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                Container(color: KColors.kLineColor, height: 0.8),
                    SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 70, child: Text(item['title'], style: TextStyle(fontSize: 18))),
                        Expanded(
                            flex: 30,
                            child: Text(
                              item['time'],
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.right,
                            )),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(item['subtitle'], style: TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                )),
              ],
            )));
  }

  // 点击cell
  void _clickCell(context, item) {
    // JhToast.showText(context, msg: '点击 $item['title']');
    if (item['title'] == 'Demo 列表') {
      JhNavUtils.pushNamed(context, 'DemoListsPage');
    } else if (item['title'] == 'QQ邮箱提醒') {
      JhNavUtils.pushNamed(context, 'WxQQMessagePage');
    } else if (item['title'] == '订阅号消息') {
      JhNavUtils.pushNamed(context, 'WxSubscriptionNumberPage');
    } else if (item['title'] == '微信运动') {
      JhNavUtils.pushNamed(context, 'WxMotionPage');
    } else {
      JhNavUtils.pushNamed(context, 'DemoListsPage');
    }
  }

  // // 点击侧滑按钮
  // void _showSnackBar(context, text) {
  //   print(text);
  //   JhToast.showText(context, msg: text);
  // }

  void _scan(context) {
    JhQrCodeUtils.jumpScan(context, isShowGridLine: true, isShowScanLine: false, callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
    });
  }
}

/*
--enable-software-rendering

Flutter中的Offstage与Visibility都可以将子widget进行隐藏，
不同的是Visibility可以设置隐藏之后是否还占据原来的控件、设置隐藏后是否响应事件，
Offstage隐藏后之前所占的空间就会消失。

一、Offstage

Offstage中控制显示隐藏的重要属性是offstage，默认为true。当offstage 为true时，其child控件是隐藏的。

二、Visibility

Visibility构造器

const Visibility({
    Key key,
    @required this.child,
    this.replacement = const SizedBox.shrink(), // 不可见时显示的组件，只有maintainState=false才会显示。
    this.visible = true, // 是否可见
    this.maintainState = false, // 隐藏后是否位置组件状态
    this.maintainAnimation = false, // 隐藏后是否维持子组件中的动画
    this.maintainSize = false, // 隐藏后所占空间是否释放
    this.maintainSemantics = false,
    this.maintainInteractivity = false, // 隐藏后是否能够照常响应事件
  })

 */
