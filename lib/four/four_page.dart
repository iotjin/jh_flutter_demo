import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/configs/strings.dart';
import 'package:jh_flutter_demo/baseAppBar.dart';
import 'package:jh_flutter_demo/JhTools/JhForm/jhSetCell.dart';


class FourPage extends StatefulWidget {
  @override
  _FourPageState createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
          appBar:
              baseAppBar(context, KString.fourTabTitle,
                  rightImgPath:"assets/images/set.png",
                  rightItemCallBack: (){
                    Navigator.pushNamed(context, "SetPage");
                  }
              ),
          body:
          Scrollbar(
              child: SingleChildScrollView(child:

              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                child:   Column(
                  children: <Widget>[

                    JhSetCell(leftImgPath: "assets/images/ic_accountsafe.png", title: '账号安全'),
                    JhSetCell(leftImgPath: "assets/images/ic_saoyisao.png", title: '扫一扫'),
                    JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '设置'),
                    JhSetCell(leftImgPath: "assets/images/ic_about.png", title: '检查更新',text: '有新版本',textStyle: TextStyle(fontSize: 14.0,color: Colors.red),),




                  ],
                ),
              )
              )
          )


      );

  }
}

