import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhBottomSheet.dart';
import 'package:jh_flutter_demo/login/login_page.dart';
import 'package:jhtoast/jhtoast.dart';


class SetPage extends StatelessWidget {

  final List titleData = ["账号安全","关于","退出登录"];

  @override
  Widget build(BuildContext context) {
    return
      JhTextList(
        title: "设置",
        dataArr: titleData,
        callBack: (index,str){

          if(str == "退出登录"){



            JhBottomSheet.showText(context,
                title: "请选择操作",
                redBtnTitle: "退出登录",
                clickCallback: (index,str){
                  if(str=="退出登录"){


                    var hide =  JhToast.showLoadingText_iOS(context,
                      msg:"正在退出...",
                    );
                    Future.delayed(Duration(seconds: 1),(){

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()
                          ), (route) => route == null);

                      hide();

                    });



                  }
                }

            );

          }

        },
      );

  }
}
