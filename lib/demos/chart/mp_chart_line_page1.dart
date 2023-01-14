// import 'dart:math';
// import 'package:flutter/material.dart';
// import '/base_appbar.dart';
// import 'package:mp_chart/mp/chart/line_chart.dart';
// import 'package:mp_chart/mp/controller/line_chart_controller.dart';
// import 'package:mp_chart/mp/core/data/line_data.dart';
// import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
// import 'package:mp_chart/mp/core/data_provider/line_data_provider.dart';
// import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
// import 'package:mp_chart/mp/core/description.dart';
// import 'package:mp_chart/mp/core/entry/entry.dart';
// import 'package:mp_chart/mp/core/enums/mode.dart';
// import 'package:mp_chart/mp/core/enums/limit_label_postion.dart';
// import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
// import 'package:mp_chart/mp/core/fill_formatter/i_fill_formatter.dart';
// import 'package:mp_chart/mp/core/limit_line.dart';
// import 'package:mp_chart/mp/core/adapter_android_mp.dart';
//
// //import 'package:mp_chart/mp/core/entry/entry.dart';
// //import 'package:mp_chart/mp/chart/pie_chart.dart';
// //import 'package:mp_chart/mp/core/data/pie_data.dart';
// //import 'package:mp_chart/mp/core/data_set/pie_data_set.dart';
// //import 'package:mp_chart/mp/controller/controller.dart';
// //import 'package:mp_chart/mp/controller/pie_chart_controller.dart';
// //import 'package:mp_chart/mp/core/entry/pie_entry.dart';
//
// class MpChartLinePage1 extends StatefulWidget {
//   @override
//   _MpChartLinePage1State createState() => _MpChartLinePage1State();
// }
//
// class _MpChartLinePage1State extends State<MpChartLinePage1> {
//   LineChartController _controller;
//   var random = Random(1);
//   double _range = 100.0;
//   int _count = 0;
//
//   @override
//   void initState() {
//     _initController();
//     _initLineData(_range);
//     super.initState();
//   }
//
//   @override
//   String getTitle() => 'Line Chart Performance';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar('折线图'),
//       body: ListView(
//         children: <Widget>[
//           SizedBox(
//             height: 15,
//           ),
//           Container(
//             color: Colors.white,
//             child: Text(
//               'title',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//           Container(
//             child: LineChart(_controller),
//             height: 500,
//           )
//         ],
//       ),
//     );
//   }
//
//   void _initController() {
//     var desc = Description()
//       ..text = 'desc2'
//       ..enabled = true;
//     Description description = Description();
//     description.text = 'desc';
//     description.enabled = true;
//     LimitLine limitL = LimitLine(90, 'Upper Limit');
//     limitL.setLineWidth(1);
//     limitL.enableDashedLine(15, 5, 0); //设置线的间隔
//     limitL.labelPosition = (LimitLabelPosition.CENTER_TOP);
//     limitL.drawBackground = true;
//     limitL.backgroundColor = Colors.red;
//     limitL.textSize = (12);
//     limitL.typeface =
//         TypeFace(fontFamily: 'OpenSans', fontWeight: FontWeight.w800);
//
//     _controller = LineChartController(
//         axisLeftSettingFunction: (axisLeft, controller) {
//           axisLeft
//             ..drawGridLines = false
//             ..addLimitLine(limitL);
//         },
//         axisRightSettingFunction: (axisRight, controller) {
//           axisRight.enabled = (false);
//         },
//         xAxisSettingFunction: (xAxis, controller) {
//           xAxis
//             ..position = XAxisPosition.BOTTOM
//             ..drawGridLines = (false)
//             ..drawAxisLine = (false);
//         },
//         legendSettingFunction: (legend, controller) {
//           legend
//             ..enabled = (true)
// //            ..shape = (LegendForm.LINE)
// //            ..textSize = (11)
// ////            ..typeface = Util.LIGHT
// //            ..textColor = (ColorUtils.BLUE)
// //            ..verticalAlignment = (LegendVerticalAlignment.BOTTOM)
// //            ..horizontalAlignment = (LegendHorizontalAlignment.LEFT)
// //            ..orientation = (LegendOrientation.HORIZONTAL)
//             ..drawInside = (false);
//         },
//         drawGridBackground: true,
//         dragXEnabled: true,
//         dragYEnabled: true,
//         scaleXEnabled: true,
//         scaleYEnabled: true,
//         pinchZoomEnabled: false,
//         descTextColor: Colors.red,
//         descTextSize: 18,
//         description: description);
//   }
//
//   void _initLineData(double range) {
//     List<Entry> values = List();
//     _count = (range + 10).toInt();
//
// //    for (int i = 0; i < _count; i++) {
// //      double val = (random.nextDouble() * (range + 1)) + 3;
// //      values.add(new Entry(x: i * 1.0, y: val));
// //    }
//
//     values.add(new Entry(x: 75, y: 85));
//     values.add(new Entry(x: 80, y: 90));
//     values.add(new Entry(x: 85, y: 95));
//     values.add(new Entry(x: 90, y: 90));
//     values.add(new Entry(x: 95, y: 85));
//     values.add(new Entry(x: 100, y: 86));
//     values.add(new Entry(x: 105, y: 90));
//     values.add(new Entry(x: 110, y: 95));
//     values.add(new Entry(x: 115, y: 80));
//     values.add(new Entry(x: 120, y: 90));
//
//     // create a dataset and give it a type
//     LineDataSet set1 = new LineDataSet(values, 'DataSet 1');
//
//     set1.setMode(Mode.CUBIC_BEZIER);
//     set1.setColor1(Colors.orange);
//     set1.setLineWidth(1.5);
//     set1.setDrawValues(false);
//     set1.setDrawCircles(false);
//     set1.setDrawFilled(true);
//     set1.setFillColor(Colors.orangeAccent);
//     set1.setFillAlpha(80);
//     set1.setDrawHorizontalHighlightIndicator(false);
//     set1.setFillFormatter(A());
//
// //    // create a data object with the data sets
// //    _controller.data = LineData.fromList(List()..add(set1));
//
//     List<Entry> values2 = List();
//     values2.add(new Entry(x: 75, y: 80));
//     values2.add(new Entry(x: 80, y: 85));
//     values2.add(new Entry(x: 85, y: 86));
//     values2.add(new Entry(x: 90, y: 80));
//     values2.add(new Entry(x: 95, y: 85));
//     values2.add(new Entry(x: 100, y: 86));
//     values2.add(new Entry(x: 105, y: 90));
//     values2.add(new Entry(x: 110, y: 95));
//     values2.add(new Entry(x: 115, y: 87));
//     values2.add(new Entry(x: 120, y: 92));
//
//     LineDataSet set2 = new LineDataSet(values2, 'DataSet 2');
//     set2.setMode(Mode.CUBIC_BEZIER);
//     set2.setColor1(Colors.yellow);
//     set2.setLineWidth(1.5);
//     set2.setDrawValues(false);
//     set2.setDrawCircles(false);
//     set2.setDrawFilled(false);
//
// //    set1.setCircleRadius(5);
// //    set2.setFillColor(ColorUtils.RED);
// //    set2.setFillAlpha(65);
// //    set2.setDrawCircleHole(false);
// //    set2.setHighLightColor(Colors.red);
// //    set2.setAxisDependency(AxisDependency.RIGHT);
// //    set2.setCircleColor(ColorUtils.WHITE);
//
//     // create a data object with the data sets
//     // create a data object with the data sets
//     _controller.data = LineData.fromList(List()..add(set1)..add(set2));
//     _controller.data
//       ..setValueTextColor(Colors.black)
//       ..setValueTextSize(12);
//
//     setState(() {});
//   }
// }
//
// class A implements IFillFormatter {
//   LineChartController _controller;
//
//   void setPainter(LineChartController controller) {
//     _controller = controller;
//   }
//
//   @override
//   double getFillLinePosition(
//       ILineDataSet dataSet, LineDataProvider dataProvider) {
//     return _controller?.painter?.axisLeft?.axisMinimum;
//   }
// }
