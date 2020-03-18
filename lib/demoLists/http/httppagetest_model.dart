/*model*/

class WorkOrderModel {
  var   ID;
  String place;
  String state;
  String phone;
  String content;
  String imageUrl;
  WorkOrderModel({this.ID,this.place,this.state, this.phone, this.content, this.imageUrl});

  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    place = json['place'];
    state = json['state'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['place'] = this.place;
    data['state'] = this.state;
    data['phone'] = this.phone;
    data['content'] = this.content;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}