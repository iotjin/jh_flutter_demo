import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

class ListViewGroupPage extends StatefulWidget {
  const ListViewGroupPage({Key? key}) : super(key: key);

  @override
  State<ListViewGroupPage> createState() => _ListViewGroupPageState();
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
      var groupDict = {};
      groupDict['groupTitle'] = 'groupTitle_$i';
      groupDict['num'] = '$i';
      var tempArr = [];
      int length = JhCommonUtils.getRandomInt(2, 5);
      for (int j = 0; j < length; j++) {
        var tempDict = {};
        tempDict['title'] = 'group$i' '_title$j';
        tempDict['phone'] = '$j$j$j' 'xxxxxxx';
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
      appBar: const BaseAppBar('ListViewGroupPage'),
      body: ListView.builder(
          itemCount: _groupData.length,
          itemBuilder: (context, index) {
            return StickyHeader(
              header: Container(
                height: 50.0,
                color: Colors.yellow[700],
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          JhNetworkImage(item['imageUrl'], placeholder: 'lufei', width: 50, height: 50.0)
        ],
      );
    }).toList();
  }
}
