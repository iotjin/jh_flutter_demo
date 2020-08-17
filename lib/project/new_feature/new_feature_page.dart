import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:jh_flutter_demo/jh_common/utils/jh_screen_utils.dart';
import 'package:jh_flutter_demo/project/login/pages/login_page.dart';

class NewFeaturePage extends StatefulWidget {
  @override
  _NewFeaturePageState createState() => _NewFeaturePageState();
}

class _NewFeaturePageState extends State<NewFeaturePage> {
//  List imgList = [
//    "https://gitee.com/iotjh/Picture/raw/master/cat.png",
//    "https://gitee.com/iotjh/Picture/raw/master/lufei2.png",
//    "https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg",
//  ];
  List _imgList = [
    "assets/images/newFeature/newFeature_0.jpeg",
    "assets/images/newFeature/newFeature_1.jpeg",
    "assets/images/newFeature/newFeature_2.jpeg",
    "assets/images/newFeature/newFeature_3.jpeg",
  ];

  List<Widget> _imgWidgets = [];
  var _index = 0; //小圆点使用

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _imgList.forEach((value) {
//      print(value);
      _imgWidgets.add(Image.asset(value,
          fit: BoxFit.fill, width: double.infinity, height: double.infinity));
//      _imgWidgets.add(Image.network(value,
//          fit: BoxFit.fill, width: double.infinity, height: double.infinity));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: backAppBar(context, '新特性'),
        body: _buildNewFeatureWidget());
  }

  Widget _buildNewFeatureWidget() {
    return Swiper(
        scrollDirection: Axis.horizontal,
        itemCount: _imgWidgets.length,
        autoplay: false,
        loop: false,
        onIndexChanged: (index) {
//          print('滚动到：$index');
          setState(() {
            _index = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          if (index != _imgWidgets.length - 1) {
            return _imgWidgets[index];
          } else {
            return Stack(
              alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
              children: <Widget>[
                _imgWidgets[index],
                Positioned(
                    bottom: JhScreenUtils.bottomSafeHeight + 50,
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/images/newFeature/start-now.jpg",
                        width: 180,
                        height: 50,
                      ),
                      onTap: () {
                        _jumpMain();
                      },
                    )),
              ],
            );
          }
        },
        // 点击事件 onTap
        onTap: (index) {
          print('点击了第${index}');
        },
        // 分页指示器
        pagination: SwiperPagination(
            // 位置 Alignment.bottomCenter 底部中间
            alignment: Alignment.bottomCenter,
            // 距离调整
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            builder: DotSwiperPaginationBuilder(
                space: 5,
                size: _index == _imgWidgets.length - 1 ? 0 : 10,
                activeSize: _index == _imgWidgets.length - 1 ? 0 : 12,
                color: Colors.grey,
                activeColor: Colors.white)),
        // 页面控制器 左右翻页按钮
//          control: new SwiperControl(color: Colors.pink),
      );
  }

  _jumpMain() {
    print('跳转主界面');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => (LoginPage())));
  }
}
