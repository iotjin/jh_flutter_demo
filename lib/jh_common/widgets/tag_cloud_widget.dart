///  tag_cloud_widget.dart
///
///  Created by iotjin on 2020/07/10.
///  description:  标签云

// ignore_for_file: unused_element, unnecessary_import

import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Color _borderColor = Colors.red;
const Color _textColorRow1 = Colors.white;
const Color _textColorRow2 = Colors.yellow;
const double _fontSize = 12.0;
const double _borderRadius = 10.0;
const double _borderWidth = 1.0;

const Color _bgColor = Colors.blue;
const Color _shadowColor = Colors.yellow;
const double _blurRadius = 10.0;
const double _spreadRadius = 10.0;

const double _rpm = 4; // 旋转速度

const double _widgetWidth = 300;

class Point {
  double x, y, z;
  Color color;

  Point(this.x, this.y, this.z, {this.color = _borderColor});
}

class TagCloudWidget extends StatefulWidget {
  const TagCloudWidget(
    this.width,
    this.dataArr, {
    Key? key,
    this.rpm = _rpm,
  }) : super(key: key);

  final double width, rpm; // rpm 每分钟圈数
  final List dataArr;

  @override
  State<TagCloudWidget> createState() => _TagCloudWidgetState();
}

class _TagCloudWidgetState extends State<TagCloudWidget> with SingleTickerProviderStateMixin {
  Animation<double>? rotationAnimation;
  AnimationController? animationController;
  List<Point>? points;

  int pointsCount = 0; // 标签数量

  double? radius, // 球体半径
      angleDelta,
      prevAngle = 0.0;
  Point rotateAxis = Point(0, 1, 0); // 初始为Y轴

  @override
  void initState() {
    super.initState();
    pointsCount = widget.dataArr.length; // 标签数量
    radius = widget.width / 2;
    points = _generateInitialPoints();
    animationController = AnimationController(
      vsync: this,
      // 按rpm，转/每分来计算旋转速度
      duration: Duration(seconds: 60 ~/ widget.rpm),
    );
    rotationAnimation = Tween(begin: 0.0, end: pi * 2).animate(animationController!)
      ..addListener(() {
        setState(() {
          var angle = rotationAnimation!.value;
          angleDelta = angle - prevAngle!; // 这段时间内旋转过的角度
          prevAngle = angle;
          // 按angleDelta旋转标签到新的位置
          _rotatePoints(points!, rotateAxis, angleDelta!);
        });
      });
    animationController!.repeat();
  }

  @override
  didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      animationController!.duration = Duration(seconds: 60 ~/ widget.rpm);
      if (animationController!.isAnimating) animationController!.repeat();
    });
  }

  _stopAnimation() {
    if (animationController!.isAnimating) {
      animationController!.stop();
    } else {
      animationController!.repeat();
    }
  }

  _generateInitialPoints() {
    // 生产初始点
    var floatingOffset = 15; // 漂浮距离，越大漂浮感越强
    var radius = widget.width / 2 + floatingOffset;
    List<Point> points = [];
    for (var i = 0; i < pointsCount; i++) {
      double x = 1 * Random().nextDouble() * (Random().nextBool() == true ? 1 : -1);
      double remains = sqrt(1 - x * x);

      double y = remains * Random().nextDouble() * (Random().nextBool() == true ? 1 : -1);

      double z = sqrt(1 - x * x - y * y) * (Random().nextBool() == true ? 1 : -1);

      points.add(Point(x * radius, y * radius, z * radius,
          color: Color.fromRGBO(
            (x.abs() * 256).ceil(),
            (y.abs() * 256).ceil(),
            (z.abs() * 256).ceil(),
            1,
          )));
    }

    return points;
  }

  _rotatePoints(List<Point> points, Point axis, double angle) {
    // 罗德里格旋转矢量公式
    // 计算点 x,y,z 绕轴axis转动angle角度后的新坐标

    // 预先缓存不变值，如sin，cos等，避免重复计算
    var a = axis.x,
        b = axis.y,
        c = axis.z,
        a2 = a * a,
        b2 = b * b,
        c2 = c * c,
        ab = a * b,
        ac = a * c,
        bc = b * c,
        sinA = sin(angle),
        cosA = cos(angle);
    for (var point in points) {
      var x = point.x, y = point.y, z = point.z;
      point.x = (a2 + (1 - a2) * cosA) * x + (ab * (1 - cosA) - c * sinA) * y + (ac * (1 - cosA) + b * sinA) * z;
      point.y = (ab * (1 - cosA) + c * sinA) * x + (b2 + (1 - b2) * cosA) * y + (bc * (1 - cosA) - a * sinA) * z;
      point.z = (ac * (1 - cosA) - b * sinA) * x + (bc * (1 - cosA) + a * sinA) * y + (c2 + (1 - c2) * cosA) * z;
    }
    return points;
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return GestureDetector(
      onPanUpdate: (dragUpdateDetails) {
        // 滑动球体改变旋转轴
        // dx为滑动过的x轴距离，可有正负值
        // dy为滑动过的y轴距离，可有正负值
        var dx = dragUpdateDetails.delta.dx, dy = dragUpdateDetails.delta.dy;
        // 正则化，使轴向量长度为1
        var sqrtxy = sqrt(dx * dx + dy * dy);
        // 避免除0
        if (sqrtxy > 4) rotateAxis = Point(-dy / sqrtxy, dx / sqrtxy, 0);
      },
      child: Stack(
        children: <Widget>[
          // 球体，添加了边界阴影
          Container(
              height: radius! * 2,
              decoration: BoxDecoration(color: _bgColor, shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: _shadowColor.withOpacity(0.9), blurRadius: _blurRadius, spreadRadius: _spreadRadius),
              ])),
          // 每个点
          CustomPaint(
            size: Size(radius! * 2, radius! * 2),
            painter: TagsPainter(points!, widget.dataArr),
          )
        ],
      ),
    );
  }
}

class TagsPainter extends CustomPainter {
  List<Point> points;
  List dataArr;
  double radius = 16;
  double prevX = 0;
  var paintStyle = Paint()
    ..color = _borderColor
    ..style = PaintingStyle.stroke;

  TagsPainter(this.points, this.dataArr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.width / 2);

    for (var i = 0; i < dataArr.length; i++) {
      var data = dataArr[i];
      var point = points[i];

      // TextPainter 富文本 加边框
      var text = TextPainter(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '${data['name']}\n',
              style: const TextStyle(fontSize: _fontSize, color: _textColorRow1),
              children: <TextSpan>[
                TextSpan(
                    text: data['num'],
                    style: const TextStyle(fontSize: _fontSize, color: _textColorRow2),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // print('===测试暂时有误，待研究==');
                      }),
              ]),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: 200, minWidth: 80)
        ..paint(canvas, Offset(point.x, point.y));

      paintStyle.strokeWidth = _borderWidth;

      //  正方形
//      canvas.drawRect(Rect.fromCircle(center:Offset(point.x+text.width/2, point.y+20),radius:text.width/2), paintStyle);
      // 长方形
//      canvas.drawRect(Rect.fromCenter(center:Offset(point.x+text.width/2, point.y+15),width: text.width,height: 50), paintStyle);

      // 圆角矩形
      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(point.x + text.width / 2, point.y + 15), width: text.width, height: 50),
            const Radius.circular(_borderRadius),
          ),
          paintStyle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

double _getOpacity(double z) {
//  根据z坐标设置透明度, 制造距离感
  // 在正面为1，背面最低0.1
  return z > 0 ? 1 : (1 + z) * 0.9 + 0.1;
}

double _getScale(double z) {
  // 使用z坐标设置标签大小，制造距离感
  // 从[-1,1]区间转移到[1/4,1]区间
  // 背面最小时为正面1/16大小
  return z * 3 / 8 + 5 / 8;
}
