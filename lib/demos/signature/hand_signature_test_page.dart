///  hand_signature_test_page.dart
///
///  description:  hand_signature 库签字 Demo（竖屏布局，提示用户横握手机签字）

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:photo_manager/photo_manager.dart';
import '/jh_common/utils/jh_permission_utils.dart';
import '/jh_common/widgets/jh_button.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/project/configs/project_config.dart';

class HandSignatureTestPage extends StatefulWidget {
  const HandSignatureTestPage({Key? key}) : super(key: key);

  @override
  State<HandSignatureTestPage> createState() => _HandSignatureTestPageState();
}

class _HandSignatureTestPageState extends State<HandSignatureTestPage> {
  // 上传/入库固定尺寸
  static const int _exportW = 1000;
  static const int _exportH = 400;

  // 笔触粗细接近 SignatureTestPage 的 penStrokeWidth: 6
  static const HandSignatureDrawer _drawer = LineSignatureDrawer(color: Colors.black, width: 5.0);

  final _control = HandSignatureControl(initialSetup: const SignaturePathSetup(threshold: 3.0, smoothRatio: 0.65, velocityRange: 2.0));

  @override
  void initState() {
    super.initState();
    // 笔迹变化时刷新，用于显示或隐藏签字区域「'请在此签字'」提示文字
    _control.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('手写签字'),
      backgroundColor: KColors.kBgColor,
      body: _body(),
      //
      bottomNavigationBar: _bottomView(),
    );
  }

  Widget _bottomView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _control.clear(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 48),
                  side: const BorderSide(color: KColors.kLineColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: const Text('清除', style: TextStyle(fontSize: 16, color: KColors.kBlackTextColor)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: JhButton(text: '确认', fontSize: 16, minimumSize: const Size(0, 48), onPressed: _onConfirm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _tipBar(),
        Expanded(child: _canvas()),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            '点击确认提交签字',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: KColors.kGreyTextColor),
          ),
        ),
      ],
    );
  }

  // 页面保持竖屏，提示用户横握手机签字
  Widget _tipBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFFFFF7E6),
      child: const Row(
        children: [
          Icon(Icons.screen_rotation, size: 16, color: KColors.kBlackTextColor),
          SizedBox(width: 8),
          Expanded(
            child: Text('请将手机横过来签字', style: TextStyle(fontSize: 13, color: KColors.kBlackTextColor)),
          ),
        ],
      ),
    );
  }

  Widget _canvas() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: KColors.kLineColor, width: 1),
      ),
      // // 裁剪笔迹，避免画出边框外
      // clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          HandSignature(control: _control, drawer: _drawer),
          // 提示文字旋转，横握手机时可正向阅读
          if (!_control.isFilled)
            IgnorePointer(
              child: Center(
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: const Text('请在此签字', style: TextStyle(fontSize: 14, color: KColors.kFormHintColor)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onConfirm() async {
    if (!_control.isFilled) {
      JhProgressHUD.showText('请先完成签字');
      return;
    }
    // 直接导出为固定 1000x400 PNG
    final ByteData? raw = await _control.toImage(
      width: _exportW,
      height: _exportH,
      color: Colors.black,
      background: Colors.white,
      drawer: _drawer,
      fit: true,
    );
    if (raw == null) {
      JhProgressHUD.showText('签字导出失败');
      return;
    }
    final Uint8List bytes = raw.buffer.asUint8List();
    final params = {
      'signatureImage': base64Encode(bytes),
      'fileName': 'signature_${DateTime.now().millisecondsSinceEpoch}.png',
      'mimeType': 'image/png',
      'byteLength': bytes.length,
      'width': _exportW,
      'height': _exportH,
      'source': 'HandSignatureTestPage',
    };
    print(params);
    JhDialog.show(
      context,
      title: '提示',
      content: '确定将签字保存到相册吗？',
      onConfirm: () => _saveToAlbum(bytes),
    );
  }

  /// 保存签字图片到相册
  Future<bool> _saveToAlbum(Uint8List imageBytes) async {
    final hasPermission = await JhPermissionUtils.photos(message: '暂无相册权限，请前往设置开启权限');
    if (!hasPermission) {
      return false;
    }
    try {
      final fileName = 'signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final AssetEntity entity = await PhotoManager.editor.saveImage(imageBytes, filename: fileName, title: fileName);
      print('保存相册成功: id=${entity.id}, title=${entity.title}, width=${entity.width}, height=${entity.height}');
      JhProgressHUD.showText('签字已保存到相册');
      return true;
    } catch (e) {
      print('保存相册失败: $e');
      JhProgressHUD.showText('保存相册失败');
      return false;
    }
  }
}
