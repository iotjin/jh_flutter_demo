import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '/base_appbar.dart';

class EChartPage2 extends StatefulWidget {
  const EChartPage2({Key? key}) : super(key: key);

  @override
  State<EChartPage2> createState() => _EChartPage2State();
}

class _EChartPage2State extends State<EChartPage2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var value = ModalRoute.of(context)!.settings.arguments;
    value = value ?? '';
    return Scaffold(
      appBar: const BaseAppBar('EChart2 - 多图表'),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.yellow,
          child: const Text('往下滑动'),
        ),
        _initChart2(),
        Container(
          height: 500,
          width: double.infinity,
          color: Colors.yellow,
          child: const Text('往下滑动'),
        ),
        _initChart(),
        const Text('data'),
        const Text('data'),
        const Text('data'),
        const Text('data'),
        const Text('data'),
        const Text('data'),
      ],
    );
  }

  Widget _initChart2() {
    return Container(
      color: Colors.cyan,
      width: 500,
      height: 250,
      child: Echarts(
        reloadAfterInit: true,
        captureAllGestures: false,
        option: '''
                     {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            crossStyle: {
                                color: '#999'
                            }
                        }
                    },
                    toolbox: {
                        feature: {
                            dataView: {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            restore: {show: true},
                            saveAsImage: {show: true}
                        }
                    },
                    legend: {
                        data: ['蒸发量', '降水量', '平均温度']
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                            axisPointer: {
                                type: 'shadow'
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            name: '水量',
                            min: 0,
                            max: 250,
                            interval: 50,
                            axisLabel: {
                                formatter: '{value} ml'
                            }
                        },
                        {
                            type: 'value',
                            name: '温度',
                            min: 0,
                            max: 25,
                            interval: 5,
                            axisLabel: {
                                formatter: '{value} °C'
                            }
                        }
                    ],
                    series: [
                        {
                            name: '蒸发量',
                            type: 'bar',
                            data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
                        },
                        {
                            name: '降水量',
                            type: 'bar',
                            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
                        },
                        {
                            name: '平均温度',
                            type: 'line',
                            yAxisIndex: 1,
                            data: [2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
                        }
                    ]
                    }
                ''',
      ),
    );
  }

  Widget _initChart() {
    return SizedBox(
      width: 300,
      height: 250,
      child: Echarts(
        reloadAfterInit: true,
        captureAllGestures: false,
        option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    }
  ''',
      ),
    );
  }
}

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
        right: 100,
        icon: 'circle',
        itemWidth: 10,
        itemHeight: 10,
    },
    xAxis: [
        {
            type: 'category',
            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
            axisPointer: {
                type: 'shadow'
            }
        }
    ],
    yAxis: [
        {
            type: 'value',
            name: '摄氏度',
            axisLabel: {
                formatter: '{value}'
            }
        },
        {
            type: 'value',
            name: '温度',
            axisLabel: {
                formatter: '{value}'
            }
        }
    ],
    series: [
        {
            name: '最高温度',
            type: 'bar',
            data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
        },
        {
            name: '最低温度',
            type: 'bar',
            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
        },
        {
            name: '环境温度',
            type: 'line',
            yAxisIndex: 1,
            smooth: true,  //true 为平滑曲线，false为直线
            data: [2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
        }
    ]
};




* */
