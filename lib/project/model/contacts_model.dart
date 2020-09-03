/**
 *  contacts_model.dart
 *
 *  Created by iotjin on 2020/09/01.
 *  description:  联系人model, 通讯录使用
 */

import 'package:azlistview/azlistview.dart';

class ContactsModel extends ISuspensionBean {
  int id;
  String name; //昵称
  String tagIndex;
  String namePinyin;
  String phone;
  String avatarUrl;
  String sex; //0男，1女
  String region;
  String label;
  String color;
  String img;
  bool isStar;

  ContactsModel({
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

  ContactsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagIndex'] = this.tagIndex;
    data['namePinyin'] = this.namePinyin;
    data['phone'] = this.phone;
    data['avatarUrl'] = this.avatarUrl;
    data['sex'] = this.sex;
    data['region'] = this.region;
    data['label'] = this.label;
    data['color'] = this.color;
    data['img'] = this.img;
    data['isStar'] = this.isStar;
    return data;
  }

  @override
  String getSuspensionTag() => tagIndex;
}
