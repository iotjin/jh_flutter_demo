///  qr_code_grid_scanner_page.dart
///
///  Created by iotjin on 2022/06/05.
///  description:  二维码扫码页(带网格动画)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/configs/colors.dart';
import '/project/routes/jh_nav_utils.dart';

const double _borderRadius = 0;
const double _borderLength = 15;
const Color _borderColor = KColors.kThemeColor;
const Color _gridLineColor = KColors.kThemeColor;

class QrCodeGridScannerPage extends StatefulWidget {
  const QrCodeGridScannerPage({Key? key}) : super(key: key);

  @override
  State<QrCodeGridScannerPage> createState() => _QrCodeGridScannerPageState();
}

class _QrCodeGridScannerPageState extends State<QrCodeGridScannerPage> with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  late AnimationController _animationController;
  late bool _openFlashlight;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _openFlashlight = false;
    _initAnimation();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    controller.dispose();
    _animationController.removeListener(_upState);
    _animationController.dispose();
    super.dispose();
  }

  void _upState() {
    setState(() {});
  }

  void _initAnimation() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animationController
      ..addListener(_upState)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _timer = Timer(const Duration(seconds: 2), () {
            _animationController.reverse(from: 1.0);
          });
        } else if (state == AnimationStatus.dismissed) {
          _timer = Timer(const Duration(seconds: 2), () {
            _animationController.forward(from: 0.0);
          });
        }
      });
    _animationController.forward(from: 0.0);
  }

  Future setFlashlight() async {
    await controller.toggleFlash();
    _openFlashlight = (await controller.getFlashStatus())!;
    _upState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Material(
      color: Colors.black,
      child: LayoutBuilder(builder: (context, constraints) {
        final qrScanSize = constraints.maxWidth * 0.75;
        return Stack(
          children: <Widget>[
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              onPermissionSet: (QRViewController controller, bool isGranted) {
                // 没有权限
                if (!isGranted) {
                  JhProgressHUD.showText('没有相机权限！');
                  Navigator.of(context).pop();
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(leading: const BackButton(), elevation: 0, backgroundColor: Colors.transparent),
                const SizedBox(height: 100),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: qrScanSize,
                    height: qrScanSize,
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: QrScanBoxPainter(
                            boxLineColor: _gridLineColor.withOpacity(0.5),
                            animationValue: _animationController.value,
                            isForward: _animationController.status == AnimationStatus.forward,
                          ),
                          child: Container(),
                        ),
                        Positioned(
                          bottom: 10,
                          width: qrScanSize,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => setFlashlight(),
                              child: Icon(
                                // _openFlashlight ? Icons.flashlight_on_outlined : Icons.flashlight_off_outlined,
                                _openFlashlight ? Icons.highlight_outlined : Icons.highlight_outlined,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text('请将二维码/条形码置于方框中', style: TextStyle(color: Colors.white)),
              ],
            )
          ],
        );
      }),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    // https://github.com/juliuscanute/qr_code_scanner/issues/550
    if (JhDeviceUtils.isAndroid) {
      controller.pauseCamera();
      controller.resumeCamera();
    }
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      /// 避免扫描结果多次回调
      controller.dispose();
      JhNavUtils.goBackWithParams(context, scanData.code ?? '');
    });
  }
}

class QrScanBoxPainter extends CustomPainter {
  const QrScanBoxPainter({
    required this.animationValue,
    required this.isForward,
    required this.boxLineColor,
  });

  final double animationValue;
  final bool isForward;
  final Color boxLineColor;

  @override
  void paint(Canvas canvas, Size size) {
    var radius = _borderRadius;
    var borderLength = _borderLength;

    final borderRadius = BorderRadius.all(Radius.circular(radius)).toRRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawRRect(
      borderRadius,
      Paint()
        ..color = Colors.white54
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    final borderPaint = Paint()
      ..color = _borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    // leftTop
    path.moveTo(0, borderLength);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(borderLength, 0);
    // rightTop
    path.moveTo(size.width - borderLength, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, borderLength);
    // rightBottom
    path.moveTo(size.width, size.height - borderLength);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(size.width - borderLength, size.height);
    // leftBottom
    path.moveTo(borderLength, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, size.height - borderLength);

    canvas.drawPath(path, borderPaint);

    canvas.clipRRect(BorderRadius.all(Radius.circular(radius)).toRRect(Offset.zero & size));

    // 绘制横向网格
    final linePaint = Paint();
    final lineSize = size.height * 0.45;
    final leftPress = (size.height + lineSize) * animationValue - lineSize;
    linePaint.style = PaintingStyle.stroke;
    linePaint.shader = LinearGradient(
      colors: [Colors.transparent, boxLineColor],
      begin: isForward ? Alignment.topCenter : const Alignment(0.0, 2.0),
      end: isForward ? const Alignment(0.0, 0.5) : Alignment.topCenter,
    ).createShader(Rect.fromLTWH(0, leftPress, size.width, lineSize));
    for (int i = 0; i < size.height / 5; i++) {
      canvas.drawLine(
        Offset(i * 5.0, leftPress),
        Offset(i * 5.0, leftPress + lineSize),
        linePaint,
      );
    }
    for (int i = 0; i < lineSize / 5; i++) {
      canvas.drawLine(
        Offset(0, leftPress + i * 5.0),
        Offset(size.width, leftPress + i * 5.0),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(QrScanBoxPainter oldDelegate) => animationValue != oldDelegate.animationValue;

  @override
  bool shouldRebuildSemantics(QrScanBoxPainter oldDelegate) => animationValue != oldDelegate.animationValue;
}
