import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_nav_router_utils.dart';
import '/jh_common/widgets/click_item.dart';
import '/base_appbar.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  var _styles = [
    FlutterLogoStyle.stacked,
    FlutterLogoStyle.markOnly,
    FlutterLogoStyle.horizontal
  ];
  var _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.amber
  ];
  var _curves = [
    Curves.ease,
    Curves.easeIn,
    Curves.easeInOutCubic,
    Curves.easeInOut,
    Curves.easeInQuad,
    Curves.easeInCirc,
    Curves.easeInBack,
    Curves.easeInOutExpo,
    Curves.easeInToLinear,
    Curves.easeOutExpo,
    Curves.easeInOutSine,
    Curves.easeOutSine,
  ];

  // 取随机颜色
  Color _randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }

  Timer? _countdownTimer;

  var _currentVersion = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });

    _getInfo(); // 获取设备信息
  }

  void _getInfo() async {
    if (JhDevice.isIOS) {
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

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print('appName $appName');
    print('packageName $packageName');
    print('version $version');
    print('buildNumber $buildNumber');

    setState(() {
      _currentVersion = version;
    });

//   print("$appName=$packageName=$version=$buildNumber");
  }

  void _jumpAppStore() async {
    String url =
        'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8'; // 这是微信的地址，到时候换成自己的应用的地址
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "关于我们"),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          FlutterLogo(
            size: 100.0,
            textColor: _randomColor(),
            style: _styles[Random.secure().nextInt(3)],
            curve: _curves[Random.secure().nextInt(12)],
          ),
          SizedBox(
            height: 20,
          ),
          Text("Version：$_currentVersion"),
          SizedBox(
            height: 50,
          ),
          ClickItem(
              title: 'Github',
              content: 'Go Star',
              onTap: () => JhNavRouterUtils.jumpWebViewPage(
                  context,
                  'jh_flutter_demo',
                  'https://github.com/iotjin/jh_flutter_demo')),
          ClickItem(
              title: 'author',
              content: 'iotjin',
              onTap: () => JhNavRouterUtils.jumpWebViewPage(
                  context, '作者博客', 'https://blog.csdn.net/iotjin')),
          ClickItem(title: "检查更新", onTap: () => _jumpAppStore())
        ],
      ),
    );
  }
}
