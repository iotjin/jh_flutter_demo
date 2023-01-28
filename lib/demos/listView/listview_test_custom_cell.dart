import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/project_config.dart';

class CustomViewModel {
  String? title;
  String? place;
  String? state;
  String? phone;
  String? content;
  String? imageUrl;

  CustomViewModel({this.title, this.place, this.state, this.phone, this.content, this.imageUrl});

  CustomViewModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    place = json['place'];
    state = json['state'];
    phone = json['phone'];
    content = json['content'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['place'] = place;
    data['state'] = state;
    data['phone'] = phone;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class ListViewTestCustomCell extends StatelessWidget {
  final CustomViewModel? data;

  const ListViewTestCustomCell({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spaceHeight = 10.0;
    return Container(
//      height: 100,
        padding: const EdgeInsets.all(15),
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: spaceHeight),
            Row(
//        mainAxisAlignment: MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${data!.place}', style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
//            Text('${data.state}',style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
                Row(
                  children: <Widget>[
                    Text('${data!.state}', style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
                    const SizedBox(width: 10),
                    JhNetworkImage(data!.imageUrl.jhNullSafe, width: 30, height: 30),
                  ],
                )
              ],
            ),
            SizedBox(height: spaceHeight),
            Text('${data!.phone}', textAlign: TextAlign.left, style: const TextStyle(fontSize: 18.0)),
            SizedBox(height: spaceHeight),
            Text('${data!.content}',
                textAlign: TextAlign.left, style: const TextStyle(fontSize: 18.0, backgroundColor: Colors.blue)),
          ],
        ));
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
