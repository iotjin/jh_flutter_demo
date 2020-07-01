import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/routes/routes.dart';

class GridViewTest4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GirdView",style:TextStyle (color: Colors.white)),
        elevation: 0.0,
      ),
      body: bgView,

    );
  }
}


Widget bgView = Container(
//  height: 100,
    color: Colors.yellow,

    child: SafeArea(
      child: Stack(
        children: <Widget>[
          gridView,
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child:bottomView,
          ),
        ],
      ),
    )

);


Widget bottomView = Container(
  alignment:Alignment.topLeft ,
  color:Colors.blue,
  child: Column(
    children: <Widget>[
      textListView
    ],
  ),
);



//Widget girdView(String item) {
//  return Container(
//    width: 5.0,
//    height: 5.0,
//    alignment: Alignment.center,
//    child: Text(
//      item,
//      style: TextStyle(color: Colors.white, fontSize: 20),
//    ),
//    color: Colors.blue,
//  );
//}


List<String> getDataList() {
  List<String> list = [];
  for (int i = 0; i < 10; i++) {
    list.add(i.toString());
  }
  return list;
}

List<Widget> getWidgetList() {
//  return getDataList().map((index) => getItemContainer(index)).toList();
  return listData333.map((item) => getItemContainer(item)).toList();

}

Widget getItemContainer(itemData) {
  print("$itemData");
//  int itemIndex = int.parse(index);
//  var data = listData333[itemIndex]['title'];
//var data = index['title'];
//return new Text('$data');
  return Container(
    child: Column(
      children: <Widget>[
        Image.network(itemData['imageUrl'],width: 100,),
//        Image(image: JhImageUtils.getAssetImage(listData333[index]['imageUrl'])),
        SizedBox(height: 10),
        Text(
          itemData['title'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    decoration: BoxDecoration(
        border:
        Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
  );
}

//tabs_service_selected
Widget gridView = GridView.count(
  //水平子Widget之间间距
  crossAxisSpacing: 10.0,
  //垂直子Widget之间间距
  mainAxisSpacing: 30.0,
  //GridView内边距
  padding: EdgeInsets.all(10.0),
  //一行的Widget数量
  crossAxisCount: 3,
  //子Widget宽高比例
  childAspectRatio: 1.0,
  //子Widget列表
  children: getWidgetList(),
);



Widget textListView = Container(
  child: ListView(
    shrinkWrap: true,
//    physics: const NeverScrollableScrollPhysics(),// 禁止滑动
//    children: <Widget>[
//      Text(bottomData[0], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
//      Text(bottomData[1], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
//      Text(bottomData[2], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
//      Text(bottomData[3], style: TextStyle( color: Colors.black, fontSize: 18.0,)),
//    ],
    children: getTextWidgetList(),

  ),
);

List<Widget> getTextWidgetList () {
  return bottomData.map((item) => getTextCon(item)).toList();
}

Widget getTextCon(itemData){
  return Text(itemData, style: TextStyle( color: Colors.black, fontSize: 18.0,));
}

List<String> bottomData = ["1111", "2222", "3333333333333333333", "4444", "5555"];

List listData333=[
  {
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/1.png",
  },
  {
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/2.png",
  },
  {
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/3.png",
  },
  {
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/4.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  }



  ,{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  },{
    "title":"Candy Shop",
    "author":"Mohamed Chahin",
    "imageUrl":"https://www.itying.com/images/flutter/5.png",
  }



];