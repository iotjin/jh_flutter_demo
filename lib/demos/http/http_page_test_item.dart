import 'package:flutter/material.dart';
import 'http_page_test_model.dart';

class HttPageTestItem extends StatelessWidget {

  const HttPageTestItem({
    Key key,
    this.data,
    this.onTap,
  }) : super(key: key);

  final WorkOrderModel data;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {

    bool isHidden=  data.phone.isEmpty ? true:false;

    Color textColor =Colors.black;
    if(data.state == "流转中"){
      textColor =Colors.red;
    }else if(data.state == "处理中"){
      textColor =Colors.red;
    }else if(data.state == "已完成"){
      textColor =Colors.orange;
    }


    var spaceHeight = 10.0;
    return
      GestureDetector(
        onTap: onTap,
        child:
        Container(
//      height: 100,
            padding: EdgeInsets.all(15),
//        color: Colors.white,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: spaceHeight),
                Row(
//        mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("地点：${this.data.place}",style: TextStyle(fontSize: 18.0)),
                    Row(
                      children: <Widget>[
                        Text("${this.data.state}",style: TextStyle(fontSize: 18.0,color: textColor)),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),),
                        Image.network("${this.data.imageUrl}",width: 30,height: 30),
                      ],
                    )

                  ],
                ),
                SizedBox(height: spaceHeight),
//            Text("联系人电话：${this.data.phone}",textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0)),
                Offstage(
                  offstage: isHidden,
                  child:  Text("联系人电话：${this.data.phone}",textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0)),
                ),
                Offstage(
                  offstage: isHidden,
                  child:  SizedBox(height: spaceHeight),
                ),

//            Text(
//                "问题描述：${this.data.content}",
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                    fontSize: 18.0,
//                )
//            ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("问题描述：",style: TextStyle(fontSize: 18.0,color: Colors.black)),
                    Expanded(child:
                    Text("${this.data.content}",
                        style: TextStyle(
                          fontSize: 18.0,
                        )
                    ),
                    ),

                  ],
                )


              ],
            )
        ),

      );



  }
}
