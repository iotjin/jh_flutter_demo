///  update_dialog.dart
///
///  Created by iotjin on 2020/07/28.
///  description: APP更新弹框（点确认安卓下载apk，iOS跳转appstore）

// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_permission_utils.dart';
import '/jh_common/utils/jh_theme_utils.dart';
import '/jh_common/utils/jh_version_utils.dart';
import '/project/configs/project_config.dart';
import 'jh_scrollview.dart';

const double _dialogWidth = 280.0;
const double _dialogRadius = 8.0;

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({
    Key? key,
    this.androidAPKURL = '',
    this.androidVersion = '',
    this.titleText = '发现新版本', // 新版本更新、新版本上线了
    this.contentList = const ['1、功能优化、性能优化', '2、修复一些已知问题'],
    this.cancelText = '稍后更新', // 稍后再说、暂不升级、下次再说、残忍拒绝
    this.confirmText = '立即更新', // 立即升级
  }) : super(key: key);

  final String androidAPKURL; // 传值代表需要更新，为空点击确认隐藏弹框
  final String androidVersion;

  final String titleText;
  final List<String> contentList;
  final String cancelText;
  final String confirmText;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final CancelToken _cancelToken = CancelToken();
  late bool _isDownload = false;
  double _value = 0;

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    final Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        // 使用false禁止返回键返回，达到强制升级目的
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: JhThemeUtils.getDialogBackgroundColor(context),
              borderRadius: BorderRadius.circular(_dialogRadius),
            ),
            width: _dialogWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: _dialogWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_dialogRadius), topRight: Radius.circular(_dialogRadius)),
                    image: DecorationImage(image: AssetImage('assets/images/update_head.jpg'), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: Text(widget.titleText, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: _dialogWidth,
                  constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.contentList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(widget.contentList[index]),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 5.0),
                  child: _isDownload
                      ? LinearProgressIndicator(
                          backgroundColor: const Color(0xFFEEEEEE),
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          value: _value,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              onPressed: () => JhNavUtils.goBack(context),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                // 设置按钮大小
                                fixedSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                                minimumSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                                // 背景色
                                backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      // disabled状态颜色
                                      return const Color(0xFFcccccc);
                                    }
                                    // 默认状态颜色
                                    return Colors.transparent;
                                  },
                                ),
                                // 文字颜色
                                foregroundColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      // disabled状态颜色
                                      return Colors.white;
                                    }
                                    // 默认状态颜色
                                    return primaryColor;
                                  },
                                ),
                                // 边框
                                side: MaterialStateProperty.all(BorderSide(color: primaryColor, width: 0.8)),
                                // 圆角
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                ),
                              ),
                              child: Text(widget.cancelText, style: const TextStyle(fontSize: 16.0)),
                            ),
                            TextButton(
                              onPressed: () => _onClickUpdate(),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                // 设置按钮大小
                                fixedSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                                minimumSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                                // 背景色
                                backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      // disabled状态颜色
                                      return const Color(0xFFcccccc);
                                    }
                                    // 默认状态颜色
                                    return primaryColor;
                                  },
                                ),
                                // 文字颜色
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                                // 边框
                                side: MaterialStateProperty.all(BorderSide(color: primaryColor, width: 0.8)),
                                // 圆角
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                ),
                              ),
                              child: Text(widget.confirmText, style: const TextStyle(fontSize: 16.0)),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onClickUpdate() {
    if (JhDeviceUtils.isIOS) {
      JhNavUtils.goBack(context);
      JhVersionUtils.jumpAppStore();
    } else if (JhDeviceUtils.isAndroid) {
      if (widget.androidAPKURL.isNotEmpty && widget.androidVersion.isNotEmpty) {
        setState(() {
          _isDownload = true;
        });
        _requestPermission();
      } else {
        JhNavUtils.goBack(context);
      }
    } else {
      JhNavUtils.goBack(context);
    }
  }

  Future<void> _requestPermission() async {
    // bool isGrantedStorage = await JhPermissionUtils.storage();
    // if (!isGrantedStorage) {
    //   return;
    // }
    _downloadAPK(widget.androidAPKURL, widget.androidVersion);
  }

  /// 下载apk
  Future<void> _downloadAPK(
    String downURL,
    String version, {
    fileName = 'jh_flutter_demo',
    category = 'Download',
    format = 'apk',
  }) async {
    try {
      setInitDir(initStorageDir: true);
      await DirectoryUtil.getInstance();
      DirectoryUtil.createStorageDirSync(category: 'Download');
      String path = DirectoryUtil.getStoragePath(fileName: fileName, category: category, format: format).jhNullSafe;
      // final String path = DirectoryUtil.getStoragePath(fileName: 'jh_flutter_demo_$version', category: 'Download', format: 'apk').jhNullSafe;
      final File file = File(path);

      /// 下载apk
      await Dio().download(
        downURL,
        file.path,
        cancelToken: _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            _value = count / total;
            setState(() {});
            if (count == total) {
              debugPrint('下载完成，apk路径: $path');
              JhNavUtils.goBack(context);
              JhVersionUtils.openAPK(path);
            }
          }
        },
      );
    } catch (e) {
      JhProgressHUD.showText('下载失败!');
      setState(() {
        _isDownload = false;
      });
    }
  }
}
