/**
 *  jh_encrypt_utils.dart
 *
 *  Created by iotjin on 2020/08/18.
 *  description: base64 , aes加解密(CBC/PKCS7)
 */

import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';

var _KEY = "sdfg5468wwdfd542sd4asdf4sadfqd12";
var _IV = "0000000000000000";

//128的keysize=16，192keysize=24，256keysize=32

class JhEncryptUtils {
  //Base64编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  //Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  // md5 加密 32位小写
  static String encodeMd5(String plainText) {
    return EncryptUtil.encodeMd5(plainText);
  }

  //AES加密
  static aesEncrypt(plainText) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(encrypted) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }

//  //aes加密
//  static aesEncode(String plainText) {
//    try {
//      final key = Key.fromBase64(base64Encode(utf8.encode(_KEY)));
//      final iv = IV.fromBase64(base64Encode(utf8.encode(_IV)));
//      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
//      final encrypted = encrypter.encrypt(plainText, iv: iv);
//      return encrypted.base64;
//    } catch (err) {
//      print("aes encode error:$err");
//      return plainText;
//    }
//  }
//
//  //aes解密
//  static aesDecode(dynamic encrypted) {
//    try {
//      final key = Key.fromBase64(base64Encode(utf8.encode(_KEY)));
//      final iv = IV.fromBase64(base64Encode(utf8.encode(_IV)));
//      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
//      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
//      return decrypted;
//    } catch (err) {
//      print("aes decode error:$err");
//      return encrypted;
//    }
//  }
}
