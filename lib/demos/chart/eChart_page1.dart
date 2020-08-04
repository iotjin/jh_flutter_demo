import 'package:flutter/material.dart';
import 'package:jh_flutter_demo/base_appbar.dart';
import 'package:flutter_echarts/flutter_echarts.dart';


//                          dataZoom: [{
//                                  start: 0,
//                                  // end: 10,
//                                  throttle: 50
//                              }, {
//                                      type: 'inside'
//                               }],

class EChartPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'EChart1 - 平滑折线图 警戒线'),
      body:
      Container(
        color: Colors.cyan,
        child:
        Echarts(
          captureAllGestures: false,
          option: '''
                      {
                          title: {
                              text: 'title',
                              left: 'center'
                          },
                          tooltip: {
                              trigger: 'item',
                              formatter: '{a} <br/>{b} : {c}'
                          },
                          xAxis: {
                              type: 'category',
                              data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                          },
                          yAxis: {
                              type: 'value'
                          },
                          //                          dataZoom: [
                          //                              {
                          //                              type: 'inside'
                          //                              }
                          //                          ],
                          //    dataZoom: [
                          //               preventDefaultMouseMove：false,
                          //        {
                          //
                          //            id: 'dataZoomX',
                          //            type: 'slider',
                          //            xAxisIndex: [0],
                          //            filterMode: 'filter'
                          //        },
                          //        {
                          //            id: 'dataZoomY',
                          //            type: 'slider',
                          //            yAxisIndex: [0],
                          //            filterMode: 'filter'
                          //        }
                          //    ],
                          series: [{
                              data: [820, 932, 760, 934, 850, 1330, 1320],
                              type: 'line',
                             symbol:'none', //去掉折线图中的节点
                             smooth: true,  //true 为平滑曲线，false为直线
                             areaStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#6884CD'
                                }, {
                                    offset: 1,
                                    color: '#FFFFFF'
                                }])
                            },
                               markLine: {
                                      silent: true,
                                      data: [{
                                          yAxis: 550
                                      }, {
                                          yAxis: 900
                                      }]
                                  }
                          }]
                      }
                ''',
        ),
//        width: 300,
        height: 250,
      ),

    );
  }
}


