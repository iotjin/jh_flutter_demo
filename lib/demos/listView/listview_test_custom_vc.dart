import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'listview_test_custom_cell.dart';
import 'dart:convert';

var dataArr;
var dataJson;

List getData(){

  dataArr = new List();
  for(int i = 0; i < 50; i++){
    var map = new Map();
    map["title"] = "title${i}";
    map["place"] = "place${i}";
    map["state"] = "流转中${i}";
    map["content"] = "这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容";
    map["phone"] = "${i}${i}${i}xxxxxxx";
    map["imageUrl"] = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    dataArr.add(map);
  }


  dataJson = json.encode(dataArr); //转json 字符串
//  print("转json 字符串:"+dataJson);
  dataArr = json.decode(dataJson);
//  dataArr.forEach((v) {
//    print(v);
//  });

  return dataArr;
}


class ListViewTest_CustomVC extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('ListViewTest_CustomVC')
      ),
      body:ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {

  ContentBody({ Key key }) : super(key: key){
    getData();
  }

  @override
  Widget build(BuildContext context) {

    print(dataArr.length);
    if(dataArr.length==0){
      return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      //    alignment: Alignment.center,
      child:  Text("暂无数据",textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0)),
    );

    }else{

      return ListView.separated(
        itemCount: dataArr.length,
        itemBuilder:(context, index) {
          /*先将字符串转成json*/
          Map<String, dynamic> json = Map<String, dynamic>.from(dataArr[index]);
//        print(json);
          /*将Json转成实体类*/
          CustomViewModel model = CustomViewModel.fromJson(json);
          print("title"+ model.title);
          return ListViewTest_CustomCell(data: model);
        },

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

}


