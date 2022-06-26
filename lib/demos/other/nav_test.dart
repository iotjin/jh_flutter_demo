import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/base_appbar.dart';

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
                MaterialPageRoute(builder: (context) => (_Nav1()))); // 普通路由
          }
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_Nav2()))); // 普通路由
          }
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_Nav3()))); // 普通路由
          }
          if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_Nav4()))); // 普通路由
          }
          if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_Nav5()))); // 普通路由
          }
          if (index == 5) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (_Nav6()))); // 普通路由
          }
        });
  }
}

class _Nav1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context,
        "微信1",
      ),
      body: ElevatedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav2 extends StatelessWidget {
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
      body: ElevatedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav3 extends StatelessWidget {
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
      body: ElevatedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav4 extends StatelessWidget {
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
      body: ElevatedButton(
        child: Text("返回"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context, "透明背景色", rightText: "发布",
            rightItemCallBack: () {
          print("点击右侧");
        }, backgroundColor: Colors.transparent),
        body: Container(
          child: ElevatedButton(
            child: Text("返回"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}

class _Nav6 extends StatelessWidget {
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
          child: ElevatedButton(
            child: Text("返回"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
