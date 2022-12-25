///  wx_home_model.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信首页 model

class WxHomeModel {
  String? title;
  String? subtitle;
  String? img;
  String? time;
  bool? isNew;
  String? type;

  WxHomeModel({
    this.title,
    this.subtitle,
    this.img,
    this.time,
    this.isNew,
    this.type,
  });

  WxHomeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    img = json['img'];
    time = json['time'];
    isNew = json['isNew'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['img'] = this.img;
    data['time'] = this.time;
    data['isNew'] = this.isNew;
    data['type'] = this.type;
    return data;
  }
}
