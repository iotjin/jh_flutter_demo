import 'package:flutter/material.dart';
import '/jh_common/utils/jh_permission_utils.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';

final List titleData = [
  'JhPermissionUtils-photos',
  'JhPermissionUtils-camera',
  'JhPermissionUtils-microphone',
  'JhPermissionUtils-storage',
];

class PermissionTestPage extends StatelessWidget {
  const PermissionTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'JhPermissionUtils',
      dataArr: titleData,
      callBack: (index, str) {
        if (str == 'JhPermissionUtils-photos') {
          _photosPermission();
        }
        if (str == 'JhPermissionUtils-camera') {
          _cameraPermission();
        }
        if (str == 'JhPermissionUtils-microphone') {
          _microphonePermission();
        }
        if (str == 'JhPermissionUtils-storage') {
          _storagePermission();
        }
      },
    );
  }

  _photosPermission() async {
    bool isGranted = await JhPermissionUtils.photos();
    if (!isGranted) {
      return;
    }
    JhProgressHUD.showText('已授权photos权限');
  }

  _cameraPermission() async {
    bool isGranted = await JhPermissionUtils.camera();
    if (!isGranted) {
      return;
    }
    JhProgressHUD.showText('已授权camera权限');
  }

  _microphonePermission() async {
    bool isGranted = await JhPermissionUtils.microphone();
    if (!isGranted) {
      return;
    }
    JhProgressHUD.showText('已授权microphone权限');
  }

  _storagePermission() async {
    bool isGranted = await JhPermissionUtils.storage();
    if (!isGranted) {
      return;
    }
    JhProgressHUD.showText('已授权storage权限');
  }
}
