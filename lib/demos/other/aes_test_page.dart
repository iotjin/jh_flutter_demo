import 'package:flutter/material.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_encrypt_utils.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_storage_utils.dart';

class AESTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _test();

    return Scaffold(
      appBar: backAppBar(context, 'AES'),
      body: Container(),
    );
  }

  void _test() {

    print("------------------");
    var text = '123';
    print('明文：${text}');

    var base = JhEncryptUtils.encodeBase64(text);
    print('base64: ${base}');

    var enStr = JhEncryptUtils.aesEncrypt(text);
    print('AES 加密：${enStr}');
    var deStr = JhEncryptUtils.aesDecrypt(enStr);
    print('AES 解密：${deStr}');

    var md5 = JhEncryptUtils.encodeMd5(text);
    print('md5 ：${md5}');
    print("------------------");
    print('');

//    print('明文：${text}');
//    var enStr2 = JhEncryptUtils.aesEncode(text);
//    print('加密：${enStr2}');
//    var deStr2 = JhEncryptUtils.aesDecode(enStr);
//    print('解密：${deStr2}');

//  -----------------------------本地加密存储-------------------------------------
    print('-------------------本地加密存储----------------------');
    JhStorageUtils.saveString("testStr", "这是测试本地加密存储的字符串");
    var testStr = JhStorageUtils.getStringWithKey("testStr");
    print('testStr : ${testStr}');

    JhStorageUtils.saveBool('testBool', true);
    var testBool = JhStorageUtils.getBoolWithKey('testBool');
    print('testBool : ${testBool}');

    JhStorageUtils.saveInt('testInt', 1111);
    var testInt = JhStorageUtils.getIntWithKey('testInt');
    print('testInt : ${testInt}');

    JhStorageUtils.saveDouble('testDouble', 222.333354);
    var testDouble = JhStorageUtils.getDoubleWithKey('testDouble');
    print('testDouble : ${testDouble}');

    var dic = {"a": "aaa", 'b': "bbb", "c": "ccc"};
//    print('原始dic: ${dic}');
    JhStorageUtils.saveModel("testDic", dic);
    var testDic = JhStorageUtils.getModelWithKey('testDic');
    print('testDic : ${testDic}');
    print('-------------------本地加密存储----------------------');
    print('');

    //  -----------------------------本地加密存储-------------------------------------

    // 取不存在的key
    print('-------------------取不存在的key----------------------');

    var testStr2 = JhStorageUtils.getStringWithKey("testStr222");
    var test = testStr2 == '' ? "1" : '2222';
    print(test);
    print('testStr2 : ${testStr2}');

    var testBool2 = JhStorageUtils.getBoolWithKey('testBool222');
    print('testBool2 : ${testBool2}');

    var testInt2 = JhStorageUtils.getIntWithKey('testInt222');
    print('testInt2: ${testInt2}');

    var testDouble2 = JhStorageUtils.getDoubleWithKey('testDouble222');
    print('testDouble2 : ${testDouble2}');

    var testDic2 = JhStorageUtils.getModelWithKey('testDic222');
    print('testDic2 : ${testDic2}');
  }
}
