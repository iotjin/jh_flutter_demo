import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '/project/configs/project_config.dart';
import 'data.dart';
// import 'echarts_data.dart';

class GraphicPiePage extends StatefulWidget {
  const GraphicPiePage({Key? key}) : super(key: key);

  @override
  State<GraphicPiePage> createState() => _GraphicPiePageState();
}

class _GraphicPiePageState extends State<GraphicPiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('Graphic - 饼图'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        _initHeader('饼图 - 点击无提示框'),
        _initPieChart1(),
        _initHeader('饼图 - 设置文字背景颜色，点击显示提示框'),
        _initPieChart2(),
        _initHeader('空心饼图 - 中间文字'),
        _initPieChart3(),
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

  Widget _initPieChart1() {
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
          transforms: [Proportion(variable: 'sold', as: 'percent')],
          elements: [
            IntervalElement(
              position: Varset('percent') / Varset('genre'),
              label: LabelAttr(
                encoder: (tuple) => Label(
                  tuple['sold'].toString(),
                  LabelStyle(style: Defaults.runeStyle),
                ),
              ),
              color: ColorAttr(variable: 'genre', values: Defaults.colors10),
              modifiers: [StackModifier()],
            )
          ],
          coord: PolarCoord(transposed: true, dimCount: 1),
        ));
  }

  Widget _initPieChart2() {
    return Container(
        margin: const EdgeInsets.all(10),
        width: 350,
        height: 300,
        // color: Colors.yellow,
        child: Chart(
          data: basicData,
          // 通过这个字段进行数据转换
          variables: {
            'genre': Variable(
              accessor: (Map map) => map['genre'] as String,
            ),
            'sold': Variable(
              accessor: (Map map) => map['sold'] as num,
              scale: LinearScale(min: 0, marginMax: 0.1),
            ),
          },
          transforms: [Proportion(variable: 'sold', as: 'percent')],
          elements: [
            IntervalElement(
              position: Varset('percent') / Varset('genre'),
              label: LabelAttr(
                  encoder: (tuple) => Label(
                        tuple['sold'].toString(),
                        // LabelStyle(style: Defaults.runeStyle),
                        LabelStyle(style: const TextStyle(fontSize: 18, color: Colors.black)),
                      )),
              color: ColorAttr(
                  variable: 'genre', values: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue]),
              modifiers: [StackModifier()],
            )
          ],
          coord: PolarCoord(transposed: true, dimCount: 1),
          selections: {'tap': PointSelection()},
          tooltip: TooltipGuide(),
        ));
  }

  Widget _initPieChart3() {
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
          transforms: [Proportion(variable: 'sold', as: 'percent')],
          elements: [
            IntervalElement(
              position: Varset('percent') / Varset('genre'),
              color: ColorAttr(variable: 'genre', values: Defaults.colors10),
              modifiers: [StackModifier()],
            )
          ],
          coord: PolarCoord(
            transposed: true,
            dimCount: 1,
            startRadius: 0.4,
          ),
          selections: {'tap': PointSelection()},
          tooltip: TooltipGuide(renderer: centralPieLabel),
        ));
  }

  List<Figure> centralPieLabel(
    Size size,
    Offset anchor,
    Map<int, Tuple> selectedTuples,
  ) {
    final tuple = selectedTuples.values.last;

    var titleColor = Theme.of(context).textTheme.bodyText1?.color;
    // var titleColor = KColors.dynamicColor(context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor);

    final titleSpan = TextSpan(
      text: '${tuple['genre']}\n',
      style: TextStyle(fontSize: 14, color: titleColor),
    );

    final valueSpan = TextSpan(
      text: tuple['sold'].toString(),
      style: TextStyle(fontSize: 28, color: titleColor),
    );

    final painter = TextPainter(
      text: TextSpan(children: [titleSpan, valueSpan]),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    painter.layout();

    final paintPoint = getPaintPoint(
      const Offset(175, 150),
      painter.width,
      painter.height,
      Alignment.center,
    );

    return [TextFigure(painter, paintPoint)];
  }
}
