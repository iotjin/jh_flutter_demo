import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';


class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    Color _bgColor =  Color(0xFFF8F8F8);

    Color _bgColor =  Colors.orange;

    return

      Scaffold(
          appBar: baseAppBar(context, '',),
          backgroundColor: Color(0xFFF8F8F8),//248
          body:

          ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: double.infinity
              ),
              child:
              Column(
                children: <Widget>[

                  Container(height: 100,
                    color: kThemeColor,
                    alignment:Alignment.center,
                    child:

                    ListTile(
                      leading:
                      Container(width: 50, height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.pink,
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://img5.cache.netease.com/photo/0003/2012-06-21/84G462VS51GQ0003.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title:Text("name",style: TextStyle(color: Colors.white),),
                      subtitle:Text("xxxx公司",style: TextStyle(color: Colors.white),),
                        trailing: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        onTap:(){

                        }
                    ),

                  ),


                  JhSetCell(leftImgPath: "assets/images/ic_accountsafe.png", title: '账号安全'),
                  JhSetCell(leftImgPath: "assets/images/ic_saoyisao.png", title: '扫一扫'),
                  JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '设置'),
                  JhSetCell(leftImgPath: "assets/images/ic_about.png", title: '检查更新',text: '有新版本',textStyle: TextStyle(fontSize: 14.0,color: Colors.red),),


                  Expanded(
                    child:
                    Container(color: _bgColor),
                  ),

                ],
              )
          )

      );




  }
}
