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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['img'] = img;
    return data;
  }
}
