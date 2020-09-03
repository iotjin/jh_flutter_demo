/**
 *  user_model.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  用户信息model
 */

class UserModel {
  String userID;
  String userName;
  String phone;
  String pwd;
  String token;
  String avatarUrl;
  String sex; //0男，1女
  String region;
  String nickName; //昵称

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['pwd'] = this.pwd;
    data['token'] = this.token;
    data['avatarUrl'] = this.avatarUrl;
    data['sex'] = this.sex;
    data['region'] = this.region;
    data['nickName'] = this.nickName;
    return data;
  }
}
