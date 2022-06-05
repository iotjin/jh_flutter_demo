import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';

class SideslipTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '列表侧滑'),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return ListView(children: <Widget>[
      Slidable(
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text('3'),
              foregroundColor: Colors.white,
            ),
            title: Text('Tile'),
            subtitle: Text('SlidableDrawerDelegate'),
          ),
        ),
        // 左侧按钮列表
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          children: [
            SlidableAction(
              label: 'Archive',
              backgroundColor: Colors.blue,
              icon: Icons.archive,
              onPressed: (context) => _showSnackBar(context, 'Archive'),
            ),
            SlidableAction(
              label: 'Share',
              backgroundColor: Colors.indigo,
              icon: Icons.share,
              onPressed: (context) => _showSnackBar(context, 'Share'),
            ),
          ],
        ),
        // 右侧按钮列表
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          children: [
            SlidableAction(
              label: 'More',
              backgroundColor: Colors.black45,
              icon: Icons.more_horiz,
              onPressed: (context) => _showSnackBar(context, 'More'),
            ),
            SlidableAction(
              label: 'Delete',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              autoClose: false,
              onPressed: (context) {
                _showSnackBar(context, 'Delete');
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _showSnackBar(context, text) {
    print(text);
    JhToast.showText(context, msg: text);
  }
}
