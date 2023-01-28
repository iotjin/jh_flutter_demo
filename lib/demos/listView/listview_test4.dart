// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/base_appbar.dart';

var dataArr = [];

var phone = '1234xxxx1234';
var address = '这是地址';
var range = '这是描述这是描述';

var adminData = [
  {'title': 'title11', 'icon': 'service/icon_baoxiu', 'bgImg': 'service/bg_service_baoxiu'},
  {'title': 'title22', 'icon': 'service/icon_gongdan', 'bgImg': 'service/bg_service_gongdan'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'}
];

class ListViewTest4 extends StatelessWidget {
  const ListViewTest4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('这是标题'),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  ContentBody({Key? key}) : super(key: key) {
    dataArr = adminData;
  }

  Widget _getWidget(context, index) {
    return Container(
//        color: Colors.red,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
//              color: Colors.grey,
//              border: Border.all(width: 2.0, color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: JhImageUtils.getAssetImage(dataArr[index]['bgImg']),
          ),
        ),
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            title: Text(dataArr[index]['title'], style: const TextStyle(color: Colors.white, fontSize: 20)),
            leading: Image(image: JhImageUtils.getAssetImage(dataArr[index]['icon'])),
            onTap: () {
              print('点击的index ${index.toString()}');
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    return ListView.builder(
//        itemCount: dataArr.length,
//        itemExtent: 150.0, // 强制高度为100.0
//        itemBuilder: this._getWidget
//    ),

    print(MediaQuery.of(context).size.height);
//final size = MediaQuery.of(context).size;
//final width = size.width;
//final height = size.height;
//print('width is $width; height is $height');

    return Container(
      color: Colors.yellow,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child:
//            Column(
//              children: <Widget>[
//                Container(
//                  height: 200,
//                  color: Colors.purple,
//                )
//              ],
//            ),
                  ListView.builder(
                      itemCount: dataArr.length,
                      itemExtent: 150.0, // 强制高度为100.0
                      itemBuilder: _getWidget)),

          // 下面控件位于Column布局底部
          SafeArea(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('热线: $phone', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
                  const SizedBox(height: 5),
                  Text('地址: $address', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
                  const SizedBox(height: 5),
                  Text('描述: $range', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget cell = Container(
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/service/lufei.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: Column(),
);
