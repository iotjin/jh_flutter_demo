import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var dataArr;

List getData(){

  dataArr = new List();
  for(int i = 0; i < 5; i++){
    var map = new Map();
    map["title"] = "title${i}";
    map["place"] = "place${i}";
    map["state"] = "流转中${i}";
    map["content"] = "这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容";
    map["phone"] = "${i}${i}${i}xxxxxxx";
    map["imageUrl"] = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    dataArr.add(map);
  }
  print(dataArr);
  return dataArr;
}



class ListViewTest3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('ListViewTest3_复杂样式')
      ),
      body:ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {


  ContentBody({ Key key }) : super(key: key){
    getData();
  }




  Widget _getWidget(context, index) {

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
            Text(dataArr[index]["place"],style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
//            Text(dataArr[index]["state"],style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
          Row(
            children: <Widget>[
              Text(dataArr[index]["state"],style: TextStyle(fontSize: 18.0,backgroundColor: Colors.blue)),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),),
              Image.network(dataArr[index]["imageUrl"],width: 30,height: 30),
            ],
          )

          ],
        ),
        SizedBox(height: spaceHeight),
        Text(dataArr[index]["phone"],textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0)),
        SizedBox(height: spaceHeight),
        Text(
            dataArr[index]["content"],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 18.0,backgroundColor: Colors.blue
            )
        ),
      ],
    )
    );

  }



  @override
  Widget build(BuildContext context) {
    return

//      ListView.builder(
//        itemCount: dataArr.length,
//        itemBuilder: this._getWidget
//     );

      ListView.separated(
        itemCount: dataArr.length,
        itemBuilder:  this._getWidget,

        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
            indent: 15,
            endIndent: 15,
//            color: Color(0xFFDDDDDD),
            color: Colors.purple,
          );
        },
      );



  }

}


