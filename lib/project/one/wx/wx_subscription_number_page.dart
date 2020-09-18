/**
 *  wx_subscription_number_page.dart
 *
 *  Created by iotjin on 2020/09/03.
 *  description:
 */

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/project_config.dart';

List _dataArr = [
  {
    "title": "央视新闻",
    "subtitle": "早啊，新闻来了",
    "time": "1小时前",
    "img1": "assets/images/picture/picture0.jpeg",
    "text2": "今天，央视新闻为你准备了一幅漫画，一起来看看，这是不是学生时代的你",
    "img2": "assets/images/picture/touxiang_1.jpeg",
  },
  {
    "title": "开发助手",
    "subtitle": "您收到一封新的邮件",
    "time": "1小时前",
    "img1": "assets/images/picture/picture1.jpeg",
    "text2": "欢迎欢迎",
    "img2": "assets/images/picture/touxiang_5.jpeg",
  },
  {
    "title": "程序员",
    "subtitle": "程序员面试现场发生了什么？？？",
    "time": "1小时前",
    "img1": "assets/images/picture/picture2.jpeg",
    "text2": "你的专业能为你做什么",
    "img2": "assets/images/picture/touxiang_2.jpeg",
  },
  {
    "title": "腾讯新闻",
    "subtitle": "早上好",
    "time": "1小时前",
    "img1": "assets/images/picture/picture3.jpeg",
    "text2": "来看看今日的天气情况吧",
    "img2": "assets/images/picture/touxiang_3.jpeg",
  },
  {
    "title": "人民网",
    "subtitle": "夜读",
    "time": "1小时前",
    "img1": "assets/images/picture/picture8.jpg",
    "text2": "夜读，别高估自己的水平，别低估他人的努力",
    "img2": "assets/images/picture/touxiang_4.jpeg",
  },
  {
    "title": "阿里技术",
    "subtitle": "从架构到源码：一文了解Flutter渲染机制",
    "time": "1小时前",
    "img1": "assets/images/picture/picture5.jpeg",
    "text2": "机器学习，从入门到进阶",
    "img2": "assets/images/picture/touxiang_5.jpeg",
  },
  {
    "title": "CSDN",
    "subtitle": "小主，您有一条新的留言",
    "time": "1小时前",
    "img1": "assets/images/picture/picture6.jpg",
    "text2": "欢迎欢迎，快来看看吧",
    "img2": "assets/images/picture/touxiang_6.jpg",
  },
  {
    "title": "新华网",
    "subtitle": "这种病一旦患上将伴随一生，有些人最容易被盯上",
    "time": "1小时前",
    "img1": "assets/images/picture/picture7.jpg",
    "text2": '人造肉来了，"香"吗',
    "img2": "assets/images/picture/tubiao.png",
  },
];

class WxSubscriptionNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, '订阅号消息',
          rightImgPath: 'assets/images/ic_gengduo.png',
          backgroundColor: Colors.transparent, rightItemCallBack: () {
        NavigatorUtils.pushNamed(context, "WxSubscriptionNumberListPage");
      }),
      body: _body(context, _dataArr),
      backgroundColor: KColor.kWeiXinBgColor,
    );
  }

  Widget _body(context, dataArr) {
    return ListView.builder(
        itemCount: _dataArr.length,
        itemBuilder: (context, index) {
          return _cell(context, dataArr[index], index);
        });
  }

  Widget _cell(context, item, index) {
    Widget _widget1 = Column(
      children: <Widget>[
        ListTile(
          leading: Container(
              child: CircleAvatar(
                  backgroundImage: AssetImage(
            item['img2'],
          ))),
          title: Text(
            item['title'],
            style: TextStyle(color: KColor.kWeiXinTextBlueColor),
          ),
          trailing: Text(
            item['time'],
          ),
        ),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 20 / 9,
//          child: Image.network(value["imageUrl"], fit: BoxFit.cover),
              child: Image.asset(item['img1'], fit: BoxFit.cover),
            ),
            Positioned(
              left: 18.0,
              bottom: 10,
              child: Text(
                item['subtitle'],
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        ListTile(
            contentPadding: EdgeInsets.all(18),
            title: Text(
              item['text2'],
              style: TextStyle(color: KColor.kWeiXinTextBlueColor),
            ),
            trailing: Image.asset(
              item['img2'],
              width: 60,
            ))
      ],
    );

    Widget _widget2 = Column(
      children: <Widget>[
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              item['img2'],
              width: 30,
            ),
          ),
          title: Text(item['title']),
        ),
        ListTile(
            contentPadding: EdgeInsets.all(18),
            title: Text(
              item['text2'],
              style: TextStyle(color: KColor.kWeiXinTextBlueColor),
            ),
            trailing: Image.asset(
              item['img2'],
              width: 60,
            ))
      ],
    );

    return InkWell(
      child: Card(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          //设置圆角
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // 抗锯齿
          clipBehavior: Clip.antiAlias,
          //普通的边
//    shape: Border.all(color: Colors.yellow, width: 5.0),
          elevation: 3,
          // 阴影大小
          child: Container(
            color: Colors.white,
            child: index % 2 == 0 ? _widget1 : _widget2,
          )),
      onTap: () => _clickCell(context, item['title']),
    );
  }

  //点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 ${text}');
  }
}
