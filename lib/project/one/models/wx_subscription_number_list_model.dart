///  wx_subscription_number_list_model.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号列表 model

class WxSubscriptionNumberListModel {
  String? title;
  String? subtitle;
  String? img;
  String? time;

  WxSubscriptionNumberListModel({
    this.title,
    this.subtitle,
    this.img,
    this.time,
  });

  WxSubscriptionNumberListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    img = json['img'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['img'] = this.img;
    data['time'] = this.time;
    return data;
  }
}
