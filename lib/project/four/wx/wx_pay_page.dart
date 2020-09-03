/**
 *  wx_pay_page.dart
 *
 *  Created by iotjin on 2020/08/27.
 *  description:  微信 支付界面
 */

import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/project/configs/project_config.dart';

List _dataArr = [
  {
    "text": "功能功能0",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能1",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能2",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能3",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能4",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能5",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能6",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能7",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
];

List _dataArr2 = [
  {
    "text": "功能功能0",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能1",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  }
];

List _dataArr3 = [
  {
    "text": "功能功能0",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能1",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能2",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能3",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能4",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能5",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能6",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
  {
    "text": "功能功能7",
    "img": "https://gitee.com/iotjh/Picture/raw/master/lufei.png",
    "pushName": "PageName",
  },
];

double _money = 345345.13;

class WxPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, KString.wx_pay,
          rightImgPath: 'assets/images/ic_more_black.png',
          backgroundColor: Colors.transparent, rightItemCallBack: () {
        NavigatorUtils.pushNamed(context, "WxPayManagerPage");
      }),
      body: _body(context),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }
}

Widget _body(context) {
  return Scrollbar(
      child: SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _payCard(),
        _cardView('腾讯服务', _dataArr),
        _cardView('限时推广', _dataArr2),
        _cardView('三方服务', _dataArr3),
        SizedBox(height: 50),
      ],
    ),
  ));
}

Widget _payCard() {
  return Card(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      //设置圆角
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      //普通的边
//    shape: Border.all(color: Colors.yellow, width: 5.0),
      elevation: 3,
      // 阴影大小
      child: Container(
          height: 150,
          color: KColor.kWeiXinPayColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
//                  color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Image.asset('assets/wechat/mine/ic_shoufukuan.png',
                          width: 40),
                      SizedBox(height: 8),
                      Text('收付款',
                          style: TextStyle(color: Colors.white, fontSize: 16))
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
//                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Image.asset('assets/wechat/mine/ic_qianbao.png',
                          width: 40),
                      SizedBox(height: 8),
                      Text('收付款',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 5),
                      Text('¥${_money}',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ),
                flex: 1,
              )
            ],
          )));
}

Widget _cardView(title, dataArr) {
  return Card(
    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
    //设置圆角
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    // 抗锯齿
    clipBehavior: Clip.antiAlias,
    //普通的边
//    shape: Border.all(color: Colors.yellow, width: 5.0),
    elevation: 3,
    // 阴影大小
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          child: Text(title),
          width: double.infinity,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //可以直接指定每行（列）显示多少个Item
              crossAxisCount: 3, //一行的Widget数量
              crossAxisSpacing: 0.5, //水平间距
              mainAxisSpacing: 0.5, //垂直间距
              childAspectRatio: 1.0, //子Widget宽高比例
            ),
            padding: EdgeInsets.all(0.0),
            //GridView内边距
            itemCount: dataArr.length,
            itemBuilder: (context, index) {
              return item(dataArr, index, context);
            })
      ],
    ),
  );
}

Widget item(List data, int index, context) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.0),
        border:
            Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5), //边框
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//            Image.asset(data[index]['img'], width: 50.0,height: 50,),
//          Image.network(
//            data[index]['img'],
//            width: 50,
//          ),
          Icon(Icons.card_membership),
          SizedBox(
            height: 10,
          ),
          Text(
            data[index]['text'],
            style: TextStyle(color: Color(0xFF666666), fontSize: 13),
          ),
        ],
      ),
    ),
    onTap: () {
      print(index);
//        NavigatorUtils.pushNamed(context,  data[index]['pushName']);
    },
  );
}
