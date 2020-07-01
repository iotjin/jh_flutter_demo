import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_image_utils.dart';

var dataArr;

var phone = "1234xxxx1234";
var address = "这是地址";
var range = "这是描述这是描述";



var adminData =
[
  {
    "title": "title11",
    "icon": "service/icon_baoxiu",
    "bgImg": "service/bg_service_baoxiu"
  },
  {
    "title": "title22",
    "icon": "service/icon_gongdan",
    "bgImg": "service/bg_service_gongdan"
  },
  {
    "title": "title33",
    "icon": "service/icon_fuwufankui",
    "bgImg": "service/bg_service_fuwufankui"
  },
  {
    "title": "title33",
    "icon": "service/icon_fuwufankui",
    "bgImg": "service/bg_service_fuwufankui"
  },
  {
    "title": "title33",
    "icon": "service/icon_fuwufankui",
    "bgImg": "service/bg_service_fuwufankui"
  }
];



class ListViewTest4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('这是标题')
      ),
      body:ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {

  ContentBody({ Key key }) : super(key: key) {
    dataArr = adminData;
  }


  Widget _getWidget(context, index) {

    return  Container(
//        color: Colors.red,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:Container(
            decoration: BoxDecoration(
//              color: Colors.grey,
//              border: Border.all(width: 2.0, color: Colors.red),
              borderRadius: BorderRadius.all( Radius.circular(5.0)),
              image: DecorationImage(
                fit: BoxFit.cover,
//                image: NetworkImage("https://gitee.com/iotjh/Picture/raw/master/lufei.png"),
//                  image: JhImageUtils.getAssetImage("service/bg_service_gongdan"),
                image: JhImageUtils.getAssetImage(dataArr[index]["bgImg"]),
              ),
            ),
            child: Center(
              child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  title: Text(dataArr[index]["title"],style: TextStyle(color: Colors.white,fontSize: 20)),
                  leading:Image(image: JhImageUtils.getAssetImage(dataArr[index]["icon"])),
                  onTap:() {
                    print("点击的index"+index.toString());
                  }
              ) ,
            )

        )
    );
  }

  @override
  Widget build(BuildContext context) {
//    return ListView.builder(
//        itemCount: dataArr.length,
//        itemExtent: 150.0, //强制高度为100.0
//        itemBuilder: this._getWidget
//    ),

    print(MediaQuery.of(context).size.height);
//final size = MediaQuery.of(context).size;
//final width = size.width;
//final height = size.height;
//print('width is $width; height is $height');

    return Container(
      color: Colors.yellow,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child:
//            Column(
//              children: <Widget>[
//                Container(
//                  height: 200,
//                  color: Colors.purple,
//                )
//              ],
//            ),
              ListView.builder(
                  itemCount: dataArr.length,
                  itemExtent: 150.0, //强制高度为100.0
                  itemBuilder: this._getWidget
              )

          ),

          ///下面控件位于Column布局底部
        SafeArea(
            child:
            Container(
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment : CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("热线: ${phone}",style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
                        SizedBox(height: 5),
                        Text("地址: ${address}",style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
                        SizedBox(height: 5),
                        Text("描述: ${range}",style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
                      ],
                    ),
                  )
    ),


        ],
      ),
    );



  }

}

Widget cell =Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/service/lufei.png'),
//    image: Image.network(""),
      fit: BoxFit.cover,
    ),
  ),
  child: Column(),
);


