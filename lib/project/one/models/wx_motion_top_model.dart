///  wx_motion_top_model.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动排行榜 model

class WxMotionTopModel {
  int? id;
  String? name;
  String? color;
  int? steps;
  bool? isStar;
  int? starNum;
  bool? isOwn;

  WxMotionTopModel({
    this.id,
    this.name,
    this.color,
    this.steps,
    this.isStar,
    this.starNum,
    this.isOwn,
  });

  WxMotionTopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    steps = json['steps'];
    isStar = json['isStar'];
    starNum = json['starNum'];
    isOwn = json['isOwn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['steps'] = steps;
    data['isStar'] = isStar;
    data['starNum'] = starNum;
    data['isOwn'] = isOwn;
    return data;
  }
}
