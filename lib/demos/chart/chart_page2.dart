// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '/base_appbar.dart';

class ChartPage2 extends StatefulWidget {
  const ChartPage2({Key? key}) : super(key: key);

  @override
  State<ChartPage2> createState() => _ChartPage2State();
}

class _ChartPage2State extends State<ChartPage2> {
  String _year = '未选择';
  int _sales = 0;

  // 点击柱状图触发的函数
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    print(selectedDatum.first.datum.year);
    print(selectedDatum.first.datum.sales);
    print(selectedDatum.first.series.displayName);
    setState(() {
      // 改变两个显示的数值
      _year = selectedDatum.first.datum.year;
      _sales = selectedDatum.first.datum.sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar('chart2'),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('年份：$_year'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('数值：$_sales'),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 200.0,
              child: charts.BarChart(
                // 通过下面获取数据传入
                ChartFlutterBean.createSampleData(),
                // 配置项，以及设置触发的函数
                selectionModels: [
                  charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener: _onSelectionChanged,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

// 一下为组合柱状图数据部分
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class ChartFlutterBean {
  static List<charts.Series<OrdinalSales, String>> createSampleData() {
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}
