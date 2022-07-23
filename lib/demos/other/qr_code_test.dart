import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/jh_common/utils/jh_qr_code_utils.dart';
import '/base_appbar.dart';

class QRCodeTest extends StatefulWidget {
  @override
  _QRCodeTestState createState() => _QRCodeTestState();
}

class _QRCodeTestState extends State<QRCodeTest> {
  var _textStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "二维码"),
      body: Scrollbar(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("二维码扫描 - qr_code_scanner"),
            ElevatedButton(
              child: Text("二维码扫描"),
              onPressed: () => _scan1(context),
            ),
            ElevatedButton(
              child: Text("二维码扫描-显示扫描线动画"),
              onPressed: () => _scan2(context),
            ),
            ElevatedButton(
              child: Text("二维码扫描-显示网格线动画"),
              onPressed: () => _scan3(context),
            ),
            Text("二维码扫描 - barcode_scan"),
            ElevatedButton(
              child: Text("二维码扫描"),
              onPressed: () => _scan4(context),
            ),
            SizedBox(height: 20),
            Text('扫描到的信息：'),
            SizedBox(height: 20),
            Text(
              _textStr,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            Text('生成二维码'),
            SizedBox(height: 10),
            // 生成二维码
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码", 100, foregroundColor: Colors.yellow),
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码", 100, backgroundColor: Colors.yellow),
            SizedBox(height: 10),
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码2222", 100,
                image: NetworkImage('https://gitee.com/iotjh/Picture/raw/master/lufei.png'), imageSize: Size(20, 20)),
            Center(
              child: QrImage(
                data: '这是二维码的内容',
                size: 200,
                embeddedImage: NetworkImage('https://gitee.com/iotjh/Picture/raw/master/lufei.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(50, 50),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _scan1(context) {
    JhQrCodeUtils.jumpScan(context, callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
      setState(() {
        _textStr = data;
      });
    });
  }

  void _scan2(context) {
    JhQrCodeUtils.jumpScan(context, isShowScanLine: true, callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
      setState(() {
        _textStr = data;
      });
    });
  }

  void _scan3(context) {
    JhQrCodeUtils.jumpScan(context, isShowGridLine: true, callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
      setState(() {
        _textStr = data;
      });
    });
  }

  void _scan4(context) {
    JhQrCodeUtils.scan(callBack: (data) {
      print('扫码结果：$data');
      JhToast.showText(context, msg: '扫码结果：$data');
      setState(() {
        _textStr = data;
      });
    });
  }
}
