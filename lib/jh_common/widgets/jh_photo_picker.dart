// ///  jh_photo_picker.dart
// ///
// ///  Created by iotjin on 2020/02/25.
// ///  description:  图片选择
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:photo/photo.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:image_picker/image_picker.dart';
// import 'jh_bottom_sheet.dart';
// import '/jh_common/utils/jh_image_utils.dart';
// import '/jh_common/widgets/jh_photo_browser.dart';
//
// const double _itemSpace = 10.0;
// const double _space = 5.0; // 上下左右间距
// const double _deleteBtnWH = 20.0;
// const Color _bgColor = Colors.transparent;
// //const Color  _bgColor = Colors.yellow;
//
// typedef _CallBack = void Function(List imgArr);
// typedef _ClickCallBack = void Function(List imgArr, int index);
//
// class JhPhotoPicker extends StatefulWidget {
//   final double lfPaddingSpace; // 外部设置的左右间距
//   final _CallBack callBack;
//   final _ClickCallBack clickCallBack;
//
//   JhPhotoPicker({
//     this.lfPaddingSpace,
//     this.callBack,
//     this.clickCallBack,
//   });
//
//   @override
//   _JhPhotoPickerState createState() => _JhPhotoPickerState();
// }
//
// class _JhPhotoPickerState extends State<JhPhotoPicker> {
//   List imgData = List(); // 图片list
//   List<AssetEntity> imgPicked = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     imgData.add('selectPhoto_add'); // 先添加 加号按钮 的图片
//   }
//
//   @override
//   void setState(fn) {
//     // TODO: implement setState
//     super.setState(fn);
//     widget.callBack(getImgData());
//   }
//
//   List getImgData() {
//     List data = List();
//     data.addAll(imgData);
//     data.removeAt(imgData.length - 1);
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var kScreenWidth = MediaQuery.of(context).size.width;
//
//     var lfPadding = widget.lfPaddingSpace == null ? 0.0 : widget.lfPaddingSpace;
//     var ninePictureW = (kScreenWidth - _space * 2 - 2 * _itemSpace - lfPadding);
//     var itemWH = ninePictureW / 3;
//     int columnCount = imgData.length > 6
//         ? 3
//         : imgData.length <= 3
//             ? 1
//             : 2;
//
//     return Container(
//         color: _bgColor,
//         width: kScreenWidth - lfPadding,
//         height:
//             columnCount * itemWH + _space * 2 + (columnCount - 1) * _itemSpace,
//         child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               // 可以直接指定每行（列）显示多少个Item
//               // 一行的Widget数量
//               crossAxisCount: 3,
//               crossAxisSpacing: _itemSpace, // 水平间距
//               mainAxisSpacing: _itemSpace, // 垂直间距
//               childAspectRatio: 1.0, // 子Widget宽高比例
//             ),
//             physics: NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.all(_space),
//             // GridView内边距
//             itemCount: imgData.length,
//             itemBuilder: (context, index) {
//               if (index == imgData.length - 1) {
//                 return addBtn(context, setState, imgData, imgPicked);
//               } else {
//                 return imgItem(index, setState, imgData, imgPicked);
//               }
//             }));
//   }
//
//   /// 添加按钮
//   Widget addBtn(context, setState, imgData, imgPicked) {
//     return GestureDetector(
//       child: Image(image: JhImageUtils.getAssetImage('selectPhoto_add')),
//       onTap: () {
//         /// 点击添加按钮
//         JhBottomSheet.showText(context, dataArr: ['拍照', '相册'], title: '请选择',
//             clickCallback: (index, str) async {
//           if (index == 1) {
//             var image = await ImagePicker().getImage(source: ImageSource.camera);
//             print(image);
//             imgData.insert(imgData.length - 1, image.path);
//             // imgPicked.add(image);
//             setState(() {});
//           }
//           if (index == 2) {
//             pickAsset(context, setState, imgData, imgPicked);
//           }
//         });
//       },
//     );
//   }
//
//   // 图片和删除按钮
//   Widget imgItem(index, setState, imgData, imgPicked) {
//     return GestureDetector(
//       child: Container(
//         color: Colors.transparent,
//         child: Stack(alignment: Alignment.topRight, children: <Widget>[
//           ConstrainedBox(
// //                child:Image.file(imgData[index], fit: BoxFit.cover),
//             child: Image.file(File(imgData[index]), fit: BoxFit.cover),
//             constraints: BoxConstraints.expand(),
//           ),
//           GestureDetector(
//             child: Image(
//               image: JhImageUtils.getAssetImage('selectPhoto_close'),
//               width: _deleteBtnWH,
//               height: _deleteBtnWH,
//             ),
//             onTap: () {
//               // 点击删除按钮
//               setState(() {
//                 imgData.removeAt(index);
//                 // imgPicked.removeAt(index);
//               });
//             },
//           )
//         ]),
//       ),
//       onTap: () {
//         print('点击第${index}张图片');
//         Navigator.of(context).push(new FadeRoute(
//             page: JhPhotoBrowser(
//           imgDataArr: getImgData(),
//           index: index,
//         )));
//       },
//     );
//   }
//
//   /// 多图选择
//   void pickAsset(context, setState, imgData, imgPicked) async {
//     final result = await PhotoPicker.pickAsset(
//       context: context,
//       // pickedAssetList: imgPicked,
//       maxSelected: 9 + 1 - imgData.length,
//       pickType: PickType.onlyImage,
//       thumbSize: 200,
//     );
//
//     if (result != null && result.isNotEmpty) {
//       for (var e in result) {
//         var file = await e.file;
// //      print(file.absolute.path)
//         if (!imgData.contains(file.absolute.path)) {
//           imgData.insert(imgData.length - 1, file.absolute.path);
//         }
//       }
//     }
//
//     // 设置选中数组，相机拍的图片 转 AssetEntity  ？？？？？？
//     // imgPicked.clear();
//     // imgPicked.addAll(result);
//     // imgPicked(() {});
//
//     setState(() {});
//   }
// }
