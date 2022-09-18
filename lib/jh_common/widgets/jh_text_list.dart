///  jh_text_list.dart
///
///  Created by iotjin on 2020/02/18.
///  description:  带箭头文本列表

import 'package:flutter/material.dart';
import '/project/configs/colors.dart';
import '/base_appbar.dart';

const double _lfSpace = 10.0;
const double _cellHeight = 50.0;
const double _lineHeight = 1.0;
const Color _lineColor = KColors.kLineColor;
const Color _lineDarkColor = KColors.kLineDarkColor;
const Color _cellBgColor = KColors.kCellBgColor;
const Color _cellBgDarkColor = KColors.kCellBgDarkColor;

typedef _CallBack = void Function(int selectIndex, String selectStr);

class JhTextList extends StatelessWidget {
  const JhTextList({
    Key? key,
    this.title = '',
    this.dataArr,
    this.callBack,
    this.isBack = true,
  }) : super(key: key);

  final List? dataArr;
  final String title;
  final _CallBack? callBack;
  final bool isBack;

  Widget _getWidget(context, index) {
    var lineColor = Theme.of(context).brightness == Brightness.dark ? _lineDarkColor : _lineColor;
    var cellBgColor = Theme.of(context).brightness == Brightness.dark ? _cellBgDarkColor : _cellBgColor;

    return InkWell(
        child: Container(
            height: _cellHeight,
            color: cellBgColor,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: _lfSpace,
                  child: Text(dataArr?[index]),
                ),
                Positioned(
                  right: _lfSpace,
                  child: Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFC8C8C8)),
                ),
                Positioned(
                    bottom: 0.0,
                    left: _lfSpace,
                    right: 0,
                    child: Container(
                      color: lineColor,
                      height: _lineHeight,
                    )),
              ],
            )),
        onTap: () {
//              print('点击的index---'+index.toString());
          if (callBack != null) {
            callBack!(index, dataArr?[index]);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(title),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: dataArr?.length,
          itemBuilder: this._getWidget,
        ));
  }
}

//           Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                   bottom: Divider.createBorderSide(context, width: 1),
//                 )
//             ),
//             child:
//             ListTile(
//                 title: Text(dataArr[index]),
//                   trailing: Icon(Icons.arrow_forward_ios,size: 18,color: Color(0xFFC8C8C8),),
//                       onTap:() {
//        //                 print('点击的index---'+index.toString());
//                           if(callBack !=null){callBack(index,dataArr[index]);}
//                          }
//                  )
//           );
