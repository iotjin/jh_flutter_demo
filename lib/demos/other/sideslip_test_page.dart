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
        actionPane: SlidableScrollActionPane(),
        //滑出选项的面板 动画
        actionExtentRatio: 0.25,
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
        actions: <Widget>[
          //左侧按钮列表
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => _showSnackBar(context, 'Archive'),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => _showSnackBar(context, 'Share'),
          ),
        ],
        secondaryActions: <Widget>[
          //右侧按钮列表
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => _showSnackBar(context, 'More'),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: false,
            onTap: () {
              _showSnackBar(context, 'Delete');
            },
          ),
        ],
      )
    ]);
  }

  void _showSnackBar(context, text) {
    print(text);
    JhToast.showText(context, msg: text);
  }
}
