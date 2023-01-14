///  wx_subscription_number_model.dart
///
///  Created by iotjin on 2020/09/03.
///  description: 订阅号消息 model

class WxSubscriptionNumberModel {
  String? title;
  String? subtitle;
  String? time;
  String? img1;
  String? text2;
  String? img2;

  WxSubscriptionNumberModel({
    this.title,
    this.subtitle,
    this.time,
    this.img1,
    this.text2,
    this.img2,
  });

  WxSubscriptionNumberModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    time = json['time'];
    img1 = json['img1'];
    text2 = json['text2'];
    img2 = json['img2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['time'] = time;
    data['img1'] = img1;
    data['text2'] = text2;
    data['img2'] = img2;
    return data;
  }
}
