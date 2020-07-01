import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage1 extends StatefulWidget {
  @override
  _ChartPage1State createState() => _ChartPage1State();
}

class _ChartPage1State extends State<ChartPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      backAppBar(context, 'chart'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: getBar(),
            ),
            Container(
              height: 300,
              child: getLine(),
            )
          ],
        ),
      ),
    );
  }

  Widget getLine() {
    List<Linesales> dataLine = [
      new Linesales(new DateTime(2019, 7, 2), 33),
      new Linesales(new DateTime(2019, 7, 3), 55),
      new Linesales(new DateTime(2019, 7, 4), 22),
      new Linesales(new DateTime(2019, 7, 5), 88),
      new Linesales(new DateTime(2019, 7, 6), 123),
      new Linesales(new DateTime(2019, 7, 7), 75),
    ];

    var seriesLine = [
      charts.Series<Linesales, DateTime>(
        data: dataLine,
        domainFn: (Linesales lines, _) => lines.time,
        measureFn: (Linesales lines, _) => lines.sale,
        id: "Lines",
      )
    ];
    //是TimeSeriesChart，而不是LineChart,因为x轴是DataTime类
    Widget line = charts.TimeSeriesChart(seriesLine);
    //line = charts.LineChart(series);
    return line;
  }

  Widget getBar() {
    List<Barsales> dataBar = [
      new Barsales("1", 20),
      new Barsales("2", 50),
      new Barsales("3", 20),
      new Barsales("4", 80),
      new Barsales("5", 120),
      new Barsales("6", 30),
    ];

    var seriesBar = [
      charts.Series(
        data: dataBar,
        domainFn: (Barsales sales, _) => sales.day,
        measureFn: (Barsales sales, _) => sales.sale,
        id: "Sales",
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
