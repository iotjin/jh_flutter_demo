import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhNinePicture.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhBottomSheet.dart';

List<String> dataArr;

List<String> dataArr2;

List getData(){
  dataArr = new List();
  for(int i = 0; i < 9; i++){
    var img;
    if(i%2==0){
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei2.png";
    }else{
      img= "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    }
    dataArr.add(img);
  }
  return dataArr;
}

List getData2(){
  dataArr2 = new List();
  for(int i = 0; i < 4; i++){
    var img;
    if(i%2==0){
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei2.png";
    }else{
      img= "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    }
    dataArr2.add(img);
  }
  return dataArr2;
}


class GridViewTest2 extends StatefulWidget {
  @override
  _GridViewTest2State createState() => _GridViewTest2State();
}

class _GridViewTest2State extends State<GridViewTest2> {

  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            title:Text('GridView实现朋友圈效果（九宫格）')
        ),
        body:
        Container(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("九宫格"),
                Container(
                    padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
                    color: Colors.blue,
                    child:
                    jhNinePicture(
                      imgData: dataArr,
                      lfPaddingSpace: 110,
                      onLongPress: (){
                        JhBottomSheet.showText(context, dataArr: ["保存图片"]);
                      },
                    )
                ),
                Text("九宫格"),
                Container(
                    padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
                    color: Colors.blue,
                    child:
                    jhNinePicture(
                      imgData: dataArr2,
                      lfPaddingSpace: 110,
                      onLongPress: (){
                        JhBottomSheet.showText(context, dataArr: ["保存图片"]);
                      },
                    )
                ),




              ],
            )


        )
    );
  }
}

