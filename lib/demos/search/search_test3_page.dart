import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/project/configs/colors.dart';
import 'package:jh_flutter_demo/jh_common/jh_form/jh_login_textfield.dart';


class SearchTest3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:

//      cursorColor: Colors.white, //设置光标
      AppBar(
        backgroundColor: kThemeColor,
        titleSpacing:15,
        automaticallyImplyLeading: false,//隐藏返回箭头
        title:
        Container(
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
            color: Colors.white,
            borderRadius: BorderRadius.all( Radius.circular(5.0)),
          ),
          alignment: Alignment.center,
          height: 38,
//           padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: JhLoginTextField(
            leftWidget: Icon(Icons.search,size: 30,),
            hintText: '请输入搜索信息',
            isShowDeleteBtn: true,
            isDense: true,
          ),
        ),
        actions: <Widget>[

          InkWell(
            child:
            Container(width: 50,height: 50,
              child:  Center(child:
              Text("搜索"),
              ),
            ),

            onTap: () {
            },
          )


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