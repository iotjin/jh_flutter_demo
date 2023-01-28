// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/utils/jh_qr_code_utils.dart';
import '/jh_common/widgets/update_dialog.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/project/configs/strings.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(KStrings.fourTabTitle, rightImgPath: 'assets/images/set.png', rightItemCallBack: () {
        JhNavUtils.pushNamed(context, 'SetPage');
      }),
      // backgroundColor: Color(0xFFF8F8F8),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        const SizedBox(height: 15),
        const JhSetCell(leftImgPath: 'assets/images/ic_accountSafe.png', title: '账号安全'),
        JhSetCell(
          leftImgPath: 'assets/images/ic_saoyisao.png',
          title: '扫一扫',
          clickCallBack: () {
            JhQrCodeUtils.jumpScan(context, isShowGridLine: true, callBack: (data) {
              print('扫码结果：$data');
            });
          },
        ),
        JhSetCell(
          leftImgPath: 'assets/images/shezhi.png',
          title: '设置',
          clickCallBack: () {
            JhNavUtils.pushNamed(context, 'SetPage');
          },
        ),
        JhSetCell(
          leftImgPath: 'assets/images/ic_about.png',
          title: '检查更新',
          text: '有新版本',
          textStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
          clickCallBack: () {
            _showUpdateDialog();
          },
        ),
        JhSetCell(
          leftImgPath: 'assets/images/ic_exit.png',
          title: '退出',
          clickCallBack: () {
            JhDialog.show(context, title: '提示', content: '您确定要退出登录吗？');
          },
        ),
      ],
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => const UpdateDialog());
  }
}
