import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_alert.dart';

class AlertTestPage extends StatelessWidget {

  final List titleData = ["alert1-中间","alert2-中间","alert3-底部-带标题内容","alert4-底部-带标题内容红色按钮", "alert5-底部只有标题红色按钮",
    "alert6-底部只有红色按钮","alert7-底部标题常规按钮"];

  @override
  Widget build(BuildContext context) {
    return  JhTextList(
      title: "AlertDemoLists",dataArr: titleData,
      callBack: (index,str){
        if(index == 0){
          JhAlert.showAlert(context,
            title:"提示",
            clickCallback: (index,Text){
            if(index==1){
              print("点击右侧按钮");
            }
            }
          );

        }
        if(index == 1){
          JhAlert.showAlert(context,
              title:"提示",
            content: "这是内容这是内容这是内容",
              leftText: "左侧",
              rightText: "右侧",
              clickCallback: (index,Text){
                if(index==0){
                  print("点击左侧按钮");
                  Fluttertoast.showToast(msg: "点击左侧按钮");
                }
                if(index==1){
                  print("点击右侧按钮");
                  Fluttertoast.showToast(msg: "点击右侧按钮");
                }
              }
          );

        }
        if(index == 2){
          JhAlert.showActionSheet(context,
              title:"提示",
              content: "这是提示内容这是提示内容这是提示内容这是提示内容",
              otherBtnTitles:["一","二"],
              clickCallback: (index,text){
                print(index);
                Fluttertoast.showToast(msg: text);
              }
          );

        }

        if(index == 3){
          JhAlert.showActionSheet(context,
              title:"这是提示",
              content: "这是提示内容这是提示内容这是提示内容这是提示内容",
              otherBtnTitles:["一","二"],
              redBtnTitle: "删除",
              clickCallback: (index,text){
            print(index);
            print(text);
            Fluttertoast.showToast(msg: text);

              }
          );

        }

        if(index == 4){
          JhAlert.showActionSheet(context,
              title:"这是提示",
              otherBtnTitles:["一"],
              redBtnTitle: "删除",
              clickCallback: (index,text){
                print(index);
                print(text);
                Fluttertoast.showToast(msg: text);

              }
          );

        }

        if(index == 5){
          JhAlert.showActionSheet(context,
              otherBtnTitles:["一"],
              redBtnTitle: "删除",
              clickCallback: (index,text){
                print(index);
                print(text);
                Fluttertoast.showToast(msg: text);

              }
          );

        }

        if(index == 6){
          JhAlert.showActionSheet(context,
              title: "请选择",
              otherBtnTitles:

              ["一","二"],
              clickCallback: (index,text){
                print(index);
                print(text);
                Fluttertoast.showToast(msg: text);

              }
          );

        }




      },
    );

  }
}




// 登录进度提示框  loading 状态
showLoading(BuildContext context, [String text]) {
  text = text ?? "加载中...";
  return
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return
          Center(
            child:Container(
              constraints: BoxConstraints(minHeight: 120, minWidth: 180),
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    //阴影
                    BoxShadow(
                      color: Colors.black12,
                      //offset: Offset(2.0,2.0),
                      blurRadius: 10.0,
                    )
                  ]),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      strokeWidth: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              ),
            ),

          );
      },
    );

}