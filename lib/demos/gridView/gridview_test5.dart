//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';

class GridViewTestPage5 extends StatefulWidget {
  @override
  _GridViewTestPage5State createState() => _GridViewTestPage5State();
}

class _GridViewTestPage5State extends State<GridViewTestPage5> {

  List _dataArr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataArr = [
      {
        "text":"功能功能0",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能1",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能2",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能3",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能4",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能5",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能6",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },
      {
        "text":"功能功能7",
        "img":"https://gitee.com/iotjh/Picture/raw/master/lufei.png",
        "pushName":"PageName",
      },

    ];


  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
          appBar:
          baseAppBar(context, "标题",
          ),
          backgroundColor: Color(0xFFF8F8F8),
          body:

          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//可以直接指定每行（列）显示多少个Item
                crossAxisCount: 3,//一行的Widget数量
                crossAxisSpacing: 5.0, //水平间距
                mainAxisSpacing: 5.0, //垂直间距
                childAspectRatio: 1.0,//子Widget宽高比例
              ),
              padding: EdgeInsets.all(10.0),//GridView内边距
              itemCount: _dataArr.length,
              itemBuilder: (context, index) {
                return item(_dataArr,index,context);
              }
          )
      );

  }


}


Widget item(List data,int index,context){

  return

    InkWell(
      child:
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFF2F3F7),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Image.asset(data[index]['img'], width: 50.0,height: 50,),
           Image.network(data[index]['img'],width: 50,),
            SizedBox(height: 10,),
            Text(
              data[index]['text'],
              style: TextStyle(color:Color(0xFF666666) , fontSize: 13),
            ),

          ],
        ),
      ),
      onTap: (){
//      print(index);
//        NavigatorUtils.pushNamed(context,  data[index]['pushName']);
      },
    );



}
