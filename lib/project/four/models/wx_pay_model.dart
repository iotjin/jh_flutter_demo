///  wx_pay_model.dart
///
///  Created by iotjin on 2020/08/27.
///  description: 微信支付 model

class WxPayModel {
  String? title;
  List<FuncList>? funcList;

  WxPayModel({
    this.title,
    this.funcList,
  });

  WxPayModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['funcList'] != null) {
      funcList = <FuncList>[];
      json['funcList'].forEach((v) {
        funcList!.add(FuncList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    if (funcList != null) {
      data['funcList'] = funcList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FuncList {
  String? text;
  String? img;
  String? pushName;

  FuncList({
    this.text,
    this.img,
    this.pushName,
  });

  FuncList.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    img = json['img'];
    pushName = json['pushName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['img'] = img;
    data['pushName'] = pushName;
    return data;
  }
}
