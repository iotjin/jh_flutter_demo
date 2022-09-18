// import 'dart:math';
// import 'package:flutter/material.dart';
// import '/base_appbar.dart';
//
// import 'package:sticky_headers/sticky_headers.dart';
// import 'package:mp_chart/mp/chart/bar_chart.dart';
// import 'package:mp_chart/mp/controller/bar_chart_controller.dart';
// import 'package:mp_chart/mp/core/data/bar_data.dart';
// import 'package:mp_chart/mp/core/data_interfaces/i_bar_data_set.dart';
// import 'package:mp_chart/mp/core/data_set/bar_data_set.dart';
// import 'package:mp_chart/mp/core/description.dart';
// import 'package:mp_chart/mp/core/entry/bar_entry.dart';
// import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
// import 'package:mp_chart/mp/core/adapter_android_mp.dart';
// import 'package:mp_chart/mp/core/enums/legend_horizontal_alignment.dart';
// import 'package:mp_chart/mp/core/enums/legend_orientation.dart';
// import 'package:mp_chart/mp/core/enums/legend_vertical_alignment.dart';
// import 'package:mp_chart/mp/core/value_formatter/large_value_formatter.dart';
// import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';
//
// class MpChartBarPage1 extends StatefulWidget {
//   @override
//   _MpChartBarPage1State createState() => _MpChartBarPage1State();
// }
//
// class _MpChartBarPage1State extends State<MpChartBarPage1> {
//   BarChartController _controller;
//   var random = Random(1);
//   int _count = 10;
//   double _range = 100.0;
//
//   @override
//   void initState() {
//     _initController();
//     _initBarData(_count, _range);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var value = ModalRoute.of(context).settings.arguments;
//     value = value ?? '';
//     return Scaffold(
//       appBar:BaseAppBar('MpChartBar'),
//       body: _content(),
//     );
//   }
//
//   // content
//   Widget _content() {
//     return ListView.builder(
//         itemCount: 2,
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return StickyHeader(
//                 header: Container(
//                   height: 50.0,
//                   padding: EdgeInsets.only(left: 15),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF9F9F9),
//                   ),
//                   child: Row(
//                     children: <Widget>[
// //                      Image.asset(
// //                        'assets/images/ic_analysis_temperature.png',
// //                        width: 25,
// //                        height: 25,
// //                      ),
//                       SizedBox(width: 8),
//                       Text('近30日温度', style: TextStyle(fontSize: 22))
//                     ],
//                   ),
//                 ),
//                 content: Container(
//                   child: BarChart(_controller),
//                   height: 300,
//                 ));
//           }
//           if (index == 1) {
//             return StickyHeader(
//               header: Container(
//                 height: 50.0,
//                 padding: EdgeInsets.only(left: 15),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF9F9F9),
//                 ),
//                 child: Row(
//                   children: <Widget>[
// //                    Image.asset(
// //                      'assets/images/ic_analysis_temperature.png',
// //                      width: 25,
// //                      height: 25,
// //                    ),
//                     SizedBox(width: 8),
//                     Text('未来7天趋势预测', style: TextStyle(fontSize: 22))
//                   ],
//                 ),
//               ),
//               content: Container(
//                 color: Colors.white,
//                 child: Center(
//                   child: Image.asset(
//                     'assets/images/ic_comingSoon.png',
//                     width: 250,
//                     height: 250,
//                   ),
//                 ),
//               ),
//             );
//           }
//         });
//   }
//
//   var XStartData = 1;
//   var XEndData = 31;
//   int groupCount;
//
//   void _initBarData(int count, double range) async {
//     BarDataSet set1, set2;
//     groupCount = count + 1;
//     List<BarEntry> values1 = List();
//     List<BarEntry> values2 = List();
//
// //    values1.add(BarEntry(x: 75, y: 85));
// //    values1.add(BarEntry(x: 80, y: 90));
// //    values1.add(BarEntry(x: 85, y: 95));
// //    values1.add(BarEntry(x: 90, y: 90));
// //    values1.add(BarEntry(x: 95, y: 85));
// //    values1.add(BarEntry(x: 100, y: 86));
// //    values1.add(BarEntry(x: 105, y: 90));
// //    values1.add(BarEntry(x: 110, y: 95));
// //    values1.add(BarEntry(x: 115, y: 80));
// //    values1.add(BarEntry(x: 120, y: 90));
// //    XStartData = 75;
// //
// //    values2.add(BarEntry(x: 75, y: 76));
// //    values2.add(BarEntry(x: 78, y: 78));
// //    values2.add(BarEntry(x: 78, y: 46));
// //    values2.add(BarEntry(x: 48, y: 75));
// //    values2.add(BarEntry(x: 78, y: 78));
// //    values2.add(BarEntry(x: 48, y: 45));
// //    values2.add(BarEntry(x: 48, y: 49));
// //    values2.add(BarEntry(x: 48, y: 45));
// //    values2.add(BarEntry(x: 48, y: 45));
// //    values2.add(BarEntry(x: 75, y: 45));
//
//     double randomMultiplier = range * 1;
//
//     for (int i = XStartData; i <= XEndData; i++) {
//       values1.add(BarEntry(
//         x: i.toDouble(),
//         y: (random.nextDouble() * randomMultiplier),
//       ));
//       values2.add(BarEntry(
//           x: i.toDouble(), y: (random.nextDouble() * randomMultiplier)));
//     }
//
//     set1 = new BarDataSet(values1, 'Data Set');
//     set1.setColor1(Color(0xFF527FFD));
//     set1.setDrawValues(false);
//
//     set2 = BarDataSet(values2, 'Data Set22');
//     set2.setColor1(Color(0xFF00DEB7));
//     set2.setDrawValues(false);
//
//     List<BarDataSet> dataSets = List();
//     dataSets.add(set1);
//     dataSets.add(set2);
//     _controller.data = BarData(dataSets);
//
//     _controller.data
// //      ..setValueFormatter(LargeValueFormatter())
//       ..setValueTypeface(
//           TypeFace(fontFamily: 'OpenSans', fontWeight: FontWeight.w800))
//       ..setValueTextSize(5)
//     // specify the width each bar should have
//       ..barWidth = (0.5);
//
//     setState(() {});
//   }
//
//   void _initController() {
//     double groupSpace = 0.08;
//     double barSpace = 0.03;
//     var desc = Description()..enabled = false;
//     _controller = BarChartController(
//       axisLeftSettingFunction: (axisLeft, controller) {
//         ValueFormatter formatter = LargeValueFormatter();
//         axisLeft
//           ..setValueFormatter(formatter)
//           ..drawGridLines = (false)
//           ..spacePercentTop = (35)
//           ..setAxisMinimum(0);
//         axisLeft.drawGridLines = false;
//       },
//       legendSettingFunction: (legend, controller) {
// //        legend.enabled = true;
//         legend
//           ..verticalAlignment = (LegendVerticalAlignment.TOP)
//           ..horizontalAlignment = (LegendHorizontalAlignment.RIGHT)
//           ..orientation = (LegendOrientation.HORIZONTAL)
//           ..drawInside = true
//           ..yOffset = (10.0)
//           ..xOffset = (0)
//           ..yEntrySpace = (0)
//           ..textSize = (8);
//       },
//       xAxisSettingFunction: (xAxis, controller) {
//         xAxis
//           ..position = XAxisPosition.BOTTOM
//           ..drawGridLines = false
//           ..typeface =
//           TypeFace(fontFamily: 'OpenSans', fontWeight: FontWeight.w800)
//           ..setGranularity(1.0);
// //          ..centerAxisLabels = true;
// //          ..setAxisMinimum(XStartData.toDouble())
// //          ..setAxisMaximum(XStartData +
// //              (controller.data as BarData).getGroupWidth(groupSpace, barSpace) *
// //                  32);
//         //(0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per 'group'
//         (controller as BarChartController)
//             .groupBars(XStartData.toDouble(), groupSpace, barSpace);
//       },
//       drawGridBackground: false,
//       dragXEnabled: true,
//       dragYEnabled: true,
//       scaleXEnabled: true,
//       scaleYEnabled: true,
//       pinchZoomEnabled: false,
//       maxVisibleCount: 60,
//       description: desc,
//       fitBars: true,
//     );
//   }
//
// }
