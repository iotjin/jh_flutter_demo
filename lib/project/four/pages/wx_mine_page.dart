///  wx_mine_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信我的

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/utils/jh_status_bar_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/jh_common/widgets/update_dialog.dart';
import '/project/configs/project_config.dart';
import '/project/provider/tabbar_provider.dart';
import '/project/model/user_model.dart';

double _cellH = wxCellH;
double _leftSpace = 50.0;
double _rowSpace = wxRowSpace;
double _scrollMaxOffSet = 1000;

class WxMinePage extends StatefulWidget {
  const WxMinePage({Key? key}) : super(key: key);

  @override
  State<WxMinePage> createState() => _WxMinePageState();
}

class _WxMinePageState extends State<WxMinePage> {
  UserModel? _model;
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);
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
      double y = _scrollController.offset;
//      print('滑动距离: $y');

//      if (y > 0 && y < _scrollMaxOffSet) {
//        setState(() {
//          _topH = y;
//        });
//      }
      if (y < 0 && y > -_scrollMaxOffSet) {
        setState(() {
          _topH = y.abs();
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
      print('========== WxMinePage ==========');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: JhStatusBarUtils.getBlackStatusBarStyle(context.jhIsDark),
      child: Scaffold(
        // appBar: BaseAppBar( '',
        //     rightImgPath: 'assets/images/set.png', rightItemCallBack: () {
        //   JhNavUtils.pushNamed(context, 'SetPage');
        // }),
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
                  image: const AssetImage('assets/images/ic_set_black.png'),
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
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        _header(model),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: 'assets/wechat/mine/ic_wallet.png',
          title: '支付',
          hiddenLine: true,
          clickCallBack: () => JhNavUtils.pushNamed(context, 'WxPayPage'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          lineLeftEdge: _leftSpace,
          leftImgPath: 'assets/wechat/mine/ic_collections.png',
          title: '收藏',
        ),
        JhSetCell(
          cellHeight: _cellH,
          lineLeftEdge: _leftSpace,
          leftImgPath: 'assets/wechat/mine/ic_album.png',
          title: '相册',
        ),
        JhSetCell(
          cellHeight: _cellH,
          lineLeftEdge: _leftSpace,
          leftImgPath: 'assets/wechat/mine/ic_cards_wallet.png',
          title: '卡包',
        ),
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
          clickCallBack: () => JhNavUtils.pushNamed(context, 'SetPage'),
        ),
        SizedBox(height: _rowSpace),
        JhSetCell(
          cellHeight: _cellH,
          leftImgPath: 'assets/images/ic_about.png',
          title: '检查更新',
          text: '有新版本',
          textStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
          hiddenLine: true,
          clickCallBack: () => _showUpdateDialog(),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const UpdateDialog(
        titleText: '新版本更新',
        contentList: ['1、又双叒修复了一大堆bug。', '2、祭天了多名程序猿。'],
        cancelText: '残忍拒绝',
        confirmText: '立即更新',
      ),
    );
  }

  // 头部
  Widget _header(UserModel model) {
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 40.0, top: 72.0),
      color: KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        // color: Colors.white,
        child: Row(
          children: <Widget>[
            InkWell(
              child: JhNetworkImage(model.avatarUrl.jhNullSafe,
                  placeholder: 'lufei', width: 75, height: 75, borderRadius: 10),
              onTap: () {
                print('点击头像==  ${model.avatarUrl}');
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('点击昵称==  ${model.userName}');
                        JhNavUtils.pushNamed(context, 'WxPersonInfoPage');
                      },
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          model.userName.jhNullSafe,
                          style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
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
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: <Widget>[
                            const Expanded(child: Text('微信号：abc', style: TextStyle(fontSize: 17, color: Colors.grey))),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
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
                            const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFC8C8C8))
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
