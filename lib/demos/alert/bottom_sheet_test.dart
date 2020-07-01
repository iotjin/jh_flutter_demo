import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_bottom_sheet.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_picker_tool.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BottomSheetTest extends StatelessWidget {

  final List titleData = ["JhBottomSheet-不带标题","JhBottomSheet-带标题","JhBottomSheet-红色",
    "jhPickerTool-单列","jhPickerTool-多列","jhPickerTool-时间选择YMD","jhPickerTool-时间选择YM","jhPickerTool-时间选择YMD_HM","jhPickerTool-时间选择YMD_AP_HM"];

   var aa =  ["11","22","33","44"];
//       var aa =  [11,22,33,44];
//       var bb =  [[1,2],[3,4],["5","6"]];
   var bb =  [["11","22"],["33","44"],["55","66"]];

  @override
  Widget build(BuildContext context) {
    return JhTextList(title: "BottomSheetTest",dataArr: titleData,
          callBack: (index,str){
          if(str == "JhBottomSheet-不带标题"){

            JhBottomSheet.showText(
                context,
                dataArr: ['hello', 'world', "123"],
                clickCallback:(index,text) {
                    print(index); print(text);
                    showText(text);

                 }
            );

          }
          if(str == "JhBottomSheet-带标题"){

                  JhBottomSheet.showText(
                  context,
                  dataArr:['hello', 'world', "123"],
                  title: "请选择",
                  clickCallback:(index,text) {
                      print(index); print(text);
                      showText(text);
                    }
                );

          }
          if(str == "JhBottomSheet-红色"){
                JhBottomSheet.showText(
                    context,
                    title: "请选择操作",
                    dataArr:['保存本地'],
                    redBtnTitle: "删除",
                    clickCallback:(index,text) {
                      print(index); print(text);
                      showText(text);
                    }
                );
          }

          if(str == "jhPickerTool-单列"){

              JhPickerTool.showStringPicker(context,
                  data: aa,
                  normalIndex: 2,
      //          title: "请选择2",
                  clickCallBack: (int index,var str){
                   print(index);
                   print(str);
                   showText(str);
                 }
            );

          }
          if(str == "jhPickerTool-多列"){

                    JhPickerTool.showArrayPicker(context,
                    data: bb,
                    title: "请选择2",
                    normalIndex: [0,1,0],
                    clickCallBack:(var index, var strData){
                    print(index);
                    print(strData);
                    showText(strData);
                    }
                );

          }
          if(str == "jhPickerTool-时间选择YMD"){

            JhPickerTool.showDatePicker(
                context,
//            dateType: DateType.YMD,
//            dateType: DateType.YM,
//            dateType: DateType.YMD_HM,
//            dateType: DateType.YMD_AP_HM,
//             title: "请选择2",
//            minValue: DateTime(2020,10,10),
//            maxValue: DateTime(2023,10,10),
//            value: DateTime(2020,10,10),
                clickCallback: (var str,var time){
                  print(str);
                  print(time);
                  showText(str);
                }
            );

          }
          if(str == "jhPickerTool-时间选择YM"){

            JhPickerTool.showDatePicker(
                context,
                dateType: DateType.YM,
                clickCallback: (var str,var time){
                  print(str);
                  print(time);
                  showText(str);
                }
            );

          }
          if(str == "jhPickerTool-时间选择YMD_HM"){

            JhPickerTool.showDatePicker(
                context,
                dateType: DateType.YMD_HM,
                clickCallback: (var str,var time){
                  print(str);
                  print(time);
                  showText(str);
                }
            );

          }
          if(str == "jhPickerTool-时间选择YMD_AP_HM"){

            JhPickerTool.showDatePicker(
                context,
                dateType: DateType.YMD_AP_HM,
                clickCallback: (var str,var time){
                  print(str);
                  print(time);
                  showText(str);
                }
            );

          }





          }
    );
  }
}



void showText(str){

  Fluttertoast.showToast(
      msg: str.toString(),
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
  );

//  Fluttertoast.showToast(
//      msg: "This is Center Short Toast",
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIos: 1,
//      backgroundColor: Colors.red,
//      textColor: Colors.white,
//      fontSize: 16.0
//  );

}