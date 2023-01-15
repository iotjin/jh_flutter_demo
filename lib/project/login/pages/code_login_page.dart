///  code_login_page.dart
///
///  Created by iotjin on 2020/04/09.
///  description:  验证码登录

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/configs/project_config.dart';
import '/project/routes/routes.dart';
import '/data/data_utils.dart';

class CodeLoginPage extends StatefulWidget {
  const CodeLoginPage({Key? key}) : super(key: key);

  @override
  State<CodeLoginPage> createState() => _CodeLoginPageState();
}

class _CodeLoginPageState extends State<CodeLoginPage> {
  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _phone = '';
  var _code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('', bgColor: Colors.transparent),
      body: KeyboardActions(
        config: JhKeyboardUtils.getKeyboardConfig(context, [_node1, _node2]),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('验证码登录', style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 80),
            JhLoginTextField(
              text: _phone,
              hintText: '请输入手机号',
              focusNode: _node1,
              maxLength: 11,
              keyboardType: TextInputType.number,
              inputCallBack: (value) => _phone = value,
            ),
            const SizedBox(height: 10),
            JhLoginTextField(
              text: _code,
              hintText: '请输入验证码',
              focusNode: _node2,
              maxLength: 6,
              keyboardType: TextInputType.number,
              rightWidget: JhCountDownBtn(
                showBorder: true,
                getVCode: () async {
                  return true;
                },
              ),
              inputCallBack: (value) => _code = value,
            ),
            const SizedBox(height: 50),
            JhButton(text: '登 录', onPressed: _clickOkBtn),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _clickOkBtn() async {
    var hide = JhToast.showIOSLoadingText(
      context,
      msg: '正在登录...',
    );
    // 登录请求
    DataUtils.login({'userName': 'jin', 'pwd': '123456'}, success: (res) {
      hide();
//        Map<String, dynamic> json = Map<String, dynamic>.from(res['data']);
//        /*将Json转成实体类*/
//        userModel model = userModel.fromJson(json);
//      print(model.phone);
//        SpUtil.putObject(kUserDefault_UserInfo, model);

      // 保存本地
      JhAESStorageUtils.saveModel(kUserDefault_UserInfo, res['data']);
      JhToast.showSuccess(context, msg: res['msg']);
      JhNavUtils.pushReplacement(context, Routes.pHome);
    }, fail: (code, msg) {
      hide();
    });

//    var url = APIs.login;
//    var dio = new Dio();
//    var response = await dio.post(url, data: {'userName': 'jin', 'pwd': '123456'});
//    var result = response.data.toString();
//    print('返回数据： ' + result);
//    print(response.data['msg']);
//
//    if (response.data['suc'] == true) {
//      Map<String, dynamic> json =
//          Map<String, dynamic>.from(response.data['data']);
//      /*将Json转成实体类*/
//      userModel model = userModel.fromJson(json);
////      print(model.phone);
//      SpUtil.putObject(kUserDefault_UserInfo, model);
//      hide();
////      JhToast.showText(context, msg: response.data['msg']);
//      JhToast.showSuccess(context, msg: response.data['msg']);
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => (BaseTabBar())));
//    } else {
//      hide();
//      JhToast.showText(context, msg: response.data['msg']);
//    }
  }

//   void _clickOkBtn() async {
//     print('_phone =$_phone');
//     print('_code =$_code');
//
//     var hide = JhToast.showIOSLoadingText(
//       context,
//       msg: '正在登录...',
//     );
//     Future.delayed(Duration(seconds: 1), () {
// //      Navigator.pushReplacement(context,
// //          MaterialPageRoute(builder: (context) => (BaseTabBar()
// //          )));
//       JhNavUtils.pushReplacement(context, Routes.pHome);
//       hide();
//     });
//   }
}
