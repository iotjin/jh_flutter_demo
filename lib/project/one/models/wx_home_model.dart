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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['img'] = img;
    data['time'] = time;
    data['isNew'] = isNew;
    data['type'] = type;
    return data;
  }
}
