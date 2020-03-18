import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhBottomSheet.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhNinePicture2.dart';

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


class GridViewTest3 extends StatefulWidget {
  @override
  _GridViewTest3State createState() => _GridViewTest3State();
}

class _GridViewTest3State extends State<GridViewTest3> {

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
            height: 1600,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("九宫格"),
                Container(
                    padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
                    color: Colors.blue,
                    child:
                    jhNinePicture2(
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
                    jhNinePicture2(
                      imgData: dataArr2,
                      lfPaddingSpace: 110,
                      onLongPress: (){
                        JhBottomSheet.showText(context, dataArr: ["保存图片"]);
                      },
                    )
                ),

//                Container(
//                  padding: EdgeInsets.all(5),
//                  child: jhNinePicture2(imgData: dataArr2,lfPaddingSpace: 10,),
//                )




              ],
            )


        )
    );
  }
}

