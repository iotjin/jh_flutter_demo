///  wx_motion_model.dart
///
///  Created by iotjin on 2020/09/09.
///  description: 微信运动 model

class WxMotionModel {
  String? time;
  String? ranking;
  String? steps;
  String? img;
  String? text;
  String? color;

  WxMotionModel({
    this.time,
    this.ranking,
    this.steps,
    this.img,
    this.text,
    this.color,
  });

  WxMotionModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    ranking = json['ranking'];
    steps = json['steps'];
    img = json['img'];
    text = json['text'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['ranking'] = this.ranking;
    data['steps'] = this.steps;
    data['img'] = this.img;
    data['text'] = this.text;
    data['color'] = this.color;
    return data;
  }
}
