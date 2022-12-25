///  wx_add_friend_model.dart
///
///  Created by iotjin on 2020/09/01.
///  description: 添加朋友 model

class WxAddFriendModel {
  String? title;
  String? subtitle;
  String? img;

  WxAddFriendModel({
    this.title,
    this.subtitle,
    this.img,
  });

  WxAddFriendModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['img'] = this.img;
    return data;
  }
}
