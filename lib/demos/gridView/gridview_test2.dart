import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_nine_picture.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';

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
            title:Text('GridView实现朋友圈（九宫格）')
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
                    JhNinePicture(
                      imgData: dataArr,
                      lRSpace: 110,
                      onLongPress: (){
                        JhBottomSheet.showText(context, dataArr: ["保存图片"]);
                      },
                    )
                ),
                Text("九宫格，4图未处理"),
                Container(
                    padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
                    color: Colors.blue,
                    child:
                    JhNinePicture(
                      imgData: dataArr2,
                      lRSpace: 110,
                      isHandleFour:false,
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

