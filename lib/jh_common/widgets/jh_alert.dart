/**
 *  jh_alert.dart
 *
 *  Created by iotjin on 2020/03/07.
 *  description:  iOS风格的弹框工具类
 */
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


//取消按钮的index 为 0 ,确认为 1
typedef _ClickCallBack = void Function(int selectIndex,String selectText);

class JhAlert{

  static void showAlert(
      @required BuildContext context,
      {   String title,
        String content,
        String leftText ="取消",
        String rightText ="确认",
        _ClickCallBack clickCallback
      }
      ){

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return
            CupertinoAlertDialog(
              title: Offstage(
                offstage: title==null? true:false,
                child:  Text(title==null?"":title),
              ),
              content: Offstage(
                offstage: content==null? true:false,
                child:  Text(content==null?"":content),
              ),
              actions: <Widget>[
//            CupertinoButton(
//              child: Text("取消",style: TextStyle(fontSize: 10),),
//              onPressed: () {
//                Navigator.pop(context);//Navigator.of(context).pop("点击了取消");
//              },
//            ),
                FlatButton( //取消
                  child: Text(leftText,style: TextStyle(color: Colors.blueAccent),),
                  onPressed: () {
                    Navigator.pop(context);
                    if(clickCallback!=null){
                      clickCallback(0,leftText);
                    }
                  },
                ),
                FlatButton(//确认
                  child: Text(rightText,style: TextStyle(color: Colors.blueAccent),),
                  onPressed: () {
                    Navigator.pop(context);
                    if(clickCallback!=null){
                      clickCallback(1,leftText);
                    }
                  },
                ),
              ],
            );
        });
  }

  /**
      index 从上往下 1，2，3，取消是0
   */
  static void showActionSheet(
      @required BuildContext context,
      {
        String title,
        String content,
        @required List<String>otherBtnTitles,
        String redBtnTitle,
        _ClickCallBack clickCallback
      }
      ){
    List<CupertinoActionSheetAction> otherBtns=List();
    for(int i=1;i<otherBtnTitles.length+1;i++){
      var w  = CupertinoActionSheetAction(
        onPressed: (){
          Navigator.pop(context);
          if(clickCallback!=null){
            clickCallback(i,otherBtnTitles[i-1]);
          }
        },
        child: Text(otherBtnTitles[i-1]),                  );
      otherBtns.add(w);
    }

    if(redBtnTitle!=null){
      var w  = CupertinoActionSheetAction(
        onPressed: (){
          Navigator.pop(context);
          if(clickCallback!=null){
            clickCallback(otherBtnTitles.length+1,redBtnTitle);
          }
        },
        child: Text(redBtnTitle),
        isDestructiveAction: true,
      );
      otherBtns.insert(otherBtnTitles.length, w);
    }

    if(title==null){

      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: otherBtns,
            cancelButton: CupertinoActionSheetAction( //取消按钮
              onPressed: () {
                Navigator.pop(context);
                if(clickCallback!=null){
                  clickCallback(0,"取消");
                }
              },
              child: Text('取消'),
            ),
          );
        },
      );

    }else{

      if(content!=null){
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Offstage(
                offstage: title==null? true:false,
                child:  Text(title==null?"":title,style: TextStyle(fontSize: 20)),
              ),
              message:Text(content),
              actions: otherBtns,
              cancelButton: CupertinoActionSheetAction( //取消按钮
                onPressed: () {
                  Navigator.pop(context);
                  if(clickCallback!=null){
                    clickCallback(0,"取消");
                  }
                },
                child: Text('取消'),
              ),
            );
          },
        );

      }else{
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Offstage(
                offstage: title==null? true:false,
                child:  Text(title==null?"":title),
              ),
              actions: otherBtns,
              cancelButton: CupertinoActionSheetAction( //取消按钮
                onPressed: () {
                  Navigator.pop(context);
                  if(clickCallback!=null){
                    clickCallback(0,"取消");
                  }
                },
                child: Text('取消'),
              ),
            );
          },
        );
      }


    }







  }



}






/**

    localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalEasyRefreshLocalizations.delegate,
    const FallbackCupertinoLocalisationsDelegate() //需要添加到mian里
    ],

 */

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}




//void aa(BuildContext context){
//  showCupertinoModalPopup(
//    context: context,
//    builder: (context) {
//      return CupertinoActionSheet(
//              title:  Text('提示', style: TextStyle(fontSize: 22),), //标题
//              message: Text('麻烦抽出几分钟对该软件进行评价，谢谢!'), //提示内容
//              actions:<Widget>[ //操作按钮集合
//                CupertinoActionSheetAction(
//                  onPressed: (){
//                    Navigator.pop(context);
//                  },
//                  child: Text('给个好评'),
//                ),
//                CupertinoActionSheetAction(
//                  onPressed: (){
//                    Navigator.pop(context);
//                  },
//                  child: Text('我要吐槽'),
//                ),
//              ],
//        cancelButton: CupertinoActionSheetAction( //取消按钮
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('取消'),
//        ),
//      );
//    },
//  );
//
//}
