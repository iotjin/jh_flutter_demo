import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/jh_common/widgets/jh_text_list.dart';
import 'package:jh_flutter_demo/base_appbar.dart';

class NavTestPage extends StatelessWidget {
  final List titleData = [
    "nav-只有title",
    "nav-左侧返回，右侧文字",
    "nav-左侧返回，右侧图片",
    "nav-左侧自定义右侧文字",
    "nav-设置透明背景色",
    '渐变导航条'
  ];

  @override
  Widget build(BuildContext context) {
    return JhTextList(
        title: "NavTest",
        dataArr: titleData,
        callBack: (index, str) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav1()))); //普通路由
          }
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav2()))); //普通路由
          }
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav3()))); //普通路由
          }
          if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav4()))); //普通路由
          }
          if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav5()))); //普通路由
          }
          if (index == 5) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_nav6()))); //普通路由
          }
        });
  }
}

class _nav1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context,
        "微信1",
      ),
      body: RaisedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _nav2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "微信", rightText: "发布",
//          rightImgPath: "assets/images/search.png",
          rightItemCallBack: () {
        print("点击右侧");
      }, backCallBack: () {
        print("点击左侧");
      }),
      body: RaisedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _nav3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "微信",
//          rightText: "发布",
          rightImgPath: "assets/images/search.png", rightItemCallBack: () {
        print("点击右侧");
      }, backCallBack: () {
        print("点击左侧");
      }),
      body: RaisedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _nav4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(context, "微信",
//          leftItem: Container(),
          leftItem: IconButton(
            icon: Image.asset(
              'assets/images/search.png',
              width: 22,
              height: 22,
            ),
            onPressed: () {
              print("search");
            },
          ),
          rightText: "发布",
//          rightImgPath: "assets/images/search.png",
          rightItemCallBack: () {
        print("点击右侧");
      }, leftItemCallBack: () {
        print("点击左侧");
      }),
      body: RaisedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _nav5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context, "透明背景色", rightText: "发布",
            rightItemCallBack: () {
          print("点击右侧");
        }, backgroundColor: Colors.transparent),
        body: Container(
          child: RaisedButton(
            child: Text("返回"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}

class _nav6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backGradientAppBar(
          context,
          "渐变导航条",
          rightText: "发布",
          rightItemCallBack: () {
            print("点击右侧");
          },
        ),
        body: Container(
          child: RaisedButton(
            child: Text("返回"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
