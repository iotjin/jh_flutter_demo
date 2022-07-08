import 'package:flutter/material.dart';
import '/base_appbar.dart';
import '/res/listData.dart';

class ListViewTestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "ListViewTestCard"),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: listData.map((value) {
        return Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20 / 9,
                child: Image.network(
                  value["imageUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(value["imageUrl"])),
                title: Text(value["title"]),
                subtitle: Text(value["content"], maxLines: 1, overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
