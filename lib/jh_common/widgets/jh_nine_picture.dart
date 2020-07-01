/**
 *  jh_nine_picture.dart
 *
 *  Created by iotjin on 2020/02/19.
 *  description:  九宫格图片展示
 */
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'jh_photo_allscreen_show.dart';
import 'jh_photo_allscreen_show2.dart';

const double _itemSpace = 10.0;
const double _space = 5.0; //上下左右间距

class jhNinePicture extends StatelessWidget {

  final List<String> imgData;
  final double lfPaddingSpace; //外部设置的左右间距
  final GestureTapCallback onLongPress;
  jhNinePicture({
    this.imgData,
    this.lfPaddingSpace,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {

    var kScreenWidth = MediaQuery.of(context).size.width;

    var lfPadding  = lfPaddingSpace==null ?0.0: lfPaddingSpace;
    var ninePictureW =(kScreenWidth-_space*2-2*_itemSpace-lfPadding);
    var itemWH = ninePictureW/3;
    int columnCount = imgData.length >6 ? 3:imgData.length <= 3 ? 1:2;
//    print("九宫格宽"+ninePictureW.toString());
//    print("item宽"+itemWH.toString());

    return Container(
//        color: Colors.yellow,
        width: kScreenWidth-lfPadding,
        height: columnCount *itemWH +_space*2+(columnCount -1)*_itemSpace,
        child:
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//可以直接指定每行（列）显示多少个Item
              //一行的Widget数量
              crossAxisCount:3,
              crossAxisSpacing: _itemSpace, //水平间距
              mainAxisSpacing: _itemSpace, //垂直间距
              childAspectRatio: 1.0,//子Widget宽高比例
            ),
            physics:NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(_space),//GridView内边距
            itemCount: imgData.length,
            itemBuilder: (context, index) {
              return
                GestureDetector(
                  child:

//                CachedNetworkImage(
//                  imageUrl: imgData[index],
//                  imageBuilder: (context, imageProvider) => Container(
//                    decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: imageProvider,
//                          fit: BoxFit.cover),
//                    ),
//                  ),
//                  placeholder: (context, url) => CircularProgressIndicator(),
//                  errorWidget: (context, url, error) => Icon(Icons.error),
//                ),

                  ConstrainedBox(
                    child:Image.network(imgData[index],fit:BoxFit.cover),
                    constraints: BoxConstraints.expand(),
                  ),

                  onTap: (){
                    print(index);
//                   Navigator.maybePop(context);

                    //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
                    Navigator.of(context).push(new FadeRoute( page:
                    JhPhotoAllScreenShow(
                      imgDataArr:imgData,
                      index: index,
                      onLongPress: onLongPress,
                    )
                    ));

//                    Navigator.of(context).push(
//                      NinePictureAllScreenShow(imgData, index),
//                     );

                  },
                );
            }
        )

    );
  }
}
