// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/jh_common/jh_form/jh_set_cell.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_version_utils.dart';
import '/jh_common/widgets/jh_photo_browser.dart';
import '/project/configs/project_config.dart';

class AboutIOSPage extends StatefulWidget {
  const AboutIOSPage({Key? key}) : super(key: key);

  @override
  State<AboutIOSPage> createState() => _AboutIOSPageState();
}

class _AboutIOSPageState extends State<AboutIOSPage> {
  var _currentVersion = '';
  var _info = '';
  var _isNeedUpdate = false;

  @override
  void initState() {
    super.initState();

    _getInfo(); // 获取设备信息
    _getAPPStoreVersion();
  }

  void _getInfo() async {
    if (JhDeviceUtils.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.toString());
      print('name ${iosInfo.name}');
      print('Running on ${iosInfo.utsname.machine}');
      print('Running on ${iosInfo.utsname.sysname}');
      print('Running on ${iosInfo.utsname.nodename}');
      print('Running on ${iosInfo.utsname.release}');
      print('Running on ${iosInfo.utsname.version}');
    }

    print('---------------------------------------');

    PackageInfo packageInfo = await JhDeviceUtils.getPackageInfo();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print('appName $appName');
    print('packageName $packageName');
    print('version $version');
    print('buildNumber $buildNumber');

    setState(() {
      _currentVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('关于我们'),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        const FlutterLogo(size: 100.0),
        const SizedBox(height: 20),
        Text('Version：$_currentVersion'),
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.all(20),
          decoration: KStyles.cellBorderStyle,
          child: Column(
            children: [
              JhSetCell(
                title: 'Github',
                text: 'Go Star',
                clickCallBack: () => _jumpWeb('jh_flutter_demo', 'https://github.com/iotjin/jh_flutter_demo'),
              ),
              JhSetCell(
                title: 'author',
                text: 'iotjin',
                clickCallBack: () => _jumpWeb('作者博客', 'https://blog.csdn.net/iotjin'),
              ),
              JhSetCell(
                title: '赞赏支持',
                clickCallBack: () => _showPicture(),
              ),
              JhSetCell(
                title: '版本更新',
                text: _info,
                textStyle: const TextStyle(color: Colors.red),
                clickCallBack: () {
                  if (_isNeedUpdate == true) {
                    JhVersionUtils.jumpAppStore();
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  _jumpWeb(String title, String url) {
    if (JhDeviceUtils.isWeb) {
      JhCommonUtils.launchWebURL(url);
    } else {
      JhNavUtils.jumpWebViewPage(context, title, url);
    }
  }

  _showPicture() {
    var imgData = ['assets/images/PayCode.jpg'];
    JhPhotoBrowser.show(context, data: imgData, index: 0, isHiddenClose: true);
  }

  void _getAPPStoreVersion() async {
    print('response----');
    var url = 'https://itunes.apple.com/cn/lookup?id=414478124';
    Options options = Options(headers: {HttpHeaders.acceptHeader: 'Content-Type:application/x-www-form-urlencoded'});

    var response = await Dio().post(url, options: options);

    print('results---');
//  print(response.toString());
//  print('--${response.data.trim()}--');

    Map<String, dynamic> data = json.decode(response.data.trim());
//    print('results#####--- ${data['results']}');
    print('version#####--- ${data['results'][0]['version']}');

    var appStoreVersion = data['results'][0]['version'];

    print('CurrentVersion:$_currentVersion');
    print('APPStoreVersion:$appStoreVersion');
    print('---------------------------------');

//    _currentVersion ='7.0.10';
//    print('CurrentVersion:${_currentVersion}');

    print(_currentVersion.compareTo(appStoreVersion)); // 比较大小, 0:相同、1:大于、-1:小于

    if (_currentVersion.compareTo(appStoreVersion) < 0) {
      print('提示更新');

      setState(() {
        _info = '有新版本,去更新';
        _isNeedUpdate = true;
      });
    } else {
      print('不需要更新');

      setState(() {
        _info = 'iOS已是最新版本';
        _isNeedUpdate = false;
      });
    }
  }
}
