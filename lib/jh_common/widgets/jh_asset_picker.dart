///  jh_asset_picker.dart
///
///  Created by iotjin on 2022/09/10.
///  description: 基于微信UI的图片/视频选择器(支持拍照及录制视频) 封装wechat_assets_picker、wechat_camera_picker

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

// 最大数量
const int _maxAssets = 9;
// 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
const Duration _maximumRecordingDuration = Duration(seconds: 15);
// 一行显示几个
const int _lineCount = 3;
// 每个GridView item间距(GridView四周与内部item间距在此统一设置)
const double _itemSpace = 5.0;
// 右上角删除按钮大小
const double _deleteBtnWH = 20.0;
// 默认添加图片
const String _addBtnIcon = 'assets/images/selectPhoto_add.png';
// 默认删除按钮图片
const String _deleteBtnIcon = 'assets/images/selectPhoto_close.png';
// 默认背景色
const Color _bgColor = Colors.transparent;

typedef _CallBack = void Function(List<AssetEntity> assetEntityList);

enum AssetType {
  image,
  video,
  imageAndVideo,
}

class JhAssetPicker extends StatefulWidget {
  const JhAssetPicker({
    Key? key,
    this.assetType = AssetType.image,
    this.maxAssets = _maxAssets,
    this.lineCount = _lineCount,
    this.itemSpace = _itemSpace,
    this.maximumRecordingDuration = _maximumRecordingDuration,
    this.bgColor = _bgColor,
    this.callBack,
  }) : super(key: key);

  final AssetType assetType; // 资源类型
  final int maxAssets; // 最大数量
  final int lineCount; // 一行显示几个
  final double itemSpace; // 每个GridView item间距(GridView四周与内部item间距在此统一设置)
  final Duration? maximumRecordingDuration; // 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
  final Color bgColor; // 背景色
  final _CallBack? callBack; // 选择回调

  @override
  _JhAssetPickerState createState() => _JhAssetPickerState();
}

class _JhAssetPickerState extends State<JhAssetPicker> {
  List<AssetEntity> _selectedAssets = [];
  Color _themeColor = KColors.kThemeColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    _themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    var allCount = _selectedAssets.length + 1;
    return Container(
      color: widget.bgColor,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //可以直接指定每行（列）显示多少个Item
          crossAxisCount: widget.lineCount, //一行的Widget数量
          crossAxisSpacing: widget.itemSpace, //水平间距
          mainAxisSpacing: widget.itemSpace, //垂直间距
          childAspectRatio: 1.0, //子Widget宽高比例
        ),
        //GridView内边距
        padding: EdgeInsets.all(widget.itemSpace),
        itemCount: _selectedAssets.length == widget.maxAssets ? _selectedAssets.length : allCount,
        itemBuilder: (context, index) {
          if (_selectedAssets.length == widget.maxAssets) {
            return _itemWidget(index);
          }
          if (index == allCount - 1) {
            return _addBtnWidget();
          } else {
            return _itemWidget(index);
          }
        },
      ),
    );
  }

  // 添加按钮
  Widget _addBtnWidget() {
    return GestureDetector(
      child: Image(image: AssetImage(_addBtnIcon)),
      onTap: () => _showBottomSheet(),
    );
  }

  // 图片和删除按钮
  Widget _itemWidget(index) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.topRight, children: <Widget>[
          ConstrainedBox(
            child: _loadAsset(_selectedAssets[index]),
            constraints: BoxConstraints.expand(),
          ),
          GestureDetector(
            child: Image(
              image: AssetImage(_deleteBtnIcon),
              width: _deleteBtnWH,
              height: _deleteBtnWH,
            ),
            onTap: () => _deleteAsset(index),
          )
        ]),
      ),
      onTap: () => _clickAsset(index),
    );
  }

  Widget _loadAsset(AssetEntity asset) {
    return Image(image: AssetEntityImageProvider(asset), fit: BoxFit.cover);
  }

  void _deleteAsset(index) {
    setState(() {
      _selectedAssets.removeAt(index);
      // 选择回调
      widget.callBack?.call(_selectedAssets);
    });
  }

  // 全屏查看
  void _clickAsset(index) {
    AssetPickerViewer.pushToViewer(
      context,
      currentIndex: index,
      previewAssets: _selectedAssets,
      themeData: AssetPicker.themeData(_themeColor),
    );
  }

  // 点击添加按钮
  void _showBottomSheet() {
    JhBottomSheet.showText(context, dataArr: ['拍摄', '相册'], title: '请选择', clickCallback: (index, str) async {
      if (index == 1) {
        _openCamera();
      }
      if (index == 2) {
        _openAlbum();
      }
    });
  }

  // 相册选择
  Future<void> _openAlbum() async {
    // 相册权限
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps != PermissionState.authorized && ps != PermissionState.limited) {
      JhProgressHUD.showText('暂无相册权限,请前往设置开启权限');
      return;
    }

    RequestType requestType = RequestType.image;
    if (widget.assetType == AssetType.video) {
      requestType = RequestType.video;
    }
    if (widget.assetType == AssetType.imageAndVideo) {
      requestType = RequestType.common;
    }
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: widget.maxAssets,
        requestType: requestType,
        selectedAssets: _selectedAssets,
        themeColor: _themeColor,
        // textDelegate: const EnglishAssetPickerTextDelegate(),
      ),
    );
    if (result != null) {
      setState(() {
        _selectedAssets = result;
      });
      // 相册选择回调
      widget.callBack?.call(result);
    }
  }

  // 拍照或录像
  Future<void> _openCamera() async {
    // 相机权限
    var isGrantedCamera = await Permission.camera.request().isGranted;
    if (!isGrantedCamera) {
      JhProgressHUD.showText('暂无相机权限,请前往设置开启权限');
      return;
    }

    if (widget.assetType != AssetType.image) {
      // 麦克风权限
      var isGrantedMicrophone = await Permission.microphone.request().isGranted;
      if (!isGrantedMicrophone) {
        JhProgressHUD.showText('暂无麦克风权限,请前往设置开启权限');
        return;
      }
    }

    // 相册权限
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps != PermissionState.authorized && ps != PermissionState.limited) {
      JhProgressHUD.showText('暂无相册权限,请前往设置开启权限');
      return;
    }

    final AssetEntity? result = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(
        // 是否可以录像
        enableRecording: widget.assetType != AssetType.image,
        // 录制视频最长时长
        maximumRecordingDuration: widget.maximumRecordingDuration,
        // textDelegate: const EnglishCameraPickerTextDelegate(),
      ),
    );
    if (result != null) {
      setState(() {
        _selectedAssets.add(result);
        // 相机回调
        widget.callBack?.call(_selectedAssets);
      });
    }
  }
}
