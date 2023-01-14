import 'package:flutter/material.dart';
import '/base_appbar.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('页面不存在'),
    );
  }
}
