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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['img'] = img;
    data['time'] = time;
    return data;
  }
}
