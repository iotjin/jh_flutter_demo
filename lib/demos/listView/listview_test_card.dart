import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/res/listData.dart';

class ListViewTest_Card extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('ListViewTest_Card')
      ),
      body:ContentBody(),
    );
  }
}


class ContentBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: listData.map((value){
        return Card(
          margin: EdgeInsets.all(10),
          child:Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20/9,
                child: Image.network(value["imageUrl"],fit: BoxFit.cover,),
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundImage:NetworkImage(value["imageUrl"])
                ),
                title: Text(value["title"]),
                subtitle: Text(value["content"],maxLines: 1,overflow: TextOverflow.ellipsis),
              )
            ],
          ),

        );

      }).toList(),
    );
  }
}