import 'package:flutter/material.dart';
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
            ElevatedButton(
              child: Text("二维码扫描"),
              onPressed: () {
                _scan(context);
              },
            ),
            SizedBox(
              height: 50,
            ),
            Text('扫描到的信息：'),
            SizedBox(
              height: 10,
            ),
            Text(
              _textStr,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 50,
            ),
            // 生成二维码
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码", 100,
                foregroundColor: Colors.yellow),
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码", 100,
                backgroundColor: Colors.yellow),
            SizedBox(
              height: 10,
            ),
            JhQrCodeUtils.createQRCode("生成二维码生成二维码生成二维码2222", 100,
                image: NetworkImage(
                    'https://gitee.com/iotjh/Picture/raw/master/lufei.png'),
                imageSize: Size(20, 20)),
            Center(
              child: QrImage(
                data: '这是二维码的内容',
                size: 200,
                embeddedImage: NetworkImage(
                    'https://gitee.com/iotjh/Picture/raw/master/lufei.png'),
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

  void _scan(context) async {
    JhQrCodeUtils.jumpScan(context).then((value) => setState(() {
          print(value);
          _textStr = value;
        }));
  }
}
