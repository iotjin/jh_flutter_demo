import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '/project/configs/project_config.dart';

class WavePage extends StatelessWidget {
  const WavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('波浪动画'),
      body: _body(),
    );
  }

  _body() {
    const backgroundColor = Color(0xFFF15BB5);

    const colors = [Color(0xFFFEE440), Color(0xFF00BBF9)];

    const durations = [3000, 6000];

    const heightPercentages = [0.65, 0.66];

    var waveView = WaveWidget(
      config: CustomConfig(
        colors: colors,
        durations: durations,
        heightPercentages: heightPercentages,
      ),
      backgroundColor: backgroundColor,
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );

    return waveView;
  }
}
