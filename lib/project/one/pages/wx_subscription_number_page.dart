///  wx_subscription_number_page.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号消息

import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/project/configs/project_config.dart';
import '../models/wx_subscription_number_model.dart';
import '../widgets/wx_subscription_number_cell.dart';

List _dataArr = [
  {
    'title': '央视新闻',
    'subtitle': '早啊，新闻来了',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture0.jpeg',
    'text2': '今天，央视新闻为你准备了一幅漫画，一起来看看，这是不是学生时代的你',
    'img2': 'assets/images/picture/touxiang_1.jpeg',
  },
  {
    'title': '开发助手',
    'subtitle': '您收到一封新的邮件',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture1.jpeg',
    'text2': '欢迎欢迎',
    'img2': 'assets/images/picture/touxiang_5.jpeg',
  },
  {
    'title': '程序员',
    'subtitle': '程序员面试现场发生了什么？？？',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture2.jpeg',
    'text2': '你的专业能为你做什么',
    'img2': 'assets/images/picture/touxiang_2.jpeg',
  },
  {
    'title': '腾讯新闻',
    'subtitle': '早上好',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture3.jpeg',
    'text2': '来看看今日的天气情况吧',
    'img2': 'assets/images/picture/touxiang_3.jpeg',
  },
  {
    'title': '人民网',
    'subtitle': '夜读',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture8.jpg',
    'text2': '夜读，别高估自己的水平，别低估他人的努力',
    'img2': 'assets/images/picture/touxiang_4.jpeg',
  },
  {
    'title': '阿里技术',
    'subtitle': '从架构到源码：一文了解Flutter渲染机制',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture5.jpeg',
    'text2': '机器学习，从入门到进阶',
    'img2': 'assets/images/picture/touxiang_5.jpeg',
  },
  {
    'title': 'CSDN',
    'subtitle': '小主，您有一条新的留言',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture6.jpg',
    'text2': '欢迎欢迎，快来看看吧',
    'img2': 'assets/images/picture/touxiang_6.jpg',
  },
  {
    'title': '新华网',
    'subtitle': '这种病一旦患上将伴随一生，有些人最容易被盯上',
    'time': '1小时前',
    'img1': 'assets/images/picture/picture7.jpg',
    'text2': '人造肉来了，"香"吗',
    'img2': 'assets/images/picture/tubiao.png',
  },
];

class WxSubscriptionNumberPage extends StatelessWidget {
  const WxSubscriptionNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('订阅号消息', rightImgPath: 'assets/images/ic_gengduo.png', bgColor: Colors.transparent,
          rightItemCallBack: () {
        JhNavUtils.pushNamed(context, 'WxSubscriptionNumberListPage');
      }),
      body: _body(context),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  Widget _body(context) {
    var dataArr = _dataArr;
    return ListView.builder(
      itemCount: dataArr.length,
      itemBuilder: (context, index) {
        WxSubscriptionNumberModel model = WxSubscriptionNumberModel.fromJson(dataArr[index]);
        return WxSubscriptionNumberCell(
          model: model,
          index: index,
          onClickCell: (model) {
            _clickCell(context, model['title']);
          },
        );
      },
    );
  }

  // 点击cell
  _clickCell(context, text) {
    JhToast.showText(context, msg: '点击 $text');
  }
}
