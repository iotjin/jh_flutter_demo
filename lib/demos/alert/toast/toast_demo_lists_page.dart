import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';

class ToastDemoListsPage extends StatelessWidget {
  final List titleData = [
    "okToast-文字",
    "okToast-加载中",
    "JhProgress-加载中",
    "JhProgress-文字",
    "JhProgress-成功",
    "JhProgress-失败",
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: "DemoLists",
      dataArr: titleData,
      callBack: (index, str) {
        // oktoast
        if (index == 0) {
          // error
          showToast("hello world", radius: 2.0);
        }
        if (index == 1) {
          // error
          _showCustomWidgetToast();
        }
        if (index == 2) {
          // error
          JhProgressHUD.showLoadingText();
          Future.delayed(Duration(seconds: 5), () {
            // hide toast
            JhProgressHUD.hideHUD();
          });
        }
        if (index == 3) {
          // error
          JhProgressHUD.showText("这是一条提示文字");
        }
        if (index == 4) {
          // error
          JhProgressHUD.showSuccess("加载成功");
        }
        if (index == 5) {
          // error
          JhProgressHUD.showError("加载失败");
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
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )),
            Text("loadingText234234234234",
                style: TextStyle(color: Colors.yellow),
                textAlign: TextAlign.center),
          ],
        )),
  );
  showToastWidget(w);
}
