import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_progress_hud.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flui/src/widgets/toast.dart';
import 'package:oktoast/oktoast.dart';

class ToastDemoListsPage extends StatelessWidget {

  final List titleData = ["flutter_progress_dialog-左右加载中","flutter_progress_dialog-上下加载中",
    "okToast-文字","okToast-加载中",
    "JhProgress-加载中","JhProgress-文字","JhProgress-成功","JhProgress-失败",
    "flui-文字", "flui-加载中", "flui-info", "flui-成功", "flui-失败",
  ];

  @override
  Widget build(BuildContext context) {
    return
      JhTextList(
        title: "DemoLists",
        dataArr: titleData,
        callBack: (index,str){
//          print(index);

        if(index == 0){
          showProgressDialog(context: context,loadingText: "正在加载中...",radius: 3.0);
           Future.delayed(Duration(seconds: 2,), () {
             dismissProgressDialog();
           });
        }
        if(index == 1){
          var dialog = showProgressDialog(
                  context: context,
                  loadingText: "加载中...",
                  radius: 3.0,
                  backgroundColor:Colors.black87,
                  orientation: ProgressOrientation.vertical,
              );
          Future.delayed(Duration(seconds: 2), () {
            dismissProgressDialog();
          });
        }

//oktoast
        if(index == 2){
          /// error
          showToast("hello world",radius: 2.0);
        }
          if(index == 3){
            /// error
            _showCustomWidgetToast();
          }
          if(index == 4){
            /// error
            JhProgressHUD.showLoadingText();
            Future.delayed(Duration(seconds: 5), () {
              /// hide toast
              JhProgressHUD.hideHUD();
            });

          }
          if(index == 5){
            /// error
            JhProgressHUD.showText("这是一条提示文字");
          }
          if(index == 6){
            /// error
            JhProgressHUD.showSuccess("加载成功");
          }
          if(index == 7){
            /// error
            JhProgressHUD.showError("加载失败");
          }

//---------------------FLToast
          if(index == 8){
            FLToast.text(text: 'Here is text');
          }
          if(index == 9){
            var dismiss = FLToast.loading(text: 'Loading...');
            /// do something...
            Future.delayed(Duration(seconds: 2), () {
              /// hide toast
              dismiss();
            });
          }
          if(index == 10){
            /// info
            FLToast.info(text: 'Some info');
          }
          if(index == 11){
            /// success
            FLToast.success(text: 'Fetch success');
          }
          if(index == 12){
            /// error
            FLToast.error(text: 'Something was wrong');
          }



        },
      );

  }
}


void _showCustomWidgetToast() {
  var w = Center(
    child: Container(
      padding: const EdgeInsets.all(5),
      color: Colors.black87,
      child:

//      Row(
//        children: <Widget>[
//          SizedBox(
//            width: 40,
//            height: 40,
//            child: Container(
//              child: CupertinoActivityIndicator(radius: 15,),
//              color: Colors.black87,
//            ),
//          ),

//      Container(
//              width: 40.0,
//              height: 40.0,
//              margin: EdgeInsets.only(bottom: 8.0),
//              padding: EdgeInsets.all(4.0),
//              child: CircularProgressIndicator(strokeWidth: 3.0,valueColor:AlwaysStoppedAnimation<Color>(Colors.white),),
//            ),
//          Icon(
//            Icons.add,
//            color: Colors.white,
//          ),
//          Text(
//            '添加成功',
//            style: TextStyle(color: Colors.white),
//          ),
//        ],
//        mainAxisSize: MainAxisSize.min,
//      ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.all(4.0),
              child:
              CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
              )
            ),
            Text("loadingText234234234234",
                style: TextStyle(color: Colors.yellow), textAlign: TextAlign.center),
          ],
        )


    ),
  );
  showToastWidget(w);
}