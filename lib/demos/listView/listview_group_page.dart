import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/base_appbar.dart';

class ListViewGroupPage extends StatefulWidget {
  @override
  _ListViewGroupPageState createState() => _ListViewGroupPageState();
}

class _ListViewGroupPageState extends State<ListViewGroupPage> {
  var _groupData = [];

  @override
  void initState() {
    super.initState();

    _groupData = _getData();
  }

  _getData() {
    var dataArr = [];
    for (int i = 0; i < 30; i++) {
      var groupDict = new Map();
      groupDict['groupTitle'] = 'groupTitle_$i';
      groupDict['num'] = '$i';
      var tempArr = [];
      int length = JhCommonUtils.getRandom(2, 5).toInt();
      for (int j = 0; j < length; j++) {
        var tempDict = new Map();
        tempDict['title'] = 'group$i' + '_title$j';
        tempDict['phone'] = '$j$j$j' + 'xxxxxxx';
        tempDict['content'] = 'content{$j}-content{$j}-content{$j}-content{$j}-content{$j}-content{$j}';
        tempDict['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
        tempArr.add(tempDict);
      }
      groupDict['data'] = tempArr;
      dataArr.add(groupDict);
    }
    return dataArr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('ListViewGroupPage'),
      body: ListView.builder(
          itemCount: _groupData.length,
          itemBuilder: (context, index) {
            return StickyHeader(
              header: Container(
                height: 50.0,
                color: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Header #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              content: Column(children: buildGroup(_groupData[index]['data'])),
            );
          }),
    );
  }

  List<Widget> buildGroup(List group) {
    return group.map((item) {
//      print(item);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item['title']),
          Text(item['phone']),
          Image.network(item['imageUrl'], fit: BoxFit.cover, width: 50, height: 50.0),
        ],
      );
    }).toList();
  }
}
