// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_asset_picker.dart';
import '/base_appbar.dart';

class PhotoSelectTest extends StatelessWidget {
  const PhotoSelectTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('PhotoSelect'),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('请选择图片(最多3张)'),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: JhAssetPicker(
                assetType: AssetType.image,
                maxAssets: 3,
                bgColor: Colors.red,
                callBack: (assetEntityList) async {
                  print('assetEntityList-------------');
                  print(assetEntityList);
                  if (assetEntityList.isNotEmpty) {
                    var asset = assetEntityList[0];
                    print(await asset.file);
                    print(await asset.originFile);
                  }
                  print('assetEntityList-------------');
                },
              ),
            ),
            const SizedBox(height: 6),
            const Text('请选择视频(最多1个)'),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: JhAssetPicker(
                maxAssets: 1,
                assetType: AssetType.video,
                bgColor: Colors.red,
                callBack: (assetEntityList) {
                  print('assetEntityList-------------');
                  print(assetEntityList);
                  print('assetEntityList-------------');
                },
              ),
            ),
            const Text('请选择图片或视频(一行展示4个)'),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: JhAssetPicker(
                assetType: AssetType.imageAndVideo,
                lineCount: 4,
                bgColor: Colors.red,
                callBack: (assetEntityList) {
                  print('assetEntityList-------------');
                  print(assetEntityList);
                  print('assetEntityList-------------');
                },
              ),
            ),
          ],
        ));
  }
}
