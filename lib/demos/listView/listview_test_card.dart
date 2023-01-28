import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/base_appbar.dart';
import '/res/list_data.dart';

class ListViewTestCard extends StatelessWidget {
  const ListViewTestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar('ListViewTestCard'),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  const ContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: listData.map((value) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(aspectRatio: 20 / 9, child: JhNetworkImage(value['imageUrl'])),
              ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(value['imageUrl'])),
                title: Text(value['title']),
                subtitle: Text(value['content'], maxLines: 1, overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
