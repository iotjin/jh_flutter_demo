// ignore_for_file: close_sinks

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '/base_appbar.dart';
import 'data.dart';
import 'echarts_data.dart';

class GraphicLinePage extends StatefulWidget {
  const GraphicLinePage({Key? key}) : super(key: key);

  @override
  State<GraphicLinePage> createState() => _GraphicLinePageState();
}

class _GraphicLinePageState extends State<GraphicLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('Graphic - 折线图'),
      body: _body(),
    );
  }
}

Widget _body() {
  return ListView(
    children: <Widget>[
      _initHeader('折线图'),
      _initLineChart1(),
      _initHeader('多个折线图'),
      _initLineChart2(),
      _initHeader('折线图添加背景区域'),
      _initLineChart3(),
      _initHeader('混合折线图'),
      _initLineChart4_1(),
      _initLineChart4_2(),
    ],
  );
}

Widget _initHeader(title) {
  return Container(
    height: 50,
    width: double.infinity,
    color: Colors.yellow,
    alignment: Alignment.center,
    child: Text(title),
  );
}

Widget _initLineChart1() {
  return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: invalidData,
        variables: {
          'Date': Variable(
            accessor: (Map map) => map['Date'] as String,
            scale: OrdinalScale(tickCount: 5),
          ),
          'Close': Variable(
            accessor: (Map map) => (map['Close'] ?? double.nan) as num,
          ),
        },
        marks: [
          AreaMark(
            shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
            color: ColorEncode(value: Defaults.colors10.first.withAlpha(80)),
          ),
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 0.5),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {
          'touchMove': PointSelection(
            on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
            dim: Dim.x,
          )
        },
        tooltip: TooltipGuide(
          followPointer: [false, true],
          align: Alignment.topLeft,
          offset: const Offset(-20, -20),
        ),
        crosshair: CrosshairGuide(followPointer: [false, true]),
      ));
}

Widget _initLineChart2() {
  return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: lineMarkerData,
        variables: {
          'day': Variable(
            accessor: (Map datum) => datum['day'] as String,
            scale: OrdinalScale(inflate: true),
          ),
          'value': Variable(
            accessor: (Map datum) => datum['value'] as num,
            scale: LinearScale(
              max: 15,
              min: -3,
              tickCount: 7,
              formatter: (v) => '${v.toInt()} ℃',
            ),
          ),
          'group': Variable(
            accessor: (Map datum) => datum['group'] as String,
          ),
        },
        marks: [
          LineMark(
            position: Varset('day') * Varset('value') / Varset('group'),
            color: ColorEncode(
              variable: 'group',
              values: [
                const Color(0xff5470c6),
                const Color(0xff91cc75),
              ],
            ),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {
          'tooltipMouse': PointSelection(on: {
            GestureType.hover,
          }, devices: {
            PointerDeviceKind.mouse
          }, variable: 'day', dim: Dim.x),
          'tooltipTouch': PointSelection(
              on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
              devices: {PointerDeviceKind.touch},
              variable: 'day',
              dim: Dim.x),
        },
        tooltip: TooltipGuide(
          followPointer: [true, true],
          align: Alignment.topLeft,
          variables: ['group', 'value'],
        ),
        crosshair: CrosshairGuide(
          followPointer: [false, true],
        ),
        annotations: [
          LineAnnotation(
            dim: Dim.y,
            value: 11.14,
            style: PaintStyle(
              strokeColor: const Color(0xff5470c6).withAlpha(100),
              dash: [2],
            ),
          ),
          LineAnnotation(
            dim: Dim.y,
            value: 1.57,
            style: PaintStyle(
              strokeColor: const Color(0xff91cc75).withAlpha(100),
              dash: [2],
            ),
          ),
          CustomAnnotation(
              renderer: (offset, _) =>
                  [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff5470c6)))],
              values: ['Wed', 13]),
          CustomAnnotation(
              renderer: (offset, _) =>
                  [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff5470c6)))],
              values: ['Sun', 9]),
          CustomAnnotation(
              renderer: (offset, _) =>
                  [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff91cc75)))],
              values: ['Tue', -2]),
          CustomAnnotation(
              renderer: (offset, _) =>
                  [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff91cc75)))],
              values: ['Thu', 5]),
          TagAnnotation(
            label: Label('13', LabelStyle(textStyle: Defaults.textStyle, offset: const Offset(0, -10))),
            values: ['Wed', 13],
          ),
          TagAnnotation(
            label: Label('9', LabelStyle(textStyle: Defaults.textStyle, offset: const Offset(0, -10))),
            values: ['Sun', 9],
          ),
          TagAnnotation(
            label: Label('-2', LabelStyle(textStyle: Defaults.textStyle, offset: const Offset(0, -10))),
            values: ['Tue', -2],
          ),
          TagAnnotation(
            label: Label('5', LabelStyle(textStyle: Defaults.textStyle, offset: const Offset(0, -10))),
            values: ['Thu', 5],
          ),
        ],
      ));
}

Widget _initLineChart3() {
  return Container(
    margin: const EdgeInsets.all(10),
    width: 350,
    height: 300,
    // color: Colors.yellow,
    child: Chart(
      data: lineMarkerData2,
      variables: {
        'time': Variable(
          accessor: (Map map) => map['time'] as String,
          scale: OrdinalScale(tickCount: 5),
          // scale: OrdinalScale(inflate: true, tickCount: 6),
        ),
        'value': Variable(
          accessor: (Map map) => (map['value'] ?? double.nan) as num,
          // scale: LinearScale(
          //   max: 800,
          //   min: 0,
          //   formatter: (v) => '${v.toInt()} W',
          // ),
        ),
      },
      marks: [
        LineMark(
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
        )
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {
        'tooltipMouse': PointSelection(on: {
          GestureType.hover,
        }, devices: {
          PointerDeviceKind.mouse
        }, dim: Dim.x),
        'tooltipTouch': PointSelection(
            on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
            devices: {PointerDeviceKind.touch},
            dim: Dim.x),
      },
      tooltip: TooltipGuide(
        followPointer: [true, true],
        align: Alignment.topLeft,
      ),
      crosshair: CrosshairGuide(
        followPointer: [false, true],
      ),
      annotations: [
        RegionAnnotation(
          values: ['07:30', '10:00'],
          color: const Color.fromARGB(120, 255, 173, 177),
        ),
        RegionAnnotation(
          values: ['17:30', '21:15'],
          color: const Color.fromARGB(120, 255, 173, 177),
        ),
      ],
    ),
  );
}

Widget _initLineChart4_1() {
  final priceVolumeStream = StreamController<GestureEvent>.broadcast();
  return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 0),
        rebuild: false,
        data: priceVolumeData,
        variables: {
          'time': Variable(
            accessor: (Map map) => map['time'] as String,
            scale: OrdinalScale(tickCount: 3),
          ),
          'end': Variable(
            accessor: (Map map) => map['end'] as num,
            scale: LinearScale(min: 5, tickCount: 5),
          ),
        },
        marks: [
          LineMark(
            size: SizeEncode(value: 1),
          )
        ],
        axes: [
          Defaults.horizontalAxis
            ..label = null
            ..line = null,
          Defaults.verticalAxis..gridMapper = (_, index, __) => index == 0 ? null : Defaults.strokeStyle,
        ],
        selections: {
          'touchMove': PointSelection(
            on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
            dim: Dim.x,
          )
        },
        crosshair: CrosshairGuide(
          followPointer: [true, false],
          styles: [
            PaintStyle(strokeColor: const Color(0xffbfbfbf), dash: [4, 2]),
            PaintStyle(strokeColor: const Color(0xffbfbfbf), dash: [4, 2]),
          ],
        ),
        gestureStream: priceVolumeStream,
      ));
}

Widget _initLineChart4_2() {
  final priceVolumeStream = StreamController<GestureEvent>.broadcast();
  return Container(
    margin: const EdgeInsets.only(top: 0),
    width: 350,
    height: 80,
    child: Chart(
      padding: (_) => const EdgeInsets.fromLTRB(40, 0, 10, 20),
      rebuild: false,
      data: priceVolumeData,
      variables: {
        'time': Variable(
          accessor: (Map map) => map['time'] as String,
          scale: OrdinalScale(tickCount: 3),
        ),
        'volume': Variable(
          accessor: (Map map) => map['volume'] as num,
          scale: LinearScale(min: 0),
        ),
      },
      marks: [
        IntervalMark(
          size: SizeEncode(value: 1),
        )
      ],
      axes: [
        Defaults.horizontalAxis,
      ],
      selections: {
        'touchMove': PointSelection(
          on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
          dim: Dim.x,
        )
      },
      crosshair: CrosshairGuide(
        followPointer: [true, false],
        styles: [
          PaintStyle(strokeColor: const Color(0xffbfbfbf), dash: [4, 2]),
          PaintStyle(strokeColor: const Color(0xffbfbfbf), dash: [4, 2]),
        ],
      ),
      gestureStream: priceVolumeStream,
    ),
  );
}
