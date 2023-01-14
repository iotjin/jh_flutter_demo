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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['content'] = content;
    data['time'] = time;
    data['images'] = images;
    return data;
  }
}
