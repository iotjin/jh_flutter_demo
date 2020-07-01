import 'package:flutter/material.dart';


List<String> dataArr;

List getData(){

  dataArr = new List();
  for(int i = 0; i < 10; i++){
    var str ="${i}";
    dataArr.add(str);
  }
  print(dataArr);
  return dataArr;
}

class GridViewTest1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('GridViewTest1')
      ),
      body:ContentBody(),
    );
  }
}


class ContentBody extends StatelessWidget {

      ContentBody({Key key}){
        getData();
      }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child:
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//可以直接指定每行（列）显示多少个Item
              crossAxisCount: 3,//一行的Widget数量
              crossAxisSpacing: 5.0, //水平间距
              mainAxisSpacing: 5.0, //垂直间距
              childAspectRatio: 1.0,//子Widget宽高比例
            ),
//            gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//              // 会根据GridView的宽度和你设置的每个的宽度来自动计算每行显示多少个Item
//              crossAxisSpacing:5.0,
//              mainAxisSpacing: 5.0,
//              maxCrossAxisExtent: 120,
//            ),
            padding: EdgeInsets.all(10.0),//GridView内边距
            itemCount: dataArr.length,
            itemBuilder: (context, index) {
              return item(dataArr,index);
            }
        )

    );
  }
}

Widget item(List data,int index){

  return Container(
    alignment: Alignment.center,
    child: Text(
      data[index],
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    color: Colors.blue,
  );
}

