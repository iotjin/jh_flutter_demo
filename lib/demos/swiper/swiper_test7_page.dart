import 'package:flutter/material.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_swiper_view.dart';

class SwiperTest7Page extends StatefulWidget {
  const SwiperTest7Page({Key? key}) : super(key: key);

  @override
  State<SwiperTest7Page> createState() => _SwiperTest7PageState();
}

class _SwiperTest7PageState extends State<SwiperTest7Page> {
  // final List _imgList = [
  //   'https://gitee.com/iotjh/Picture/raw/master/cat.png',
  //   'https://gitee.com/iotjh/Picture/raw/master/lufei2.png',
  //   'https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg',
  // ];
  final List _imgList = [
    'assets/images/newFeature/newFeature_0.jpeg',
    'assets/images/newFeature/newFeature_1.jpeg',
    'assets/images/newFeature/newFeature_2.jpeg',
    'assets/images/newFeature/newFeature_3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return JhSwiperView(
      data: _imgList,
      height: JhScreenUtils.screenHeight,
      viewportFraction: 1.0,
      aspectRatio: 16 / 9,
      radius: 0,
      loop: false,
      autoPlay: false,
      enlargeCenterPage: false,
      isShowIndicator: true,
      isLastHiddenIndicator: true,
      indicatorBottomMargin: 50,
      itemBuilder: (BuildContext context, int index) {
        if (index != _imgList.length - 1) {
          return _itemWidget(_imgList[index]);
        } else {
          return Stack(
            alignment: Alignment.center, // 指定未定位或部分定位widget的对齐方式
            children: <Widget>[
              _itemWidget(_imgList[index]),
              Positioned(
                bottom: JhScreenUtils.bottomSafeHeight + 50,
                child: GestureDetector(
                  child: Image.asset('assets/images/newFeature/start-now.jpg', width: 180, height: 50),
                  onTap: () => _onClickBtn(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  _itemWidget(imgURL) {
    // return Image.asset(imgURL, fit: BoxFit.fill, width: double.infinity, height: double.infinity);

    ImageProvider picture;
    if (imgURL.startsWith('http')) {
      picture = NetworkImage(imgURL);
    } else {
      picture = AssetImage(imgURL);
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: picture, fit: BoxFit.fill),
        ),
      ),
    );
  }

  _onClickBtn() {
    JhProgressHUD.showText('点击按钮');
    Navigator.pop(context);
  }
}
