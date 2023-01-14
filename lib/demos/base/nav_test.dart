// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/base_appbar.dart';

final List titleData = [
  'nav-只有title',
  'nav-左侧返回，右侧文字',
  'nav-左侧返回(拦截点击事件)，右侧图片',
  'nav-左侧自定义右侧文字',
  'nav-设置透明背景色',
  'nav-渐变导航条',
  'nav-多行标题',
];

class NavTestPage extends StatelessWidget {
  const NavTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
        title: 'BaseAppBar',
        dataArr: titleData,
        callBack: (index, str) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav1()))); // 普通路由
          }
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav2()))); // 普通路由
          }
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav3()))); // 普通路由
          }
          if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav4()))); // 普通路由
          }
          if (index == 4) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav5()))); // 普通路由
          }
          if (index == 5) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav6()))); // 普通路由
          }
          if (index == 6) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (_Nav7()))); // 普通路由
          }
        });
  }
}

class _Nav1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        '微信1',
        leftWidget: Container(),
      ),
      body: ElevatedButton(
        child: const Text('返回'),
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
      appBar: BaseAppBar(
        '微信',
        rightText: '发布',
        rightItemCallBack: () {
          JhProgressHUD.showText('点击右侧');
          print('点击右侧');
        },
      ),
      body: ElevatedButton(
        child: const Text('返回'),
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
      appBar: BaseAppBar('nav-左侧返回(拦截点击事件)，右侧图片', rightImgPath: 'assets/images/search.png', rightItemCallBack: () {
        JhProgressHUD.showText('点击右侧');
        print('点击右侧');
      }, leftItemCallBack: () {
        JhProgressHUD.showText('点击左侧');
        print('点击左侧');
      }),
      body: ElevatedButton(
        child: const Text('返回'),
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
      appBar: BaseAppBar('微信',
          leftWidget: IconButton(
            icon: Image.asset('assets/images/search.png', width: 22, height: 22),
            onPressed: () {
              JhProgressHUD.showText('点击search');
              print('search');
            },
          ),
          rightText: '发布', rightItemCallBack: () {
        JhProgressHUD.showText('点击右侧');
        print('点击右侧');
      }, leftItemCallBack: () {
        JhProgressHUD.showText('点击左侧');
        print('点击左侧');
      }),
      body: ElevatedButton(
        child: const Text('返回'),
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
      appBar: BaseAppBar('透明背景色', rightText: '发布', rightItemCallBack: () {
        JhProgressHUD.showText('点击右侧');
        print('点击右侧');
      }, bgColor: Colors.transparent),
      body: ElevatedButton(
        child: const Text('返回'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        '渐变导航条',
        rightText: '发布',
        rightItemCallBack: () {
          JhProgressHUD.showText('点击右侧');
          print('点击右侧');
        },
      ),
      body: ElevatedButton(
        child: const Text('返回'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _Nav7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        '微信1',
        titleWidget: TwoLinesTitle(title: '主标题', subtitle: '这是副标题'),
      ),
      body: ElevatedButton(
        child: const Text('返回'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
