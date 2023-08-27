import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/project/configs/project_config.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({Key? key}) : super(key: key);

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();
  }

  _init() {
    _animationController1 = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController2 = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  _startAnimation1() {
    _animationController1
      ..reset()
      ..forward();
  }

  _startAnimation2() {
    _animationController2
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('Lottie 动画'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: [
        // Load a Lottie file from your assets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/首页.json', width: 50, height: 50),
            Lottie.asset('assets/lottie/星球.json', width: 65, height: 65),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _startAnimation1(),
              child: Lottie.asset(
                'assets/lottie/首页.json',
                width: 50,
                height: 50,
                controller: _animationController1,
                onLoaded: (composition) => _startAnimation1(),
              ),
            ),
            GestureDetector(
              onTap: () => _startAnimation2(),
              child: Lottie.asset(
                'assets/lottie/星球.json',
                width: 65,
                height: 65,
                controller: _animationController2,
                onLoaded: (composition) => _startAnimation2(),
              ),
            ),
          ],
        ),

        Lottie.asset('assets/lottie/Aniki Hamster.json', height: 200),

        // Load a Lottie file from a remote url
        Lottie.network('https://assets5.lottiefiles.com/packages/lf20_0LNPii4uOv.json'),
      ],
    );
  }
}
