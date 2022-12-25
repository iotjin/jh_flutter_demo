///  two_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 通讯录

import 'package:flutter/material.dart';
import './pages/wx_contacts_page.dart';

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WxContactsPage();
  }
}

//class BaseScrollView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scrollbar(
//        child: SingleChildScrollView(
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 1500,
//            width: double.infinity,
//            color: Colors.white,
//            child: Text('往下滑动'),
//          ),
//          RichText(
//            text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
//                children: <InlineSpan>[
//                  TextSpan(text: '登录即视为同意'),
//                  TextSpan(
//                    text: '《xxx服务协议》',
//                    style: TextStyle(color: Colors.red),
//                    recognizer: new TapGestureRecognizer()
//                      ..onTap = () => print('Tap Here onTap'),
//                  ),
//                ]),
//          ),
//          Text('data'),
//          Text('data'),
//          Text('data'),
//          Text('data'),
//          Text('data'),
//        ],
//      ),
//    ));
//  }
//}
