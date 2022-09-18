import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import '/project/configs/project_config.dart';

class GridviewDragSortPage extends StatefulWidget {
  @override
  _GridviewDragSortPageState createState() => _GridviewDragSortPageState();
}

class _GridviewDragSortPageState extends State<GridviewDragSortPage> {
  List _mList = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 20; i++) {
      var dict = {'id': i, 'name': i.toString()};
      _mList.add(dict);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('GridviewDragSortPage'),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: _mList.map((e) => _cell(e)).toList(),
        onReorder: _onReorder,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      var item = _mList.removeAt(oldIndex);
      _mList.insert(newIndex, item);
    });
  }

  Widget _cell(item) {
    return InkWell(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: KColors.dynamicColor(context, Color(0xFFF2F3F7), Colors.black87),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite),
            Text(item['name']),
          ],
        ),
      ),
    );
  }
}
