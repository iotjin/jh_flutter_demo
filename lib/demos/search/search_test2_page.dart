import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_textfield.dart';
import 'package:jh_flutter_demo/project/routes/navigator_utils.dart';


class SearchTest2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:

//      cursorColor: Colors.white, //设置光标
      AppBar(
        backgroundColor: kThemeColor,
        titleSpacing:0,
        title:

        GestureDetector(
          child:
          Container(
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(5.0)),
            ),
            alignment: Alignment.center,
            height: 38,
//           padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: JhTextField(
                enabled: false,
                leftWidget: Icon(Icons.search,size: 30,),
                hintText: '请输入搜索信息',
            ),
          ),
          onTap: (){
            NavigatorUtils.pushNamed(context, 'SiteSearchPage');
          },
        ),
        actions: <Widget>[

          IconButton(icon:
//              ImageIcon(AssetImage("images/more.png",),color: Colors.white,size: 30,),
          Icon(Icons.more_horiz,color: Colors.white),
              onPressed: (){

              }
              )
          ,
          SizedBox(width: 5,),
        ],
      ),

      body:
      RaisedButton(child: Text("返回"),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }



}