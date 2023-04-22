///  qr_code_scanner_page.dart
///
///  Created by iotjin on 2022/06/05.
///  description:  二维码扫码页(带扫码线动画)

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/project/configs/colors.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

const double _borderRadius = 0;
const double _borderLength = 15;
const double _borderWidth = 5;
const Color _borderColor = KColors.kThemeColor;
const Color _scanLineColor = KColors.kThemeColor;

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({
    Key? key,
    this.isShowScanLine = true,
  }) : super(key: key);

  final bool isShowScanLine; // 是否显示扫描线动画

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

// 动画要添加 TickerProviderStateMixin
class _QrCodeScannerPageState extends State<QrCodeScannerPage> with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  // 动画
  late AnimationController _animationController;
  late Animation<EdgeInsets> _animationSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.isShowScanLine) {
      _initAnimation();
    }
  }

  @override
  void dispose() {
    if (widget.isShowScanLine) {
      _animationController.dispose();
    }
    controller.dispose();
    super.dispose();
  }

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
      controller.resumeCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            cutOutSize: scanArea,
            borderColor: _borderColor,
            borderRadius: _borderRadius,
            borderLength: _borderLength,
            borderWidth: _borderWidth,
          ),
          onPermissionSet: (QRViewController controller, bool isGranted) {
            // 没有权限
            if (!isGranted) {
              JhProgressHUD.showText('没有相机权限！');
              Navigator.of(context).pop();
            }
          },
        ),
        widget.isShowScanLine ? _animatedBuilder() : Container(),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _appBar2(),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.highlight_outlined, size: 32, color: Colors.white),
              onPressed: () => controller.toggleFlash(),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: unused_element
  _appBar1() {
    return const BaseAppBar('');
  }

  _appBar2() {
    return BaseAppBar(
      '',
      bgColor: Colors.transparent,
      leftWidget: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
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

  _initAnimation() {
    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationSize = Tween<EdgeInsets>(
      begin: EdgeInsets.only(bottom: scanArea),
      end: EdgeInsets.only(top: scanArea),
    ).animate(
      // 设置Curve值 动画的执行速率
      CurvedAnimation(parent: _animationController, curve: const Interval(0.0, 1.0)),
    );

    /// 监听动画状态的改变
    /// dismissed：回到动画起点处
    /// forward：从起点往终点方向执行
    /// reverse：从终点往起点反方向执行
    /// completed：到达动画终点处
    _animationController.addStatusListener((status) {
      // 到终点再从起点开始
      if (status == AnimationStatus.completed) {
        _animationController.forward(from: 0.0);
      }

      // 到终点折返回起点
      // if (status == AnimationStatus.completed) {
      //   // 执行结束反向执行
      //   _animationController.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   // 反向执行结束正向执行
      //   _animationController.forward();
      // }
    });

    _animationController.forward();
  }

  _animatedBuilder() {
    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: _animationSize.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: scanArea * 0.9,
                height: 1.0,
                color: _scanLineColor,
              )
            ],
          ),
        );
      },
    );
  }
}
