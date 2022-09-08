///  four_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 我的

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/utils/jh_status_bar_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/widgets/update_dialog.dart';
import '/project/configs/project_config.dart';
import '/project/provider/tabbar_provider.dart';
import '/project/model/user_model.dart';

double _cellH = wxCellH;
double _leftSpace = 50.0;
double _rowSpace = wxRowSpace;
double _scrollMaxOffSet = 1000;

class FourPage extends StatefulWidget {
  @override
  _FourPageState createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  UserModel? _model;
  ScrollController _scrollController = new ScrollController(initialScrollOffset: 0.0);
  double _topH = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var modelJson = JhAESStorageUtils.getModel(kUserDefault_UserInfo)!;
    _model = UserModel.fromJson(modelJson);
//    print(_model.avatarUrl);

    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      double _y = _scrollController.offset;
//      print('滑动距离: $_y');

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
    // 为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var currentIndex = Provider.of<TabbarProvider>(context).currentIndex;
    if (currentIndex == 3) {
      print('========== FourPage ==========');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnnotatedRegion(
      value: JhStatusBarUtils.getBlackStatusBarStyle(context.jhIsDark),
      child: Scaffold(
//        appBar: baseAppBar(context, '',
//            rightImgPath: 'assets/images/set.png', rightItemCallBack: () {
//          JhNavUtils.pushNamed(context, 'SetPage');
//        }),
        body: _body(_model),
      ),
    );
  }

  Widget _body(model) {
    return Stack(
      children: <Widget>[
        Container(
          color: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
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
            color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
            constraints: BoxConstraints(
              minWidth: JhScreenUtils.screenWidth,
              maxHeight: _topH,
            ),
          ),
        ),

        // 设置
        InkWell(
          child: Container(
            margin: EdgeInsets.only(top: JhScreenUtils.topSafeHeight + 20, right: 20),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  height: 25,
                  image: AssetImage('assets/images/ic_set_black.png'),
                  color: KColors.dynamicColor(context, KColors.kIconColor),
                ),
              ],
            ),
          ),
          onTap: () {
            JhNavUtils.pushNamed(context, 'SetPage');
          },
        )
      ],
    );
  }

  // cell
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
            leftImgPath: 'assets/wechat/mine/ic_wallet.png',
            title: '支付',
            hiddenLine: true,
            clickCallBack: () {
              JhNavUtils.pushNamed(context, 'WxPayPage');
            }),
        SizedBox(height: _rowSpace),
        JhSetCell(
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftImgPath: 'assets/wechat/mine/ic_collections.png',
            title: '收藏'),
        JhSetCell(
            cellHeight: _cellH, lineLeftEdge: _leftSpace, leftImgPath: 'assets/wechat/mine/ic_album.png', title: '相册'),
        JhSetCell(
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftImgPath: 'assets/wechat/mine/ic_cards_wallet.png',
            title: '卡包'),
        JhSetCell(
          cellHeight: _cellH,
          lineLeftEdge: _leftSpace,
          leftImgPath: 'assets/wechat/mine/ic_emotions.png',
          title: '表情',
          hiddenLine: true,
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: 'assets/wechat/mine/ic_settings.png',
          title: '设置',
          hiddenLine: true,
          clickCallBack: () {
            JhNavUtils.pushNamed(context, 'SetPage');
          },
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: 'assets/images/ic_about.png',
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
    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => UpdateDialog());
  }

  // 头部
  Widget _header(model) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 40.0, top: 72.0),
      color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        // color: Colors.white,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(fit: BoxFit.fitHeight, image: NetworkImage(model.avatarUrl))),
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
                        JhNavUtils.pushNamed(context, 'WxPersonInfoPage');
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
                        JhNavUtils.pushNamed(context, 'WxPersonInfoPage');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('微信号：abc', style: TextStyle(fontSize: 17, color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Image.asset(
                                'assets/wechat/mine/ic_setting_myQR.png',
                                width: 18.0,
                                height: 18.0,
                                color: KColors.dynamicColor(context, KColors.kIconColor, KColors.kIconDarkColor),
                              ),
                            ),
//                            Image.asset(
//                              'assets/images/common/ic_arrow_gray.png',
//                              width: 8.0,
//                              height: 13.0,
//                            )
                            Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFC8C8C8))
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
