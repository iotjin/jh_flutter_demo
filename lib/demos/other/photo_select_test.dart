import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_asset_picker.dart';
import '/base_appbar.dart';

class PhotoSelectTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'PhotoSelect'),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
        color: Colors.yellow,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('请选择图片(最多3张)'),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.only(left: 5),
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
            SizedBox(height: 6),
            Text('请选择视频(最多1个)'),
            Container(
              padding: EdgeInsets.only(left: 5),
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
            Text('请选择图片或视频(一行展示4个)'),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: JhAssetPicker(
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
