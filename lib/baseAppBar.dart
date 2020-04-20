/**
 *  baseAppBar.dart
 *
 *  Created by iotjin on 2020/03/10.
 *  description:  导航条
 */
import 'package:flutter/material.dart';

const Color _navbgColor = Color(0xFF3BB815);
const Color _titleColorWhite = Colors.white;
const Color _titleColorBlack = Colors.black;
const double _titleFontSize = 18.0;
const double _textFontSize = 16.0;
const double _itemSpace = 15.0; //右侧item间距
const double _imgWH = 22.0;

/*带返回箭头导航条*/
backAppBar(BuildContext context, String title,{
  String rightText,
  String rightImgPath,
  Color backgroundColor = _navbgColor,
  Function rightItemCallBack,
  Function backCallBack
}){
  return baseAppBar(context, title,
      isBack: true,
      rightText: rightText,
      rightImgPath: rightImgPath,
      rightItemCallBack:rightItemCallBack,
      leftItemCallBack: backCallBack,
      backgroundColor: backgroundColor
  );
}


baseAppBar(BuildContext context, String title, {
  String rightText,
  String rightImgPath,
  Widget leftItem:null,
  bool isBack:false,
  Color backgroundColor = _navbgColor,
  Function rightItemCallBack,
  Function leftItemCallBack,
})
{

  Color _color = backgroundColor==Colors.transparent? _titleColorBlack:_titleColorWhite;

  Widget rightItem=Text("");
  if(rightText!=null){
    rightItem = InkWell(
      child:Container(
          margin: EdgeInsets.all(_itemSpace),
          color: Colors.transparent,
          child: Center(child:
          Text(rightText, style: TextStyle(fontSize: _textFontSize, color: _color))
          )
      ),
      onTap: () {
        if(rightItemCallBack!=null){
          rightItemCallBack();
        }
      },
    );
  }
  if(rightImgPath!=null){
    rightItem =  IconButton(
      icon: Image.asset(rightImgPath,width: _imgWH,height: _imgWH,),
      onPressed: () {
        if(rightItemCallBack!=null){
          rightItemCallBack();
        }
      },
    );
  }
  return AppBar(
    title: Text(title, style: TextStyle(fontSize: _titleFontSize, color: _color)),
    centerTitle: true,
    backgroundColor: backgroundColor,
    elevation: 0,
    leading:isBack == false ?leftItem:
    IconButton(
      icon: Icon(Icons.arrow_back_ios,color: _color),
      onPressed: () {
        if (leftItemCallBack == null) {
          _popThis(context);
        } else {
          leftItemCallBack();
        }
      },
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rightItem,
        ],
      ),
    ],

  );

}

void _popThis(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}

