///  user_model.dart
///
///  Created by iotjin on 2020/05/07.
///  description:  用户信息model

class UserModel {
  String? userID;
  String? userName;
  String? phone;
  String? pwd;
  String? token;
  String? avatarUrl;
  String? sex; // 0男，1女
  String? region;
  String? nickName; // 昵称

  UserModel({
    this.userID,
    this.userName,
    this.phone,
    this.pwd,
    this.token,
    this.avatarUrl,
    this.sex,
    this.region,
    this.nickName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    phone = json['phone'];
    pwd = json['pwd'];
    token = json['token'];
    avatarUrl = json['avatarUrl'];
    sex = json['sex'];
    region = json['region'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['userName'] = userName;
    data['phone'] = phone;
    data['pwd'] = pwd;
    data['token'] = token;
    data['avatarUrl'] = avatarUrl;
    data['sex'] = sex;
    data['region'] = region;
    data['nickName'] = nickName;
    return data;
  }
}
