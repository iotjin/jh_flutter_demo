import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '/base_appbar.dart';

class ChartPage1 extends StatefulWidget {
  const ChartPage1({Key? key}) : super(key: key);

  @override
  State<ChartPage1> createState() => _ChartPage1State();
}

class _ChartPage1State extends State<ChartPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('chart'),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: getBar(),
          ),
          SizedBox(
            height: 300,
            child: getLine(),
          )
        ],
      ),
    );
  }

  Widget getLine() {
    List<Linesales> dataLine = [
      Linesales(DateTime(2019, 7, 2), 33),
      Linesales(DateTime(2019, 7, 3), 55),
      Linesales(DateTime(2019, 7, 4), 22),
      Linesales(DateTime(2019, 7, 5), 88),
      Linesales(DateTime(2019, 7, 6), 123),
      Linesales(DateTime(2019, 7, 7), 75),
    ];

    var seriesLine = [
      charts.Series<Linesales, DateTime>(
        data: dataLine,
        domainFn: (Linesales lines, _) => lines.time,
        measureFn: (Linesales lines, _) => lines.sale,
        id: 'Lines',
      )
    ];
    // 是TimeSeriesChart，而不是LineChart,因为x轴是DataTime类
    Widget line = charts.TimeSeriesChart(seriesLine);
    // line = charts.LineChart(series);
    return line;
  }

  Widget getBar() {
    List<Barsales> dataBar = [
      Barsales('1', 20),
      Barsales('2', 50),
      Barsales('3', 20),
      Barsales('4', 80),
      Barsales('5', 120),
      Barsales('6', 30),
    ];

    var seriesBar = [
      charts.Series(
        data: dataBar,
        domainFn: (Barsales sales, _) => sales.day,
        measureFn: (Barsales sales, _) => sales.sale,
        id: 'Sales',
      )
    ];
    return charts.BarChart(seriesBar);
  }
}

class Barsales {
  String day;
  int sale;

  Barsales(this.day, this.sale);
}

class Linesales {
  DateTime time;
  int sale;

  Linesales(this.time, this.sale);
}
