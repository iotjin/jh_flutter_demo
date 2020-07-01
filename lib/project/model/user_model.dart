/**
 *  user_model.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  用户信息model
 */

class userModel {
  String userID;
  String userName;
  String phone;
  String pwd;
  String token;
  String avatarUrl;

  userModel(
      {this.userID,
        this.userName,
        this.phone,
        this.pwd,
        this.token,
        this.avatarUrl});

  userModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    phone = json['phone'];
    pwd = json['pwd'];
    token = json['token'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['pwd'] = this.pwd;
    data['token'] = this.token;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}