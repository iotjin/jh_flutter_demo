import 'package:flutter/material.dart';

class CustomViewModel {
  String title;
  String place;
  String state;
  String phone;
  String content;
  String imageUrl;

  CustomViewModel({this.title,this.place,this.state, this.phone, this.content, this.imageUrl});

  CustomViewModel.fromJson(Map<String, dynamic> json) {
  title = json['title'];
  place = json['place'];
  state = json['state'];
  phone = json['phone'];
  content = json['content'];
  imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['title'] = this.title;
  data['place'] = this.place;
  data['state'] = this.state;
  data['phone'] = this.phone;
  data['content'] = this.content;
  data['imageUrl'] = this.imageUrl;
  return data;
  }
  }



class ListViewTest_CustomCell extends StatelessWidget {

  final CustomViewModel data;
  const ListViewTest_CustomCell({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spaceHeight = 10.0;
    return Container(
//      height: 100,
        padding: EdgeInsets.all(15),
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: spaceHeight),
            Row(
//        mainAxisAlignment: MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${this.data.place}",style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
//            Text("${this.data.state}",style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
                Row(
                  children: <Widget>[
                    Text("${this.data.state}",style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),),
                    Image.network("${this.data.imageUrl}",width: 30,height: 30),
                  ],
                )

              ],
            ),
            SizedBox(height: spaceHeight),
            Text("${this.data.phone}",textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0)),
            SizedBox(height: spaceHeight),
            Text(
                "${this.data.content}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18.0,backgroundColor: Colors.blue
                )
            ),
          ],
        )
    );
  }
}



//class CustomViewModel {
//  final String title;
//  final String place;
//  final String state;
//  final String content;
//  final String phone;
//  final String imageUrl;
////  final int number;
//  const CustomViewModel({
//    this.title,
//    this.place,
//    this.state,
//    this.content,
//    this.phone,
//    this.imageUrl,
////    this.number,
//  });
//}