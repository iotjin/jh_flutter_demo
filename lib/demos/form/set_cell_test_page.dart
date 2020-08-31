import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_set_cell.dart';
import 'package:flutter/services.dart';

class SetCellTestPage extends StatefulWidget {
  @override
  _SetCellTestPageState createState() => _SetCellTestPageState();
}

class _SetCellTestPageState extends State<SetCellTestPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        backAppBar(context, 'JhSetCell'),
        body:
        Scrollbar(
            child: SingleChildScrollView(child:

            Padding(
              padding: EdgeInsets.only(top: 15),
              child:   Column(
                children: <Widget>[

                  JhSetCell(title: '左标题',text: '右侧文字',clickCallBack: (){
                    print('点击cell');
                  },),
                  JhSetCell(title: '左标题左标题',text: '右侧文字',),
                  JhSetCell(title: '左标题左标题左标题',text: '右侧文字',titleWidth: 150,),

                  JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '设置',text: '右侧文字'),
                  JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '关于',text: '有新版本',textStyle: TextStyle(fontSize: 15.0,color: Colors.red),),
                  JhSetCell(leftImgPath: "assets/images/shezhi.png", title: '左侧文字红色',titleStyle: TextStyle(fontSize: 15.0,color: Colors.red),),
                  JhSetCell( title: '左标题',text: '隐藏箭头',hiddenArrow: true,),

                  JhSetCell(title: '左标题',text:'左侧自定义',
                    leftWidget: Container(color: Colors.yellow,width: 35,height: 35,),
                  ),
                  JhSetCell(title: "左标题",text:'右侧自定义',
                    rightWidget: Container(color: Colors.yellow,width: 150,height: 45,),
                  ),
                  SizedBox(height: 5),
                  JhSetCell(leftImgPath: "assets/images/shezhi.png",title: "左标题",text:'隐藏底部线', hiddenLine: true,),
                  SizedBox(height: 5),
                  JhSetCell(leftImgPath: "assets/images/shezhi.png",title: "左标题",text:'隐藏底部线', hiddenLine: true,),

                ],
              ),
            )
            )
        )


    );
  }

}
