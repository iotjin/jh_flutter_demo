/**
 *  four_page.dart
 *
 *  Created by iotjin on 2019/08/14.
 *  description: 我的
 */

import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_storage_utils.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/jh_common/widgets/update_dialog.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';
import 'package:jh_flutter_demo/project/model/user_model.dart';


double _leftSpace = 50.0;
double _cellH = wx_cellH;
double _rowSpace = wx_rowSpace;

double _scrollMaxOffSet = 1000;

class FourPage extends StatefulWidget {
  @override
  _FourPageState createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  UserModel _model;

  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);
  double _topH = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var modelJson = JhStorageUtils.getModelWithKey(kUserDefault_UserInfo);
    _model = UserModel.fromJson(modelJson);
//    print(_model.avatarUrl);

    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print("滑动距离: $_y");

//      if (_y > 0 && _y < _scrollMaxOffSet) {
//        setState(() {
//          _topH = _y;
//        });
//      }
      if (_y < 0 && _y > -_scrollMaxOffSet) {
        setState(() {
          _topH = _y.abs();
//          print(_topH);
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: baseAppBar(context, '',
//            rightImgPath: "assets/images/set.png", rightItemCallBack: () {
//          NavigatorUtils.pushNamed(context, "SetPage");
//        }),
//        backgroundColor: KColor.kWeiXinBgColor,
        body: _body(_model));
  }

  Widget _body(model) {
    return Stack(
      children: <Widget>[
        Container(
          color: KColor.kWeiXinBgColor,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: _contentCell(model),
//            child: ListView(
//                controller: _scrollController,
//                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//                children: <Widget>[
//                  _header(model),
//                  SizedBox(height: _rowSpace),
//                  _contentCell(model)
//                ]),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
//            color: Colors.yellow,
            color: Colors.white,
            constraints: BoxConstraints(
              minWidth: JhScreen.width,
              maxHeight: _topH,
            ),
          ),
        ),

        //设置
        InkWell(
          child: Container(
            margin:
                EdgeInsets.only(top: JhScreen.topSafeHeight + 20, right: 20),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                    height: 25,
                    image: AssetImage('assets/images/ic_set_black.png'))
              ],
            ),
          ),
          onTap: () {
            NavigatorUtils.pushNamed(context, "SetPage");
          },
        )
      ],
    );
  }

  //cell
  Widget _contentCell(model) {
    return ListView(
      controller: _scrollController,
      // physics: const AlwaysScrollableScrollPhysics(),
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        _header(model),
        SizedBox(height: _rowSpace),
        JhSetCell(
            cellHeight: _cellH,
            leftImgPath: "assets/wechat/mine/ic_wallet.png",
            title: '支付',
            hiddenLine: true,
            clickCallBack: () {
              NavigatorUtils.pushNamed(context, "WxPayPage");
            }),
        SizedBox(height: _rowSpace),
        JhSetCell(
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftImgPath: "assets/wechat/mine/ic_collections.png",
            title: '收藏'),
        JhSetCell(
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftImgPath: "assets/wechat/mine/ic_album.png",
            title: '相册'),
        JhSetCell(
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftImgPath: "assets/wechat/mine/ic_cards_wallet.png",
            title: '卡包'),
        JhSetCell(
          cellHeight: _cellH,
          lineLeftEdge: _leftSpace,
          leftImgPath: "assets/wechat/mine/ic_emotions.png",
          title: '表情',
          hiddenLine: true,
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: "assets/wechat/mine/ic_settings.png",
          title: '设置',
          hiddenLine: true,
          clickCallBack: () {
            NavigatorUtils.pushNamed(context, "SetPage");
          },
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: "assets/images/ic_about.png",
          title: '检查更新',
          text: '有新版本',
          textStyle: TextStyle(fontSize: 14.0, color: Colors.red),
          hiddenLine: true,
          clickCallBack: () {
            _showUpdateDialog();
          },
        ),
        SizedBox(height: 50),
      ],
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => UpdateDialog());
  }

  //头部
  Widget _header(model) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 40.0, top: 72.0),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(model.avatarUrl))),
              ),
              onTap: () {
                print('点击头像==  ${model.avatarUrl}');
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('点击昵称==  ${model.userName}');
                        NavigatorUtils.pushNamed(context, "WxPersonInfoPage");
                      },
                      child: Container(
                        width: double.maxFinite,
                        child: Text(
                          model.userName,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('跳转个人信息');
                        NavigatorUtils.pushNamed(context, "WxPersonInfoPage");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('微信号：abc',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Image.asset(
                                'assets/wechat/mine/ic_setting_myQR.png',
                                width: 18.0,
                                height: 18.0,
                              ),
                            ),
//                            Image.asset(
//                              'assets/images/common/ic_arrow_gray.png',
//                              width: 8.0,
//                              height: 13.0,
//                            )
                            Icon(Icons.arrow_forward_ios,
                                size: 18, color: Color(0xFFC8C8C8))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
