class GroupModel {
  String? groupTitle;
  String? num;
  List<Data>? data;

  GroupModel({this.groupTitle, this.num, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupTitle = json['groupTitle'];
    num = json['num'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupTitle'] = groupTitle;
    data['num'] = num;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  String? phone;
  String? content;
  String? imageUrl;

  Data({this.title, this.phone, this.content, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['phone'] = phone;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
