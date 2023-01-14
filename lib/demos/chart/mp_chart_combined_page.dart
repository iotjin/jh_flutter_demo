// import 'dart:math';
// import 'package:flutter/material.dart';
//
// import 'package:mp_chart/mp/chart/combined_chart.dart';
// import 'package:mp_chart/mp/controller/combined_chart_controller.dart';
// import 'package:mp_chart/mp/core/data/combined_data.dart';
// import 'package:mp_chart/mp/core/data/line_data.dart';
// import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
// import 'package:mp_chart/mp/core/enums/mode.dart';
// import 'package:mp_chart/mp/core/data/bar_data.dart';
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
// import 'package:mp_chart/mp/core/entry/entry.dart';
//
// import 'package:sticky_headers/sticky_headers.dart';
// import '/base_appbar.dart';
//
//
// class MpChartCombinedPage extends StatefulWidget {
//   @override
//   _MpChartCombinedPageState createState() => _MpChartCombinedPageState();
// }
//
// class _MpChartCombinedPageState extends State<MpChartCombinedPage> {
//   CombinedChartController _controller;
//
//   @override
//   void initState() {
//     _initController();
//     _initCombinedData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var value = ModalRoute.of(context).settings.arguments;
//     value = value ?? '';
//     return Scaffold(
//       appBar: BaseAppBar('MpChartBar'),
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
// //                  child: BarChart(_controller),
//                   child: CombinedChart(_controller),
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
//   void _initController() {
//     var desc = Description()..enabled = false;
//     _controller = CombinedChartController(
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
//         ;
//       },
//       drawGridBackground: false,
//       dragXEnabled: true,
//       dragYEnabled: true,
//       scaleXEnabled: true,
//       scaleYEnabled: true,
//       pinchZoomEnabled: true,
//       maxVisibleCount: 60,
//       description: desc,
//       fitBars: true,
//     );
//   }
//
//
//   void _initCombinedData() {
//     _controller.data = CombinedData();
//     _controller.data
//       ..setData1(generateLineData())
//       ..setData2(generateBarData())
//       ..setValueTextColor(Colors.black)
//       ..setValueTextSize(12);
//   }
//
//   double getRandom(int min,int max) {
//     return min + Random.secure().nextInt(max - min) +0.0;
//   }
//
//   //折线数据
//   LineData generateLineData() {
//     LineData d = LineData();
//
//     List<Entry> entries = List();
//     int _count = 31;
//     for (int index = 0; index < _count; index++) {
//       entries.add(Entry(x: index + 0.5, y: getRandom(40,50)));
//     }
//
//     LineDataSet set = LineDataSet(entries, 'Line DataSet');
//     set.setColor1(Color.fromARGB(255, 240, 238, 70));
//     set.setLineWidth(2.0);
// //    set.setCircleColor(Color.fromARGB(255, 240, 238, 70));
// //    set.setCircleRadius(5);
// //    set.setFillColor(Color.fromARGB(255, 240, 238, 70));
// //    set.setDrawValues(true);
//     set.setMode(Mode.CUBIC_BEZIER);
//     set.setValueTextSize(10);
//     set.setDrawValues(false);
//     set.setDrawCircles(false);
//     set.setDrawFilled(false);
//     set.setValueTextColor(Color.fromARGB(255, 240, 238, 70));
//
//     d.addDataSet(set);
//
//     return d;
//   }
//
//   BarData generateBarData() {
//     double groupSpace = 0.08;
//     double barSpace = 0.03;
//
//     List<BarEntry> entries1 = List();
//     List<BarEntry> entries2 = List();
//     for (int i = XStartData; i <= XEndData; i++) {
//       entries1.add(BarEntry(x: 0, y: getRandom(25, 40)));
//       entries2.add(BarEntry.fromListYVals(
//           x: 0,
//           vals: List<double>()
//             ..add(getRandom(13, 25))
//             ..add(getRandom(13, 36))));
//     }
//
//     BarDataSet set1, set2;
//     set1 = new BarDataSet(entries1, 'Data Set');
//     set1.setColor1(Color(0xFF527FFD));
//     set1.setDrawValues(false);
//     set2 = BarDataSet(entries2, 'Data Set22');
//     set2.setColor1(Color(0xFF00DEB7));
//     set2.setDrawValues(false);
//
//     BarData d = BarData(List()..add(set1)..add(set2));
//     d.barWidth = (0.5);
//     d.setValueTextSize(5);
//     d.setValueTypeface(
//         TypeFace(fontFamily: 'OpenSans', fontWeight: FontWeight.w800));
//
//     // make this BarData object grouped
//     d.groupBars(XStartData.toDouble(), groupSpace, barSpace); // start at x = 0
//
//     return d;
//   }
// }
