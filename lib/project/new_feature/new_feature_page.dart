// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_swiper_view.dart';
import '/project/login/pages/login_page.dart';

class NewFeaturePage extends StatefulWidget {
  const NewFeaturePage({Key? key}) : super(key: key);

  @override
  State<NewFeaturePage> createState() => _NewFeaturePageState();
}

class _NewFeaturePageState extends State<NewFeaturePage> {
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _imgList.forEach((imgURL) {
        ImageProvider image = imgURL.startsWith('http') ? NetworkImage(imgURL) : AssetImage(imgURL) as ImageProvider;
        precacheImage(image, context);
      });
    });
    super.initState();
  }

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
    print('跳转主界面');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => (const LoginPage())));
  }
}
