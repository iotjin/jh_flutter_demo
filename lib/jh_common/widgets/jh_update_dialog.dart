///  jh_update_dialog.dart
///
///  Created by iotjin on 2020/07/28.
///  description: APP更新弹框（点确认安卓下载apk，iOS跳转appstore）

// ignore_for_file: unused_import, unused_element

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:provider/provider.dart';
import '/jh_common/utils/jh_device_utils.dart';
import '/jh_common/utils/jh_permission_utils.dart';
import '/jh_common/utils/jh_theme_utils.dart';
import '/jh_common/utils/jh_version_utils.dart';
import '/project/configs/project_config.dart';
import '/project/provider/theme_provider.dart';
import 'jh_dialog.dart';
import 'jh_scrollview.dart';

const double _dialogWidth = 280.0;
const double _dialogRadius = 8.0;
const Color _cancelTextColor = Color(0xFF999999);
const Color _confirmTextColor = KColors.kThemeColor;
const String _testApkURL = 'https://dldir1.qq.com/weixin/android/weixin8048android2580_0x28003036_arm64.apk';

class JhUpdateDialog {
  static void show(
    BuildContext context, {
    String androidAPKURL = '',
    String androidVersion = '',
    String titleText = '发现新版本', // 新版本更新、新版本上线了
    List<String> contentList = const ['1、功能优化、性能优化', '2、修复一些已知问题'],
    String cancelText = '稍后更新', // 稍后再说、暂不升级、下次再说、残忍拒绝
    String confirmText = '立即更新', // 立即升级
    final VoidCallback? onCancel,
    final VoidCallback? onConfirm,
    bool useStyle2 = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return UpdateDialogView(
          androidAPKURL: androidAPKURL,
          androidVersion: androidVersion,
          titleText: titleText,
          contentList: contentList,
          cancelText: cancelText,
          confirmText: confirmText,
          onCancel: onCancel,
          onConfirm: onConfirm,
          useStyle2: useStyle2,
        );
      },
    );
  }
}

class UpdateDialogView extends StatefulWidget {
  const UpdateDialogView({
    Key? key,
    this.androidAPKURL = '',
    this.androidVersion = '',
    this.titleText = '发现新版本', // 新版本更新、新版本上线了
    this.contentList = const ['1、功能优化、性能优化', '2、修复一些已知问题'],
    this.cancelText = '稍后更新', // 稍后再说、暂不升级、下次再说、残忍拒绝
    this.confirmText = '立即更新', // 立即升级
    this.onCancel,
    this.onConfirm,
    this.useStyle2 = false,
  }) : super(key: key);

  final String androidAPKURL; // 传值代表需要更新，为空点击确认隐藏弹框
  final String androidVersion;
  final String titleText;
  final List<String> contentList;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool useStyle2;

  @override
  State<UpdateDialogView> createState() => _UpdateDialogViewState();
}

class _UpdateDialogViewState extends State<UpdateDialogView> {
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
    return widget.useStyle2 ? _body2() : _body();
  }

  _body() {
    return PopScope(
      canPop: true, // 使用false禁止返回键返回，达到强制升级目的
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(_dialogRadius), topRight: Radius.circular(_dialogRadius)),
                    image: DecorationImage(image: AssetImage('assets/images/ic_update_head.png'), fit: BoxFit.cover),
                    color: Colors.transparent,
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
                _bottomBtnView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomBtnView() {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
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
                  onPressed: () {
                    JhNavUtils.goBack(context);
                    widget.onCancel?.call();
                  },
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
    );
  }

  _body2() {
    var bgColor = Colors.white;
    var titleColor = KColors.dynamicColor(context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor);

    return PopScope(
      canPop: true, // 使用false禁止返回键返回，达到强制升级目的
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(_dialogRadius),
            ),
            width: _dialogWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 125.0,
                  width: _dialogWidth,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: bgColor, width: 0)),
                    image: DecorationImage(image: AssetImage('assets/images/ic_update_head2.png'), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: Text(widget.titleText, style: TextStyle(color: titleColor, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border(bottom: BorderSide(color: bgColor, width: 0)),
                  ),
                ),
                Container(
                  color: bgColor,
                  width: _dialogWidth,
                  padding: EdgeInsets.only(bottom: 10),
                  constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.contentList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(widget.contentList[index], style: TextStyle(color: titleColor)),
                        );
                      },
                    ),
                  ),
                ),
                _bottomBtnView2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomBtnView2() {
    final Color bgColor = Colors.white;
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    return _isDownload
        ? Container(
            color: bgColor,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                backgroundColor: const Color(0xFFEEEEEE),
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                value: _value,
              ),
            ),
          )
        : Container(
            width: _dialogWidth,
            color: bgColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DialogButton(
                  text: widget.cancelText,
                  textColor: _cancelTextColor,
                  onPressed: () {
                    JhNavUtils.goBack(context);
                    widget.onCancel?.call();
                  },
                ),
                SizedBox(height: 48.0, width: 0.6, child: VerticalDivider()),
                DialogButton(
                  text: widget.confirmText,
                  textColor: themeColor,
                  onPressed: () => _onClickUpdate(),
                ),
              ],
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
      DirectoryUtil.createStorageDirSync(category: category);
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
              widget.onConfirm?.call();
              JhVersionUtils.openAPK(path);
            }
          }
        },
      );
    } catch (e) {
      widget.onCancel?.call();
      if (e is DioException) {
        if (e.type == DioExceptionType.cancel) {
          JhProgressHUD.showText('取消下载!');
        } else {
          JhProgressHUD.showText('下载失败!');
        }
      } else {
        JhProgressHUD.showText('下载失败!');
      }
      setState(() {
        _isDownload = false;
      });
    }
  }
}
