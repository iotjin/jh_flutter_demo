/**
 *  jhSetCell.dart
 *
 *  Created by iotjin on 2020/04/14.
 *  description:  设置页的cell ，左侧图片，title, 右侧text ,箭头
 */

import 'package:flutter/material.dart';
import '../JhForm/jhTextField.dart';


const double _imgWH = 22.0; //左侧图片宽高
const double _titleSpace = 100.0; //左侧title默认宽
const double _cellHeight = 50.0; //输入、选择样式一行的高度
const TextStyle _titleStyle = TextStyle(fontSize: 16.0,color: Colors.black);
const TextStyle _textStyle = TextStyle(fontSize: 14.0,color: Colors.black54);

typedef _ClickCallBack = void Function();

class JhSetCell extends StatefulWidget {

  final String title;
  final String leftImgPath; //左侧图片路径 ，默认隐藏 ,设置leftImgPath则 leftWidget失效
  final Widget leftWidget; //左侧widget ，默认隐藏
  final String text;
  final Widget rightWidget; //右侧widget ，默认隐藏
  final bool hiddenArrow; //隐藏箭头，默认不隐藏
  final _ClickCallBack clickCallBack;
  final double space;  //标题宽度
  final TextStyle titleStyle;
  final TextStyle textStyle;
  final bool hiddenLine; //隐藏底部横线

  const JhSetCell({
    Key key,
    @required this.title: '',
    this.leftImgPath,
    this.leftWidget,
    this.text: '',
    this.hiddenArrow:false,
    this.rightWidget,
    this.clickCallBack,
    this.space =_titleSpace,
    this.titleStyle = _titleStyle,
    this.textStyle = _textStyle,
    this.hiddenLine = false,
  }): super(key: key);

  @override
  _JhSetCellState createState() => _JhSetCellState();
}

class _JhSetCellState extends State<JhSetCell> {

  bool _hiddenArrow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hiddenArrow = widget.hiddenArrow;

  }


  @override
  Widget build(BuildContext context) {

    double _starW = 0;

    return
      InkWell(
        child:
        DecoratedBox(
          decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: 0.8, color: widget.hiddenLine== true ?Colors.transparent:Theme.of(context).dividerColor),
              insets: EdgeInsets.fromLTRB(_starW,0,0,0)
          ),
          child:
          ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  minHeight: _cellHeight //最小高度为50像素
              ),
              child:
              Row(

                  crossAxisAlignment:CrossAxisAlignment.center,

                  children: <Widget>[

                    widget.leftImgPath!=null ? Image.asset(widget.leftImgPath, width: _imgWH,height: _imgWH,):(widget.leftWidget!=null?widget.leftWidget:Container()),
                    SizedBox(width: widget.leftImgPath!=null ?10:0),
                    Offstage(
                      offstage: widget.title.isEmpty?true:false,
                      child:
                      Container(width: widget.space-_starW,
                        child: Text(widget.title, style: widget.titleStyle),),
                    ),
                    Expanded(
                        child:
                        JhTextField(
                          text: widget.text,
                          hintText: '',
                          enabled:false,
                          textStyle: widget.textStyle,
                          textAlign: TextAlign.right,
                          border: InputBorder.none,
                        )
                    ),
                    widget.rightWidget!=null?widget.rightWidget:Container(),
                    Offstage(
                      offstage: _hiddenArrow,
                      child: Icon(Icons.arrow_forward_ios,size: 18,color: Color(0xFFC8C8C8)),
                    ),
                  ]
              )
          ),
        ),
        onTap: (){
          if(widget.clickCallBack!=null){
            widget.clickCallBack();
          }
        },
      );

  }
}
