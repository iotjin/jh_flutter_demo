import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';

class GridViewTestPage5 extends StatefulWidget {
  const GridViewTestPage5({Key? key}) : super(key: key);

  @override
  State<GridViewTestPage5> createState() => _GridViewTestPage5State();
}

class _GridViewTestPage5State extends State<GridViewTestPage5> {
  List? _dataArr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataArr = [
      {
        'text': '功能功能0',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能1',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能2',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能3',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能4',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能5',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能6',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
      {
        'text': '功能功能7',
        'img': 'https://gitee.com/iotjh/Picture/raw/master/lufei.png',
        'pushName': 'PageName',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('标题'),
      backgroundColor: const Color(0xFFF8F8F8),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // 可以直接指定每行（列）显示多少个Item
          crossAxisCount: 3, // 一行的Widget数量
          crossAxisSpacing: 5.0, // 水平间距
          mainAxisSpacing: 5.0, // 垂直间距
          childAspectRatio: 1.0, // 子Widget宽高比例
        ),
        padding: const EdgeInsets.all(10.0), // GridView内边距
        itemCount: _dataArr!.length,
        itemBuilder: (context, index) {
          return item(_dataArr!, index, context);
        },
      ),
    );
  }
}

Widget item(List data, int index, context) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F7),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          JhNetworkImage(data[index]['img'], width: 50),
          const SizedBox(height: 10),
          Text(data[index]['text'], style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
        ],
      ),
    ),
    onTap: () {
//      print(index);
//        JhNavUtils.pushNamed(context,  data[index]['pushName']);
    },
  );
}
