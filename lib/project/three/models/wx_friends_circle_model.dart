///  wx_friends_circle_model.dart
///
///  Created by iotjin on 2020/09/14.
///  description: 朋友圈 model

class WxFriendsCircleModel {
  int? id;
  String? name;
  String? color;
  String? content;
  String? time;
  List<String>? images;

  WxFriendsCircleModel({
    this.id,
    this.name,
    this.color,
    this.content,
    this.time,
    this.images,
  });

  WxFriendsCircleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    content = json['content'];
    time = json['time'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['content'] = this.content;
    data['time'] = this.time;
    data['images'] = this.images;
    return data;
  }
}
