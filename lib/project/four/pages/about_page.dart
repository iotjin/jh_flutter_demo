// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_version_utils.dart';
import '/jh_common/widgets/jh_photo_browser.dart';
import '/jh_common/widgets/update_dialog.dart';
import '/project/configs/project_config.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _styles = [FlutterLogoStyle.stacked, FlutterLogoStyle.markOnly, FlutterLogoStyle.horizontal];

  // final _colors = [
  //   Colors.red,
  //   Colors.orange,
  //   Colors.yellow,
  //   Colors.blue,
  //   Colors.purple,
  //   Colors.pink,
  //   Colors.amber
  // ];

  final _curves = [
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

  var _currentVersion = '';
  var _info = '';
  var _isNeedUpdate = false;
  var _androidData = {};

  @override
  void initState() {
    super.initState();

    _initTimer();
    _getCurrentVersion();
    _checkUpdate();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  _initTimer() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  _getCurrentVersion() async {
    String version = await JhDeviceUtils.version();
    setState(() {
      _currentVersion = version;
    });
  }

  _checkUpdate() async {
    if (JhDeviceUtils.isIOS) {
      setState(() {
        _isNeedUpdate = true;
        _info = '有新版本,去更新';
      });
    }
    if (JhDeviceUtils.isAndroid) {
      JhVersionUtils.androidCheckUpdate().then((data) {
        print('安卓检查更新: $data');
        if (data['hasNewVersion'] == true) {
          setState(() {
            _androidData = data;
            _isNeedUpdate = true;
            _info = '有新版本,去更新';
          });
        } else {
          setState(() {
            _androidData = {};
            _isNeedUpdate = false;
            _info = '已是最新版本';
          });
        }
      });
    }
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
        FlutterLogo(
          size: 100.0,
          textColor: _randomColor(),
          style: _styles[Random.secure().nextInt(3)],
          curve: _curves[Random.secure().nextInt(12)],
        ),
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
                title: '检查更新',
                text: _info,
                textStyle: const TextStyle(color: Colors.red),
                clickCallBack: () => _clickUpdate(),
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

  _clickUpdate() {
    if (_isNeedUpdate == true) {
      _showUpdateDialog();
    }
  }

  void _showUpdateDialog() {
    if (JhDeviceUtils.isAndroid) {
      var url = _androidData['url'];
      var version = _androidData['tagName'];
      if (url != null && version != null) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => UpdateDialog(
            androidAPKURL: url,
            androidVersion: version,
            titleText: '发现新版本',
            contentList: const ['1、更新 Flutter SDK和依赖库', '2、项目优化、更新组件和工具类'],
            cancelText: '稍后更新',
            confirmText: '立即更新',
          ),
        );
      }
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const UpdateDialog(
          titleText: '发现新版本',
          contentList: ['1、更新 Flutter SDK和依赖库', '2、项目优化、更新组件和工具类'],
          cancelText: '稍后更新',
          confirmText: '立即更新',
        ),
      );
    }
  }
}
