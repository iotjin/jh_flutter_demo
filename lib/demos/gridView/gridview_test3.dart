import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_nine_picture.dart';
import '/base_appbar.dart';

List<String>? dataArr;
List<String>? dataArr2;

List getData() {
  dataArr = [];
  for (int i = 0; i < 9; i++) {
    String img;
    if (i % 2 == 0) {
      img = 'https://gitee.com/iotjh/Picture/raw/master/lufei2.png';
    } else {
      img = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    }
    dataArr!.add(img);
  }
  return dataArr!;
}

List getData2() {
  dataArr2 = [];
  for (int i = 0; i < 4; i++) {
    String img;
    if (i % 2 == 0) {
      img = 'https://gitee.com/iotjh/Picture/raw/master/lufei2.png';
    } else {
      img = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    }
    dataArr2!.add(img);
  }
  return dataArr2!;
}

class GridViewTest3 extends StatefulWidget {
  const GridViewTest3({Key? key}) : super(key: key);

  @override
  State<GridViewTest3> createState() => _GridViewTest3State();
}

class _GridViewTest3State extends State<GridViewTest3> {
  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('GridView实现朋友圈效果（九宫格）'),
      body: SizedBox(
        height: 1600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('九宫格'),
            Container(
                padding: const EdgeInsets.fromLTRB(80, 10, 30, 10),
                color: Colors.blue,
                child: JhNinePicture(
                  imgData: dataArr,
                  lRSpace: 110,
                  onLongPress: (int index, dynamic imgArr) {
                    JhBottomSheet.showText(context, dataArr: ['保存图片']);
                  },
                )),
            const Text('九宫格，4图处理'),
            Container(
                padding: const EdgeInsets.fromLTRB(80, 10, 30, 10),
                color: Colors.blue,
                child: JhNinePicture(
                  imgData: dataArr2,
                  lRSpace: 110,
                  onLongPress: (int index, dynamic imgArr) {
                    JhBottomSheet.showText(context, dataArr: ['保存图片']);
                  },
                )),

//                Container(
//                  padding: EdgeInsets.all(5),
//                  child: JhNinePicture2(imgData: dataArr2,lfPaddingSpace: 10,),
//                )
          ],
        ),
      ),
    );
  }
}
