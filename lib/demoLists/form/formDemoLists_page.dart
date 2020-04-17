import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/JhTools/widgets/jhTextList.dart';

class FormDemoListsPage extends StatelessWidget {

  final List titleData = ["JhLoginTextField","JhTextField","JhFormInputCell","JhFormSelectCell","JhSetCell"];
  final List routeData = ["LoginTextFieldTestPage","InputTextFieldTestPage","FormInputCellTestPage","FormSelectCellTestPage","SetCellTestPage"];
  @override
  Widget build(BuildContext context) {
    return  JhTextList(
      title: "JhForm",dataArr: titleData,
      callBack: (index,str){
        print(index);
        Navigator.pushNamed(context, routeData[index]);

      },
    );

  }
}