// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';
import '/res/list_data.dart';

class ListViewTest2 extends StatelessWidget {
  const ListViewTest2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('ListViewTest2_外部引用假数据'),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _getListData(context, index) {
    return ListTile(
      title: Text(listData[index]['title']),
      leading: JhNetworkImage(listData[index]['imageUrl']),
      subtitle: Text(listData[index]['content']),
      onTap: () {
        print('点击的index ${index.toString()}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: listData.length, itemBuilder: _getListData);
  }
}

Widget contentBody = Container(
  width: 200,
  height: 200,
  color: Colors.red,
  child: TextButton(
    child: const Text('normal'),
    onPressed: () {},
  ),
);
