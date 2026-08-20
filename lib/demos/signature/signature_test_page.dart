///  signature_test_page.dart
///
///  description:  signature 库签字 Demo（竖屏布局，提示用户横握手机签字）

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:signature/signature.dart';
import '/jh_common/utils/jh_permission_utils.dart';
import '/jh_common/widgets/jh_button.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/project/configs/project_config.dart';

class SignatureTestPage extends StatefulWidget {
  const SignatureTestPage({Key? key}) : super(key: key);

  @override
  State<SignatureTestPage> createState() => _SignatureTestPageState();
}

class _SignatureTestPageState extends State<SignatureTestPage> {
  // 上传/入库固定尺寸（横握签字后旋转得到的正向图）
  static const int _exportW = 1000;
  static const int _exportH = 400;

  // 笔触：3 偏细；手指签字用 6 较合适，过粗时折线接缝更明显
  final SignatureController _controller = SignatureController(penStrokeWidth: 6, penColor: Colors.black, exportBackgroundColor: Colors.white);

  @override
  void initState() {
    super.initState();
    // 起笔/抬笔时刷新，用于显示或隐藏签字区域「'请在此签字'」提示文字
    _controller.onDrawStart = () => setState(() {});
    _controller.onDrawEnd = () => setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
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
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                },
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Signature(controller: _controller, backgroundColor: Colors.white),
          // 提示文字旋转，横握手机时可正向阅读
          if (_controller.isEmpty)
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
    if (_controller.isEmpty) {
      JhProgressHUD.showText('请先完成签字');
      return;
    }
    final Uint8List? raw = await _controller.toPngBytes();
    if (raw == null || raw.isEmpty) {
      JhProgressHUD.showText('生成签字图片失败，请重试');
      return;
    }
    // 逆时针旋转 90° 得到正向图，再缩放到固定 1000x400
    final Uint8List? rotated = await _rotatePng(raw);
    if (rotated == null) {
      JhProgressHUD.showText('生成签字图片失败，请重试');
      return;
    }
    final Uint8List bytes = await _fitExport(rotated);
    if (!mounted) {
      return;
    }
    final params = {
      'signatureImage': base64Encode(bytes),
      'fileName': 'signature_${DateTime.now().millisecondsSinceEpoch}.png',
      'mimeType': 'image/png',
      'byteLength': bytes.length,
      'width': _exportW,
      'height': _exportH,
      'source': 'SignatureTestPage',
    };
    print(params);
    JhDialog.showCustomDialog(
      context,
      title: '确定将签字保存到相册吗？',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Image.memory(bytes, fit: BoxFit.contain, width: double.infinity),
      ),
      onConfirm: () => _saveToAlbum(bytes),
    );
  }

  /// 逆时针旋转 90°，与横握签字 / 「请在此签字」同向
  Future<Uint8List?> _rotatePng(Uint8List bytes) async {
    final ui.Image src = (await (await ui.instantiateImageCodec(bytes)).getNextFrame()).image;
    final ui.PictureRecorder rec = ui.PictureRecorder();
    final Canvas canvas = Canvas(rec);
    canvas.translate(0, src.width.toDouble());
    canvas.rotate(-math.pi / 2);
    canvas.drawImage(src, Offset.zero, Paint());
    final ui.Image out = await rec.endRecording().toImage(src.height, src.width);
    final ByteData? data = await out.toByteData(format: ui.ImageByteFormat.png);
    src.dispose();
    out.dispose();
    return data?.buffer.asUint8List();
  }

  // signature 的 toPngBytes() 不能指定宽高，只能按屏幕画布导出后再缩放到 1000x400
  Future<Uint8List> _fitExport(Uint8List src) async {
    final ui.Image image = (await (await ui.instantiateImageCodec(src)).getNextFrame()).image;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    canvas.drawRect(Rect.fromLTWH(0, 0, _exportW.toDouble(), _exportH.toDouble()), Paint()..color = Colors.white);
    final double scale = math.min(_exportW / image.width, _exportH / image.height);
    final double dw = image.width * scale;
    final double dh = image.height * scale;
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH((_exportW - dw) / 2, (_exportH - dh) / 2, dw, dh),
      Paint()..filterQuality = FilterQuality.high,
    );
    final ui.Image out = await recorder.endRecording().toImage(_exportW, _exportH);
    final ByteData? data = await out.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    out.dispose();
    return data!.buffer.asUint8List();
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
