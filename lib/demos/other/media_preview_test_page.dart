import 'package:flutter/material.dart';
import '/jh_common/utils/jh_common_utils.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/widgets/jh_bottom_sheet.dart';
import '/jh_common/widgets/jh_media_browser.dart';
import '/base_appbar.dart';

final List<JhMediaItem> dataArr = [
  JhMediaItem(url: 'https://picsum.photos/id/1005/600/800', type: JhMediaType.Image),
  JhMediaItem(url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://picsum.photos/id/1011/600/800', type: JhMediaType.Image),
  JhMediaItem(url: 'https://www.w3school.com.cn/example/html5/mov_bbb.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://picsum.photos/id/1012/600/800', type: JhMediaType.Image),
  JhMediaItem(url: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/uni-app-video-courses.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://v-cdn.zjol.com.cn/280423.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://v-cdn.zjol.com.cn/280430.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'https://v-cdn.zjol.com.cn/280538.mp4', type: JhMediaType.Video),
  JhMediaItem(url: 'http://usdoc.cn/vw/新建文本文档v1.txt', type: JhMediaType.Other),
];

final List<String> dataArr2 = [
  'https://picsum.photos/id/1005/600/800',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://picsum.photos/id/1011/600/800',
  'https://www.w3school.com.cn/example/html5/mov_bbb.mp4',
  'https://picsum.photos/id/1012/600/800',
  'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/uni-app-video-courses.mp4',
  'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4',
  'https://v-cdn.zjol.com.cn/280423.mp4',
  'https://v-cdn.zjol.com.cn/280430.mp4',
  'https://v-cdn.zjol.com.cn/280538.mp4',
  'http://usdoc.cn/vw/新建文本文档v1.txt'
];

class MediaPreviewTestPage extends StatelessWidget {
  const MediaPreviewTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('图片/视频预览'),
      body: _body(),
    );
  }

  _body() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: dataArr.length,
      itemBuilder: (BuildContext context, int index) {
        var item = dataArr[index];
        return ListTile(
          leading: Icon(item.type == JhMediaType.Video ? Icons.videocam : (item.type == JhMediaType.Image ? Icons.image : Icons.insert_drive_file)),
          title: Text("点击查看第 ${index + 1} 项"),
          onTap: () {
            JhMediaBrowser.show(
              context,
              data: dataArr,
              index: index,
              useChewie: JhCommonUtils.getRandomInt(0, 1) == 0,
              onLongPress: (int index, dynamic mediaArr) {
                print('长按回调: 当前索引 $index, 图片数组长度 ${mediaArr}');
                JhBottomSheet.showText(context, dataArr: ['保存'], clickCallback: (index, str) {});
              },
            );
          },
        );
      },
    );
  }
}
