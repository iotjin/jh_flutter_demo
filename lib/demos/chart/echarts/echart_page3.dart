import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '/base_appbar.dart';

class EChartPage3 extends StatefulWidget {
  const EChartPage3({Key? key}) : super(key: key);

  @override
  State<EChartPage3> createState() => _EChartPage3State();
}

class _EChartPage3State extends State<EChartPage3> {
  late Map<String, dynamic> chartData;

  @override
  void initState() {
    super.initState();

    var legendDataArr = ['最高温度', '最低温度', '环境温度'];
    var xAxisDataArr = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
    var seriesDataArr = [
      {
        'name': '最高温度',
        'type': 'bar',
        'barGap': 0,
        'data': [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 80.6, 90.2, 32.6, 20.0, 6.4, 3.3]
      },
      {
        'name': '最低温度',
        'type': 'bar',
        'data': [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 78.6, 60.2, 48.7, 18.8, 6.0, 2.3]
      },
      {
        'name': '环境温度',
        'type': 'line',
        'yAxisIndex': 1,
        'smooth': true, //true 为平滑曲线，false为直线
        'data': [2.0, 2.2, 3.3, 4.5, 6.3, 20.2, 30.3, 43.4, 33.0, 26.5, 12.0, 6.2]
      }
    ];

    chartData = {'legendData': legendDataArr, 'xData': xAxisDataArr, 'seriesData': seriesDataArr};
  }

  @override
  Widget build(BuildContext context) {
    var value = ModalRoute.of(context)!.settings.arguments;
    value = value ?? '';
    return Scaffold(
      appBar: const BaseAppBar('EChart3 - 多图表 - 动态数据'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        _header('近一年温度'),
        _initChart2(chartData),
//              _initChart(),
        _header('未来趋势预测'),
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
        children: <Widget>[
//          Image.asset(
//            'assets/images/ic_analysis_temperature.png',
//            width: 25,
//            height: 25,
//          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 22))
        ],
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
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: ${jsonEncode(chartData['xData'])},
                            'axisLabel': {
                                interval: 0
                            },
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
                        {
                            type: 'value',
                            min: 0,
                            max: 60,
                            interval: 10,
                            axisLabel: {
                                formatter: '{value}'
                            }
                        }
                    ],
                    series: ${jsonEncode(chartData['seriesData'])} 
                }
                ''',
      ),
    );
  }
}

/*

 var legendDataArr = ['最高温度', '最低温度', '环境温度'];

 var xAxisDataArr = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];

 var seriesDataArr = [
        {
            name: '最高温度',
            type: 'bar',
            barGap: 0,
            data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 80.6, 90.2, 32.6, 20.0, 6.4, 3.3]
        },
        {
            name: '最低温度',
            type: 'bar',
            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 78.6, 60.2, 48.7, 18.8, 6.0, 2.3]
        },
        {
            name: '环境温度',
            type: 'line',
            yAxisIndex: 1,
            smooth: true,  //true 为平滑曲线，false为直线
            data: [2.0, 2.2, 3.3, 4.5, 6.3, 20.2, 30.3, 43.4, 33.0, 26.5, 12.0, 6.2]
        }
    ];



var chartData = {
      legendData: legendDataArr,
      xData: xAxisDataArr,
    seriesData: seriesDataArr
};

option = {
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
        data: chartData.legendData,
        top:10,
        right: 30,
        icon: 'circle',
        itemWidth: 10,
        itemHeight: 10,
    },
    xAxis: [
        {
            type: 'category',
            data: chartData.xData,
            'axisLabel': {
              interval: 0
              },
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
        {
            type: 'value',
            name: '温度',
            min: 0,
            max: 60,
            interval: 10,
            axisLabel: {
                formatter: '{value}'
            }
        }
    ],
    series: chartData.seriesData
};

* */

/*
option = {
    color:['#527FFD','#00DEB7','#FBEC4B'],
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            crossStyle: {
                color: '#999'
            }
        },
        formatter: function (params) {
            var relVal = params[0].name
            for (var i = 0, l = params.length; i < l; i++) {
                relVal += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + params[i].value + '°C'
            }
            return relVal
        }
        // formatter: '{b0} <br/>{a0}：{c0}°C<br/>{a1}：{c1}°C<br/>{a2}：{c2}°C<br/>'
    },

    // tooltip: {
    //   trigger: 'item',
    //   formatter: '{a} <br/>{b} : {c}'
    // },
    legend: {
        data: ['最高温度', '最低温度', '环境温度'],
        top:10,
        right: 30,
        icon: 'circle',
        itemWidth: 10,
        itemHeight: 10,
    },
    xAxis: [
        {
            type: 'category',
            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
            'axisLabel': {
              interval: 0
             },
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
        {
            type: 'value',
            name: '温度',
            min: 0,
            max: 60,
            interval: 10,
            axisLabel: {
                formatter: '{value}'
            }
        }
    ],
    series: [
        {
            name: '最高温度',
            type: 'bar',
            barGap: 0,
           data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 80.6, 90.2, 32.6, 20.0, 6.4, 3.3]
        },
        {
            name: '最低温度',
            type: 'bar',
            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 78.6, 60.2, 48.7, 18.8, 6.0, 2.3]
        },
        {
            name: '环境温度',
            type: 'line',
            yAxisIndex: 1,
            smooth: true,  //true 为平滑曲线，false为直线
            data: [2.0, 2.2, 3.3, 4.5, 6.3, 20.2, 30.3, 43.4, 33.0, 26.5, 12.0, 6.2]
        }
    ]
};




* */
