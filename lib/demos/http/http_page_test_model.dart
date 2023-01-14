class HttpPageTestModel {
  // ignore: non_constant_identifier_names
  String? ID;
  String? place;
  String? state;
  String? phone;
  String? content;
  String? imageUrl;

  HttpPageTestModel({
    // ignore: non_constant_identifier_names
    this.ID,
    this.place,
    this.state,
    this.phone,
    this.content,
    this.imageUrl,
  });

  HttpPageTestModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    place = json['place'];
    state = json['state'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = ID;
    data['place'] = place;
    data['state'] = state;
    data['phone'] = phone;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
