///  two_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 通讯录

import 'package:flutter/material.dart';
import './pages/wx_contacts_page.dart';

class TwoPage extends StatefulWidget {
  const TwoPage({Key? key}) : super(key: key);

  @override
  State<TwoPage> createState() => _TwoPageState();
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

    return const WxContactsPage();
  }
}
