import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '/base_appbar.dart';
import 'data.dart';
// import 'echarts_data.dart';

class GraphicBarPage extends StatefulWidget {
  const GraphicBarPage({Key? key}) : super(key: key);

  @override
  State<GraphicBarPage> createState() => _GraphicBarPageState();
}

class _GraphicBarPageState extends State<GraphicBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('Graphic - 柱状图'),
      body: _body(),
    );
  }
}

Widget _body() {
  return ListView(
    children: <Widget>[
      _initHeader('柱状图 - 点击无提示框'),
      _initBarChart1(),
      _initHeader('柱状图 - 设置柱状图文字，点击显示提示框'),
      _initBarChart2(),
      _initHeader('柱状图 - 背景色'),
      _initBarChart3(),
      _initHeader('柱状图 - 横向渐变背景色'),
      _initBarChart4(),
      _initHeader('多个柱状图 - 自定义图例'),
      _initBarChart5(),
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

Widget _initBarChart1() {
  return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: const [
          {'genre': 'Sports', 'sold': 275},
          {'genre': 'Strategy', 'sold': 115},
          {'genre': 'Action', 'sold': 120},
          {'genre': 'Shooter', 'sold': 350},
          {'genre': 'Other', 'sold': 150},
        ],
        // 通过这个字段进行数据转换
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
          ),
        },
        marks: [IntervalMark()],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
      ));
}

Widget _initBarChart2() {
  return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: basicData,
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
          ),
        },
        marks: [
          IntervalMark(
            // 文字设置
            label: LabelEncode(
              encoder: (tuple) => Label(
                  tuple['sold'].toString(), LabelStyle(textStyle: const TextStyle(fontSize: 16, color: Colors.red))),
            ),
            elevation: ElevationEncode(value: 0, updaters: {
              'tap': {true: (_) => 5}
            }),
            color: ColorEncode(value: Defaults.primaryColor, updaters: {
              'tap': {false: (color) => color.withAlpha(100)}
            }),
          )
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        // 提示框
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(), // 准星
      ));
}

Widget _initBarChart3() {
  return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: basicData,
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
          ),
        },
        marks: [
          IntervalMark(
            label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
            elevation: ElevationEncode(value: 0, updaters: {
              'tap': {true: (_) => 5}
            }),
            // 背景色默认橙色，选中红色
            color: ColorEncode(value: Colors.orange, updaters: {
              'tap': {true: (color) => Colors.red}
            }),
          )
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        // 提示框
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(), // 准星
      ));
}

Widget _initBarChart4() {
  return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      height: 300,
      // color: Colors.yellow,
      child: Chart(
        data: basicData,
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
          ),
        },
        marks: [
          IntervalMark(
            label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
            elevation: ElevationEncode(value: 1, updaters: {
              'tap': {true: (_) => 5}
            }),
            // elevation: ElevationEncode(value: 1),
            gradient: GradientEncode(
                value: const LinearGradient(colors: [
                  Color(0x8883bff6),
                  Color(0x88188df0),
                  Color(0xcc188df0),
                ], stops: [
                  0,
                  0.5,
                  1
                ]),
                updaters: {
                  'tap': {
                    true: (_) => const LinearGradient(colors: [
                          Color(0xee83bff6),
                          Color(0xee3f78f7),
                          Color(0xff3f78f7),
                        ], stops: [
                          0,
                          0.7,
                          1
                        ])
                  }
                }),
          )
        ],
        // 设置横向
        coord: RectCoord(transposed: true),
        // 设置X轴
        axes: [
          Defaults.verticalAxis
            ..line = Defaults.strokeStyle
            ..grid = null,
          Defaults.horizontalAxis
            ..line = null
            ..grid = Defaults.strokeStyle,
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        // 提示框
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(), // 准星
      ));
}

Widget _initBarChart5() {
  return Container(
      margin: const EdgeInsets.all(10),
      height: 300,
      width: double.infinity,
      // color: Colors.yellow,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 40),
        data: adjustData,
        variables: {
          'index': Variable(
            accessor: (Map map) => map['index'].toString(),
          ),
          'type': Variable(
            accessor: (Map map) => map['type'] as String,
          ),
          'value': Variable(
            accessor: (Map map) => map['value'] as num,
          ),
        },
        marks: [
          IntervalMark(
            position: Varset('index') * Varset('value') / Varset('type'),
            color: ColorEncode(variable: 'type', values: Defaults.colors10),
            // modifiers: [StackModifier()],
            // modifiers: [SymmetricModifier()],

            size: SizeEncode(value: 8),
            modifiers: [DodgeModifier(ratio: 0.15)],

            // size: SizeAttr(value: 2),
            // modifiers: [DodgeSizeModifier()],
          )
        ],
        axes: [
          Defaults.horizontalAxis..tickLine = TickLine(),
          Defaults.verticalAxis,
        ],
        selections: {
          'tap': PointSelection(
            variable: 'index',
          )
        },
        tooltip: TooltipGuide(multiTuples: true),
        crosshair: CrosshairGuide(),
        annotations: [
          CustomAnnotation(
            renderer: (_, size) => [
              CircleElement(
                center: const Offset(25, 290),
                radius: 5,
                style: PaintStyle(fillColor: Defaults.colors10[0]),
              )
            ],
            anchor: (p0) => const Offset(0, 0),
          ),
          TagAnnotation(
            label: Label('Email', LabelStyle(textStyle: Defaults.textStyle, align: Alignment.centerRight)),
            anchor: (size) => const Offset(34, 290),
          ),
          CustomAnnotation(
            renderer: (_, size) => [
              CircleElement(
                center: Offset(25 + size.width / 5, 290),
                radius: 5,
                style: PaintStyle(fillColor: Defaults.colors10[1]),
              )
            ],
            anchor: (p0) => const Offset(0, 0),
          ),
          TagAnnotation(
            label: Label('Affiliate', LabelStyle(textStyle: Defaults.textStyle, align: Alignment.centerRight)),
            anchor: (size) => Offset(34 + size.width / 5, 290),
          ),
          CustomAnnotation(
            renderer: (_, size) => [
              CircleElement(
                center: Offset(25 + size.width / 5 * 2, 290),
                radius: 5,
                style: PaintStyle(fillColor: Defaults.colors10[2]),
              )
            ],
            anchor: (p0) => const Offset(0, 0),
          ),
          TagAnnotation(
            label: Label('Video', LabelStyle(textStyle: Defaults.textStyle, align: Alignment.centerRight)),
            anchor: (size) => Offset(34 + size.width / 5 * 2, 290),
          ),
          CustomAnnotation(
            renderer: (_, size) => [
              CircleElement(
                center: Offset(25 + size.width / 5 * 3, 290),
                radius: 5,
                style: PaintStyle(fillColor: Defaults.colors10[3]),
              )
            ],
            anchor: (p0) => const Offset(0, 0),
          ),
          TagAnnotation(
            label: Label('Direct', LabelStyle(textStyle: Defaults.textStyle, align: Alignment.centerRight)),
            anchor: (size) => Offset(34 + size.width / 5 * 3, 290),
          ),
          CustomAnnotation(
            renderer: (_, size) => [
              CircleElement(
                center: Offset(25 + size.width / 5 * 4, 290),
                radius: 5,
                style: PaintStyle(fillColor: Defaults.colors10[4]),
              )
            ],
            anchor: (p0) => const Offset(0, 0),
          ),
          TagAnnotation(
            label: Label('Search', LabelStyle(textStyle: Defaults.textStyle, align: Alignment.centerRight)),
            anchor: (size) => Offset(34 + size.width / 5 * 4, 290),
          ),
        ],
      ));
}

const _kBaseGroupPaddingHorizontal = 32.0;
const _kMinBarSize = 4.0;

/// Changes the position of marks while also updating their width to match
/// the number of marks in a single band. Useful for bar charts when the
/// width of the bars can be dynamic.
@immutable
class DodgeSizeModifier extends Modifier {
  @override
  AttributesGroups modify(AttributesGroups groups, Map<String, ScaleConv<dynamic, num>> scales, AlgForm form,
      CoordConv coord, Offset origin) {
    final xField = form.first[0];
    final band = (scales[xField]! as DiscreteScaleConv).band;

    final ratio = 1 / groups.length;
    final numGroups = groups.length;
    final groupHorizontalPadding = _kBaseGroupPaddingHorizontal / numGroups;
    final invertedGroupPaddingHorizontal = coord.invertDistance(groupHorizontalPadding, Dim.x);

    final effectiveBand = band - 2 * invertedGroupPaddingHorizontal;

    final maxWidth = coord.convert(const Offset(1, 0)).dx;
    final maxWidthInBand = effectiveBand * maxWidth;
    final maxWidthPerAttributes = maxWidthInBand / numGroups;
    final barHorizontalPadding = groupHorizontalPadding / 2;
    final size = max(maxWidthPerAttributes - barHorizontalPadding, _kMinBarSize);

    final bias = ratio * effectiveBand;

    // Negatively shift half of the total bias.
    var accumulated = -bias * (numGroups + 1) / 2;

    final AttributesGroups rst = [];
    for (final group in groups) {
      final groupRst = <Attributes>[];
      for (final attributes in group) {
        final oldPosition = attributes.position;

        groupRst.add(Attributes(
          index: attributes.index,
          tag: attributes.tag,
          position: oldPosition
              .map(
                (point) => Offset(point.dx + accumulated + bias, point.dy),
              )
              .toList(),
          shape: attributes.shape,
          color: attributes.color,
          gradient: attributes.gradient,
          elevation: attributes.elevation,
          label: attributes.label,
          size: size,
        ));
      }
      rst.add(groupRst);
      accumulated += bias;
    }

    return rst;
  }

  @override
  bool equalTo(Object other) {
    return super == other;
  }
}
