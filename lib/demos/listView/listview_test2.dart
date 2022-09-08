import 'package:flutter/material.dart';
import '/base_appbar.dart';
import '/res/listData.dart';

class ListViewTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'ListViewTest2_外部引用假数据'),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  Widget _getListData(context, index) {
    return ListTile(
      title: Text(listData[index]['title']),
      leading: Image.network(listData[index]['imageUrl']),
      subtitle: Text(listData[index]['content']),
      onTap: () {
        print('点击的index' + index.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: listData.length, itemBuilder: this._getListData);
  }
}

Widget contentBody = Container(
    width: 200,
    height: 200,
    color: Colors.red,
    child: TextButton(
      child: Text('normal'),
      onPressed: () {},
    ));
