import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_pulse_animation_view.dart';
import '/jh_common/widgets/jh_pulse_animation_view2.dart';
import '/jh_common/widgets/jh_scale_animation_view.dart';
import '/jh_common/widgets/jh_scale_animation_view2.dart';
import '/jh_common/widgets/jh_scrollview.dart';
import '/jh_common/widgets/jh_shake_animation_view.dart';
import '/project/configs/project_config.dart';

class AnimationTestPage extends StatefulWidget {
  const AnimationTestPage({Key? key}) : super(key: key);

  @override
  State<AnimationTestPage> createState() => _AnimationTestPageState();
}

class _AnimationTestPageState extends State<AnimationTestPage> {
  bool _isAnimating1 = true;
  bool _isAnimating2 = false;
  bool _isAnimating3 = false;
  bool _isAnimating4 = false;
  bool _isAnimating5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('抖动动画'),
      body: _body(),
    );
  }

  _body() {
    return JhScrollView(
      child: Center(
        child: Column(
          children: [
            // JhPulseAnimationView
            const Text('动画效果一'),
            const SizedBox(height: 20),
            const Text('点击child自身触发动画'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhPulseAnimationView(
                  child: _child1(),
                ),
                JhPulseAnimationView(
                  child: _child2('JhPulseAnimationView'),
                ),
                JhPulseAnimationView(
                  child: _child3(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('点击按钮或child自身触发动画'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _isAnimating1 = true;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhPulseAnimationView(
                  child: _child1(),
                  isAnimating: _isAnimating1,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating1 = false;
                    });
                  },
                ),
                JhPulseAnimationView(
                  child: _child2('JhPulseAnimationView'),
                  isAnimating: _isAnimating1,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating1 = false;
                    });
                  },
                ),
                JhPulseAnimationView(
                  child: _child3(),
                  isAnimating: _isAnimating1,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating1 = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            // JhShakeAnimationView
            const Text('动画效果二'),
            const SizedBox(height: 20),
            const Text('点击child自身触发动画'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhShakeAnimationView(
                  child: _child1(),
                ),
                JhShakeAnimationView(
                  child: _child2('JhShakeAnimationView'),
                ),
                JhShakeAnimationView(
                  child: _child3(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('点击按钮或child自身触发动画'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _isAnimating2 = true;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhShakeAnimationView(
                  direction: ShakeDirection.vertical,
                  child: _child1(),
                  isAnimating: _isAnimating2,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating2 = false;
                    });
                  },
                ),
                JhShakeAnimationView(
                  direction: ShakeDirection.vertical,
                  child: _child2('JhShakeAnimationView'),
                  isAnimating: _isAnimating2,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating2 = false;
                    });
                  },
                ),
                JhShakeAnimationView(
                  direction: ShakeDirection.vertical,
                  child: _child3(),
                  isAnimating: _isAnimating2,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating2 = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            // JhScaleAnimationView
            const Text('动画效果三'),
            const SizedBox(height: 20),
            const Text('点击child自身触发动画'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhScaleAnimationView(
                  child: _child1(),
                ),
                JhScaleAnimationView(
                  child: _child2('JhScaleAnimationView'),
                ),
                JhScaleAnimationView(
                  child: _child3(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('点击按钮或child自身触发动画'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _isAnimating3 = true;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhScaleAnimationView(
                  child: _child1(),
                  isAnimating: _isAnimating3,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating3 = false;
                    });
                  },
                ),
                JhScaleAnimationView(
                  child: _child2('JhScaleAnimationView'),
                  isAnimating: _isAnimating3,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating3 = false;
                    });
                  },
                ),
                JhScaleAnimationView(
                  child: _child3(),
                  isAnimating: _isAnimating3,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating3 = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            // JhScaleAnimationView2
            const Text('动画效果四'),
            const SizedBox(height: 20),
            const Text('点击child自身触发动画'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhScaleAnimationView2(
                  child: _child1(),
                ),
                JhScaleAnimationView2(
                  child: _child2('JhScaleAnimationView2'),
                ),
                JhScaleAnimationView2(
                  child: _child3(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('点击按钮或child自身触发动画'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _isAnimating4 = true;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhScaleAnimationView2(
                  child: _child1(),
                  isAnimating: _isAnimating4,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating4 = false;
                    });
                  },
                ),
                JhScaleAnimationView2(
                  child: _child2('JhScaleAnimationView2'),
                  isAnimating: _isAnimating4,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating4 = false;
                    });
                  },
                ),
                JhScaleAnimationView2(
                  child: _child3(),
                  isAnimating: _isAnimating4,
                  onCompleted: () {
                    setState(() {
                      // 动画完成改变状态
                      _isAnimating4 = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),

            // JhPulseAnimationView2
            const Text('动画效果五'),
            const SizedBox(height: 20),
            const Text('点击按钮触发动画'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _isAnimating5 = !_isAnimating5;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JhPulseAnimationView2(
                  child: _child1(),
                  animate: _isAnimating5,
                ),
                JhPulseAnimationView2(
                  child: _child2('JhPulseAnimationView2'),
                  animate: _isAnimating5,
                ),
                JhPulseAnimationView2(
                  child: _child3(),
                  animate: _isAnimating5,
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  _child1() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.yellow,
      child: const Center(child: Text('child', style: TextStyle(color: Colors.red))),
    );
  }

  _child2(text) {
    return Text(text);
  }

  _child3() {
    return Image.asset('assets/images/tab/nav_tab_4_on.png', width: 50);
  }
}
