///  map_jump_test_page.dart
///
///  Created by iotjin on 2023/10/16.
///  description:

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import '/jh_common/utils/jh_map_utils.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';

// ignore_for_file: avoid_print

final List titleData = [
  '高德(JhMapUtils)',
  '高德2(JhMapUtils)',
  '百度(JhMapUtils)',
  '腾讯(JhMapUtils)',
  '三方库跳转高德(map_launcher)',
  '三方库弹出地图列表(map_launcher)',
];

class MapJumpTestPage extends StatefulWidget {
  const MapJumpTestPage({Key? key}) : super(key: key);

  @override
  State<MapJumpTestPage> createState() => _MapJumpTestPageState();
}

class _MapJumpTestPageState extends State<MapJumpTestPage> {
  var latitude = 39.922869448132474;
  var longitude = 116.40748500823975;

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: '跳转三方地图导航',
      dataArr: titleData,
      callBack: (index, str) {
        if (str == '高德(JhMapUtils)') {
          JhMapUtils.openAMapNavi(dLatitude: latitude, dLongitude: longitude);
        }
        if (str == '高德2(JhMapUtils)') {
          JhMapUtils.openAMapNavi2(latitude: latitude, longitude: longitude);
        }
        if (str == '百度(JhMapUtils)') {
          JhMapUtils.openBaiduMapNavi(dLatitude: latitude, dLongitude: longitude);
        }
        if (str == '腾讯(JhMapUtils)') {
          JhMapUtils.openTencentMapNavi(dLatitude: latitude, dLongitude: longitude);
        }
        if (str == '三方库跳转高德(map_launcher)') {
          _gotoMap();
        }
        if (str == '三方库弹出地图列表(map_launcher)') {
          _openMapsSheet(context);
        }
      },
    );
  }

  _gotoMap() async {
    // Get list of installed maps and launch first
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
    // [
    //   AvailableMap{
    //   mapName: GoogleMaps,
    //   mapType: google
    // },
    //   AvailableMap{
    //   mapName: Amap,
    //   mapType: amap
    // },
    //   AvailableMap{
    //   mapName: BaiduMaps,
    //   mapType: baidu
    // },
    //   AvailableMap{
    //   mapName: Tencent(QQMaps),
    //   mapType: tencent
    // }
    // ]

    // await availableMaps.first.showMarker(
    //   coords: Coords(latitude, longitude),
    //   title: "Ocean Beach",
    // );
    // await availableMaps[1].showMarker(
    //   coords: Coords(latitude, longitude),
    //   title: "Ocean Beach",
    // );

    // Check if map is installed and launch it #
    var canIn = await MapLauncher.isMapAvailable(MapType.amap);
    print('canIn: $canIn');
    if (canIn == false) {
      JhProgressHUD.showText('无法跳转,高德地图未安装');
      return;
    }

    if (await MapLauncher.isMapAvailable(MapType.amap) == true) {
      await MapLauncher.showMarker(
        mapType: MapType.amap,
        coords: Coords(latitude, longitude),
        title: 'title',
        description: 'description',
      );
    }
  }

  _openMapsSheet(context) async {
    try {
      const title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isEmpty) {
        JhProgressHUD.showText('无法跳转,未安装地图');
        return;
      }
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(coords: Coords(latitude, longitude), title: title),
                      title: Text(map.mapName),
                      leading: const Icon(Icons.map, size: 30),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
