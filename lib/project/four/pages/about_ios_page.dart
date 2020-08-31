import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';

import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/widgets/click_item.dart';
import '../../routes/navigator.dart';




class AboutIOSPage extends StatefulWidget {
  @override
  _AboutIOSPageState createState() => _AboutIOSPageState();
}

class _AboutIOSPageState extends State<AboutIOSPage> {

  var _CurrentVersion;
  var _info = "";
  var _isNeedUpate = false;

  @override
  void initState() {
    super.initState();

    _getInfo(); //获取设备信息
    _getAPPStoreVersion();
  }

  void _getInfo() async{

//    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//    print(iosInfo.toString());
//    print('name ${iosInfo.name}');
//    print('Running on ${iosInfo.utsname.machine}');
//    print('Running on ${iosInfo.utsname.sysname}');
//    print('Running on ${iosInfo.utsname.nodename}');
//    print('Running on ${iosInfo.utsname.release}');
//    print('Running on ${iosInfo.utsname.version}');

    print('---------------------------------------');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

//    String appName = packageInfo.appName;
//    String packageName = packageInfo.packageName;
//    String version = packageInfo.version;
//    String buildNumber = packageInfo.buildNumber;
//    print('appName ${appName}');
//    print('packageName ${packageName}');
//    print('version ${version}');
//    print('buildNumber ${buildNumber}');

    setState(() {
      _CurrentVersion = packageInfo.version;
    });

  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "关于我们"),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          FlutterLogo(
            size: 100.0,
          ),
          SizedBox(height: 20,),
          Text("Version：${_CurrentVersion}"),
          SizedBox(height: 50,),
          ClickItem(
            title: 'Github',
            content: 'Go Star',
            onTap: ()=> NavigatorRouterUtils.jumpWebViewPage(context, 'jh_flutter_demo', 'https://github.com/iotjin/jh_flutter_demo')

          ),
          ClickItem(
            title: 'author',
            content: 'iotjin',
            onTap: ()=> NavigatorRouterUtils.jumpWebViewPage(context, '作者博客', 'https://blog.csdn.net/iotjin')

          ),

          ClickItem(
              title: "版本更新",
              content: _info,
              onTap: (){
                if (_isNeedUpate ==true) {
                  _jumpAppStore();
                }
              }
          )
        ],
      ),
    );
  }




  void _jumpAppStore()async {
    String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8'; // 这是微信的地址，到时候换成自己的应用的地址
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _getAPPStoreVersion()async{

    print("response----");
    var url = "https://itunes.apple.com/cn/lookup?id=414478124";
    Options options = Options(headers: {HttpHeaders.acceptHeader:"Content-Type:application/x-www-form-urlencoded"});

    var response = await Dio().post(
        url,
        options: options);

    print("results---");
//  print(response.toString());
//  print('--${response.data.trim()}--');

    Map<String, dynamic> data = json.decode(response.data.trim());
//    print('results#####--- ${data['results']}');
    print('version#####--- ${data['results'][0]['version']}');

    var _APPStoreVersion = data['results'][0]['version'];

    print('CurrentVersion:${_CurrentVersion}');
    print('APPStoreVersion:${_APPStoreVersion}');
    print('---------------------------------');

//    _CurrentVersion ='7.0.10';
//    print('CurrentVersion:${_CurrentVersion}');

    print(_CurrentVersion.compareTo(_APPStoreVersion)); // 比较大小, 0:相同、1:大于、-1:小于

    if(_CurrentVersion.compareTo(_APPStoreVersion)< 0){
      print("提示更新");

      setState(() {
        _info = "有新版本,去更新";
        _isNeedUpate = true;
      });

    }else{
      print("不需要更新");

      setState(() {
        _info = "iOS已是最新版本";
        _isNeedUpate = false;
      });
    }


  }





}




