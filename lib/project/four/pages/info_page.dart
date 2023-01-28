///  info_page.dart
///
///  Created by iotjin on 2020/05/07.
///  description: 基本信息

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/project_config.dart';
import '/project/model/user_model.dart';

double _scrollMaxOffSet = 1000;

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late UserModel model;

  double _topH = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    model = SpUtil.getObj(kUserDefault_UserInfo, (v) => userModel.fromJson(v));

    var modelJson = JhAESStorageUtils.getModel(kUserDefault_UserInfo)!;
    model = UserModel.fromJson(modelJson);
    // 监听滚动
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(''),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Container(
            color: KColors.kThemeColor,
            constraints: BoxConstraints(minWidth: JhScreenUtils.screenWidth, maxHeight: _topH),
          ),
        ),
        _cell(),
      ],
    );
  }

  Widget _cell() {
    return ListView(
      controller: _scrollController,
      // physics: const AlwaysScrollableScrollPhysics(),
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        Container(
          height: 100,
          color: KColors.kThemeColor,
          alignment: Alignment.center,
          child: ListTile(
            leading: JhNetworkImage(model.avatarUrl.jhNullSafe,
                placeholder: 'lufei', width: 50, height: 50, borderRadius: 25),
            title: Text(model.userName.jhNullSafe, style: const TextStyle(color: Colors.white)),
            subtitle: Text(model.phone.jhNullSafe, style: const TextStyle(color: Colors.white)),
            // trailing: const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white),
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            onTap: () {},
          ),
        ),
        JhSetCell(title: '用户名', text: model.userName.jhNullSafe, hiddenArrow: true),
        JhSetCell(title: '手机号', text: model.phone.jhNullSafe, hiddenArrow: true),
      ],
    );
  }
}
