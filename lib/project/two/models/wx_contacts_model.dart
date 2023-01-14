///  wx_contacts_model.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信通讯录 model

import 'package:azlistview/azlistview.dart';

class WxContactsModel extends ISuspensionBean {
  int? id;
  String? name; // 昵称
  String? tagIndex;
  String? namePinyin;
  String? phone;
  String? avatarUrl;
  String? sex; // 0男，1女
  String? region;
  String? label;
  String? color;
  String? img;
  bool? isStar;

  WxContactsModel({
    this.id,
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.phone,
    this.avatarUrl,
    this.sex,
    this.region,
    this.label,
    this.color,
    this.img,
    this.isStar,
  });

  WxContactsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagIndex = json['tagIndex'];
    namePinyin = json['namePinyin'];
    phone = json['phone'];
    avatarUrl = json['avatarUrl'];
    sex = json['sex'];
    region = json['region'];
    label = json['label'];
    color = json['color'];
    img = json['img'];
    isStar = json['isStar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagIndex'] = tagIndex;
    data['namePinyin'] = namePinyin;
    data['phone'] = phone;
    data['avatarUrl'] = avatarUrl;
    data['sex'] = sex;
    data['region'] = region;
    data['label'] = label;
    data['color'] = color;
    data['img'] = img;
    data['isStar'] = isStar;
    return data;
  }

  @override
  String getSuspensionTag() => tagIndex!;
}
