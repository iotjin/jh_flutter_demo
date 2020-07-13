class GroupModel {
  String groupTitle;
  String num;
  List<Data> data;

  GroupModel({this.groupTitle, this.num, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupTitle = json['groupTitle'];
    num = json['num'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupTitle'] = this.groupTitle;
    data['num'] = this.num;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String title;
  String phone;
  String content;
  String imageUrl;

  Data({this.title, this.phone, this.content, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['phone'] = this.phone;
    data['content'] = this.content;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

