import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_photo_picker.dart';
import '/base_appbar.dart';

class PhotoSelectTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context, "PhotoSelectTest"),
        body: Container(
          padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
          color: Colors.yellow,
          // child: JhPhotoPicker(
          //   lfPaddingSpace: 110,
          //   callBack: (var img) {
          //     print("img-------------");
          //     print(img.length);
          //     print(img);
          //     print("img-------------");
          //   },
          // )
        ));
  }
}
