// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_encrypt_utils.dart';
import '/jh_common/utils/jh_storage_utils.dart';
import '/jh_common/jh_form/jh_form_input_cell.dart';
import '/jh_common/widgets/jh_button.dart';
import '/base_appbar.dart';

class AESTestPage extends StatefulWidget {
  const AESTestPage({Key? key}) : super(key: key);

  @override
  State<AESTestPage> createState() => _AESTestPageState();
}

class _AESTestPageState extends State<AESTestPage> {
  var _textStr = '123';
  var _base64encodeStr = '';
  var _base64decodeStr = '';
  var _aesEncryptStr = '';
  var _aesDecryptStr = '';
  var _md5Str = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _test(_textStr);
    storageTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('base64、AES、MD5和本地加密存储'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.only(top: 15),
      children: <Widget>[
        JhFormInputCell(
          title: '明文',
          hintText: '请输入要加密的文字',
          text: _textStr,
          inputCallBack: (value) {
            setState(() => _textStr = value);
          },
        ),
        JhFormInputCell(title: 'Base64编码', text: _base64encodeStr, enabled: false),
        JhFormInputCell(title: 'Base64解码', text: _base64decodeStr, enabled: false),
        JhFormInputCell(title: 'AES加密', text: _aesEncryptStr, enabled: false),
        JhFormInputCell(title: 'AES解密', text: _aesDecryptStr, enabled: false),
        JhFormInputCell(title: 'MD5加密', text: _md5Str, enabled: false),
        const JhFormInputCell(text: '本地加密存储请看控制台输出', enabled: false),
        const SizedBox(height: 50),
        JhButton(
          text: '更新',
          onPressed: () {
            _test(_textStr);
          },
        )
      ],
    );
  }

  void _test(str) {
    print('-------------------数据加解密-------------------');
    var text = str;
    print('明文：$text');

    var base64encodeStr = JhEncryptUtils.encodeBase64(text);
    print('base64: $base64encodeStr');
    var base64decodeStr = JhEncryptUtils.decodeBase64(base64encodeStr);
    print('base64: $base64decodeStr');

    var enStr = JhEncryptUtils.aesEncrypt(text);
    print('AES 加密：$enStr');
    var deStr = JhEncryptUtils.aesDecrypt(enStr);
    print('AES 解密：$deStr');

    var md5 = JhEncryptUtils.encodeMd5(text);
    print('md5 ：$md5');

    setState(() {
      _textStr = str;
      _base64encodeStr = base64encodeStr;
      _base64decodeStr = base64decodeStr;
      _aesEncryptStr = enStr;
      _aesDecryptStr = deStr;
      _md5Str = md5;
    });

//    print('明文：${text}');
//    var enStr2 = JhEncryptUtils.aesEncode(text);
//    print('加密：${enStr2}');
//    var deStr2 = JhEncryptUtils.aesDecode(enStr);
//    print('解密：${deStr2}');
  }

  //  本地加密存储
  void storageTest() {
    print('-------------------本地加密存储-------------------');
    JhAESStorageUtils.saveString('testStr', '这是测试本地加密存储的字符串');
    var testStr = JhAESStorageUtils.getString('testStr');
    print('testStr : $testStr');

    JhAESStorageUtils.saveBool('testBool', true);
    var testBool = JhAESStorageUtils.getBool('testBool');
    print('testBool : $testBool');

    JhAESStorageUtils.saveInt('testInt', 1111);
    var testInt = JhAESStorageUtils.getInt('testInt');
    print('testInt : $testInt');

    JhAESStorageUtils.saveDouble('testDouble', 222.333354);
    var testDouble = JhAESStorageUtils.getDouble('testDouble');
    print('testDouble : $testDouble');

    var dic = {'a': 'aaa', 'b': 'bbb', 'c': 'ccc'};
//    print('原始dic: ${dic}');
    JhAESStorageUtils.saveModel('testDic', dic);
    var testDic = JhAESStorageUtils.getModel('testDic');
    print('testDic : $testDic');

    // 取不存在的key
    print('-------------------取不存在的key----------------------');

    var testStr2 = JhAESStorageUtils.getString('testStr222');
    var test = testStr2 == '' ? '1' : '2222';
    print(test);
    print('testStr2 : $testStr2');

    var testBool2 = JhAESStorageUtils.getBool('testBool222');
    print('testBool2 : $testBool2');

    var testInt2 = JhAESStorageUtils.getInt('testInt222');
    print('testInt2: $testInt2');

    var testDouble2 = JhAESStorageUtils.getDouble('testDouble222');
    print('testDouble2 : $testDouble2');

    var testDic2 = JhAESStorageUtils.getModel('testDic222');
    print('testDic2 : $testDic2');
  }
}
