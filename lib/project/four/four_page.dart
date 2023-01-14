///  four_page.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 我的

import 'package:flutter/material.dart';
import './pages/wx_mine_page.dart';

class FourPage extends StatefulWidget {
  const FourPage({Key? key}) : super(key: key);

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> with AutomaticKeepAliveClientMixin {
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

    return const WxMinePage();
  }
}
