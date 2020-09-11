import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/configs/strings.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';
import 'package:jh_flutter_demo/jh_common/widgets/update_dialog.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_dialog.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_qr_code_utils.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
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
      appBar: baseAppBar(context, KString.fourTabTitle,
          rightImgPath: "assets/images/set.png", rightItemCallBack: () {
        NavigatorUtils.pushNamed(context, "SetPage");
      }),
      backgroundColor: Color(0xFFF8F8F8),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          SizedBox(height: 15),
          JhSetCell(
              leftImgPath: "assets/images/ic_accountSafe.png", title: '账号安全'),
          JhSetCell(
            leftImgPath: "assets/images/ic_saoyisao.png",
            title: '扫一扫',
            clickCallBack: () {
              JhQrCodeUtils.scan().then((value) => () {
                    print(value);
                  });
            },
          ),
          JhSetCell(
            leftImgPath: "assets/images/shezhi.png",
            title: '设置',
            clickCallBack: () {
              NavigatorUtils.pushNamed(context, "SetPage");
            },
          ),
          JhSetCell(
            leftImgPath: "assets/images/ic_about.png",
            title: '检查更新',
            text: '有新版本',
            textStyle: TextStyle(fontSize: 14.0, color: Colors.red),
            clickCallBack: () {
              _showUpdateDialog();
            },
          ),
          JhSetCell(
            leftImgPath: "assets/images/ic_exit.png",
            title: '退出',
            clickCallBack: () {
              JhDialog.show(context, title: "提示", content: '您确定要退出登录吗？');
            },
          ),
        ],
      ),
    );

//          Scrollbar(
//              child: SingleChildScrollView(
//                child:
//              Column(
//                children: <Widget>[
//                  SizedBox(height: 15,),
//                  JhSetCell(leftImgPath: "assets/images/ic_accountSafe.png", title: '账号安全'),
//                  JhSetCell(leftImgPath: "assets/images/ic_saoyisao.png", title: '扫一扫'),
//                  JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '设置'),
//                  JhSetCell(leftImgPath: "assets/images/ic_about.png", title: '检查更新',text: '有新版本',textStyle: TextStyle(fontSize: 14.0,color: Colors.red),),
//                ],
//              ),
//
//              )
//          )
  }

  void _showUpdateDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => UpdateDialog());
  }
}
