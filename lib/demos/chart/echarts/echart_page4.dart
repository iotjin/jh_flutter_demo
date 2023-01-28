import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '/base_appbar.dart';

class EChartPage4 extends StatefulWidget {
  const EChartPage4({Key? key}) : super(key: key);

  @override
  State<EChartPage4> createState() => _EChartPage4State();
}

class _EChartPage4State extends State<EChartPage4> {
  late Map<String, dynamic> chartData;

  @override
  void initState() {
    super.initState();

    initChartData();
  }

  //设置假数据
  initChartData() {
    var legendDataArr = ['最高温度', '最低温度', '环境温度'];

    var xAxisDataArr = [
      '01:00',
      '02:00',
      '03:00',
      '04:00',
      '05:00',
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00',
      '00:00'
    ];

    var seriesDataArr = [
      {
        'name': '最高温度',
        'type': 'line',
        'symbol': 'none', //去掉折线图中的节点
        'smooth': true, //true 为平滑曲线，false为直线
        'areaStyle': {
          'color': {
            'type': 'linear',
            'x': 0,
            'y': 0,
            'x2': 0,
            'y2': 1,
            'colorStops': [
              {
                'offset': 0, 'color': '#6884CD' // 0% 处的颜色
              },
              {
                'offset': 1, 'color': '#FFFFFF' // 100% 处的颜色
              }
            ],
          }
        },
        'data': [
          2.8,
          6.9,
          8.4,
          25.4,
          26.7,
          80.7,
          78.6,
          65.2,
          50.7,
          20.8,
          10.0,
          5.3,
          4.6,
          6.9,
          10.0,
          25.4,
          26.7,
          75.7,
          80.6,
          70.2,
          66.7,
          20.8,
          8.0,
          3.3
        ]
      },
      {
        'name': '最低温度',
        'type': 'line',
        'symbol': 'none', //去掉折线图中的节点
        'smooth': true, //true 为平滑曲线，false为直线
        'areaStyle': {
          'color': {
            'type': 'linear',
            'x': 0,
            'y': 0,
            'x2': 0,
            'y2': 1,
            'colorStops': [
              {
                'offset': 0, 'color': '#00DEB7' // 0% 处的颜色
              },
              {
                'offset': 1, 'color': '#FFFFFF' // 100% 处的颜色
              }
            ],
          }
        },
        'data': [
          2.0,
          2.2,
          3.3,
          4.5,
          6.3,
          20.2,
          30.3,
          43.4,
          33.0,
          26.5,
          12.0,
          6.2,
          2.0,
          2.2,
          3.3,
          4.5,
          6.3,
          20.2,
          30.3,
          43.4,
          33.0,
          26.5,
          12.0,
          6.2
        ]
      },
      {
        'name': '环境温度',
        'type': 'line',
        'symbol': 'none', //去掉折线图中的节点
        'smooth': true, //true 为平滑曲线，false为直线
        'areaStyle': {
          'color': {
            'type': 'linear',
            'x': 0,
            'y': 0,
            'x2': 0,
            'y2': 1,
            'colorStops': [
              {
                'offset': 0, 'color': '#fdc43c' // 0% 处的颜色
              },
              {
                'offset': 1, 'color': '#FFFFFF' // 100% 处的颜色
              }
            ],
          }
        },
        'data': [
          2.6,
          5.9,
          9.0,
          26.4,
          28.7,
          70.7,
          78.6,
          60.2,
          48.7,
          18.8,
          6.0,
          2.3,
          2.6,
          5.9,
          9.0,
          26.4,
          28.7,
          70.7,
          78.6,
          60.2,
          48.7,
          18.8,
          6.0,
          2.3
        ]
      }
    ];

    chartData = {'legendData': legendDataArr, 'xData': xAxisDataArr, 'seriesData': seriesDataArr};
  }

  @override
  Widget build(BuildContext context) {
    var value = ModalRoute.of(context)!.settings.arguments;
    value = value ?? '';
    return Scaffold(
      appBar: const BaseAppBar('EChart4 - 渐变折线图'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        _header('今日温度'),
        _initChart2(chartData),
        _header('未来7天趋势预测'),
        Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              'assets/images/ic_comingSoon.png',
              width: 250,
              height: 250,
            ),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _header(String title) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.only(left: 15),
      decoration: const BoxDecoration(color: Color(0xFFF9F9F9)),
      child: Row(
        children: <Widget>[const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 22))],
      ),
    );
  }

  Widget _initChart2(chartData) {
    return SizedBox(
//      color: Colors.cyan,
      width: double.infinity,
      height: 250,
//      color: Colors.cyan,
      child: Echarts(
        reloadAfterInit: true,
        captureAllGestures: false,
        option: '''
                    {
                    color:['#527FFD','#00DEB7','#FBEC4B'],
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            crossStyle: {
                                color: '#999'
                            }
                        },
                    // formatter: '{b0} <br/>{a0}：{c0}°C<br/>{a1}：{c1}°C<br/>{a2}：{c2}°C<br/>'
                        formatter: function (params) {
                            var relVal = params[0].name
                            for (var i = 0, l = params.length; i < l; i++) {
                                relVal += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + params[i].value + '°C'
                            }
                            return relVal
                        }
                    },
                    legend: {
                        data: ${jsonEncode(chartData['legendData'])},
                        top:10,
                        right: 30,
                        icon: 'circle',
                        itemWidth: 10,
                        itemHeight: 10,
                        selected: {
                          '最高温度': true,
                          '最低温度': true,
                          '环境温度': false
                        }
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: ${jsonEncode(chartData['xData'])},
                            axisPointer: {
                                type: 'shadow'
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            name: '摄氏度',
                            min: 0,
                            max: 120,
                            interval: 20,
                            axisLabel: {
                                formatter: '{value}'
                            }
                        },
                    ],
                    series: ${jsonEncode(chartData['seriesData'])} 
                }
                ''',
      ),
    );
  }
}
