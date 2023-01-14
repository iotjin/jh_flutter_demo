// ignore_for_file: unused_import, unnecessary_import, unused_element
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/base_appbar.dart';

class Point {
  double x, y, z;
  Color color;
  String? name;

  List<ui.Paragraph>? paragraphs;

  Point(this.x, this.y, this.z, {this.color = Colors.red});

  getParagraph(int radius) {
    int index = (z + radius).round() ~/ 3;
    return paragraphs![index];
  }
}

class Ball3DPage4 extends StatefulWidget {
  const Ball3DPage4({Key? key}) : super(key: key);

  @override
  State<Ball3DPage4> createState() => _DBallPage4State();
}

class _DBallPage4State extends State<Ball3DPage4> {
  double rpm = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('3D球 - 圆形阴影'),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return TagCloud(constraints.maxWidth, constraints.maxHeight, rpm: rpm);
            }),
          ),
          const Text(
            '滑动球体可以改变转动方向\n滑动条可以改变转动速度',
            style: TextStyle(color: Colors.black, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          Container(
            color: Colors.white,
            child: Slider(
                value: rpm,
                min: 0,
                max: 10,
                onChanged: (value) {
                  setState(() {
                    rpm = value;
                  });
                }),
          ),
        ]),
      ),
    );
  }
}

class TagCloud extends StatefulWidget {
  const TagCloud(
    this.width,
    this.height, {
    Key? key,
    this.rpm = 3,
  }) : super(key: key);
  final double width, height, rpm; //rpm 每分钟圈数

  @override
  State<TagCloud> createState() => _TagCloudState();
}

class _TagCloudState extends State<TagCloud> with SingleTickerProviderStateMixin {
  Animation<double>? rotationAnimation;
  AnimationController? animationController;
  List<Point>? points;
  int pointsCount = 6; //标签数量
  double? radius, //球体半径
      angleDelta,
      prevAngle = 0.0;
  Point rotateAxis = Point(0, 1, 0); //初始为Y轴

  @override
  void initState() {
    super.initState();
    radius = widget.width / 2;
    points = _generateInitialPoints();
    animationController = AnimationController(
      vsync: this,
      //按rpm，转/每分来计算旋转速度
      duration: Duration(seconds: 60 ~/ widget.rpm),
    );
    rotationAnimation = Tween(begin: 0.0, end: pi * 2).animate(animationController!)
      ..addListener(() {
        setState(() {
          var angle = rotationAnimation!.value;
          angleDelta = angle - prevAngle!; //这段时间内旋转过的角度
          prevAngle = angle;
          //按angleDelta旋转标签到新的位置
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
    //生产初始点
    var floatingOffset = 15; //漂浮距离，越大漂浮感越强
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
    //罗德里格旋转矢量公式
    //计算点 x,y,z 绕轴axis转动angle角度后的新坐标

    //预先缓存不变值，如sin，cos等，避免重复计算
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

  _buildPainter(points) {
    return CustomPaint(
      size: Size(radius! * 2, radius! * 2),
      painter: TagsPainter(points),
    );
  }

  _buildBody() {
    List<Widget> children = [];
    //球体，添加了边界阴影
    var sphere = Container(
        height: radius! * 2,
        decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle, boxShadow: [
          BoxShadow(
//                  color: Colors.white.withOpacity(0.9),
              color: Colors.yellow,
              blurRadius: 30.0,
              spreadRadius: 10.0),
        ]));

    children.add(sphere);
    children.add(_buildPainter(points));

    return GestureDetector(
      onPanUpdate: (dragUpdateDetails) {
        //滑动球体改变旋转轴
        //dx为滑动过的x轴距离，可有正负值
        //dy为滑动过的y轴距离，可有正负值
        var dx = dragUpdateDetails.delta.dx, dy = dragUpdateDetails.delta.dy;
        //正则化，使轴向量长度为1
        var sqrtxy = sqrt(dx * dx + dy * dy);
        //避免除0
        if (sqrtxy > 4) rotateAxis = Point(-dy / sqrtxy, dx / sqrtxy, 0);
      },
      child: Stack(
        children: children,
      ),
    );
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
}

class TagsPainter extends CustomPainter {
  List<Point> points;
  double radius = 16;
  double prevX = 0;
  var paintStyle = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  TagsPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.width / 2);
    for (var point in points) {
//       /********************************* canvas  绘制球 ********************************/
//      // canvas  绘制球
//      var opacity = _getOpacity(point.z / size.width * 2);
//      paintStyle.color = point.color.withOpacity(opacity);
//      paintStyle.style = PaintingStyle.fill;
//      var r = _getScale(point.z / size.width * 2) * radius;
//      canvas.drawCircle(Offset(point.x, point.y), r, paintStyle);

//        /********************************* canvas  绘制文字 ********************************/
//      // canvas  绘制文字
//      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
//        textAlign: TextAlign.center,
//        fontWeight: FontWeight.w300,
//        fontStyle: FontStyle.normal,
//        fontSize: 12.0,
//      ));
//      pb.pushStyle(
//        ui.TextStyle(fontSize: 15, color: Colors.red),
//      );
//      pb.addText('ABCDE');
//      ParagraphConstraints pc = ParagraphConstraints(width: 30);
////这里需要先layout, 后面才能获取到文字高度
//      Paragraph paragraph = pb.build()..layout(pc);
//      canvas.drawParagraph(paragraph, Offset(point.x, point.y));

//      /********************************* TextPainter 富文本 ********************************/
//      // TextPainter  富文本
//      TextPainter(
//          text: TextSpan(
//              text: '这是文字',
//              style: TextStyle(fontSize: 13.0, color: Colors.white)),
//          textDirection: TextDirection.ltr)
//        ..layout(maxWidth: 100, minWidth: 50)
//        ..paint(canvas, Offset(point.x, point.y));

//      /********************************* TextPainter 富文本 多个 ********************************/
//      // TextPainter 富文本 多个
//      TextPainter(
//          text: TextSpan(
//              text: '这是',
//              style: TextStyle(fontSize: 13.0, color: Colors.white),
//              children: <TextSpan>[
//                TextSpan(
//                    text: '红色',
//                    style: TextStyle(fontSize: 18.0, color: Colors.red)),
//                TextSpan(
//                    text: '黑色',
//                    style: TextStyle(fontSize: 12.0, color: Colors.black),
////                    recognizer: TapGestureRecognizer()
////                      ..onTap = () {
////                        print('===测试暂时有误，待研究==');
////                      }
//                    recognizer: new TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
//                ),
//              ]),
//          textDirection: TextDirection.ltr)
//        ..layout(maxWidth: 100, minWidth: 50)
//        ..paint(canvas, Offset(point.x, point.y));

//      /******************************** canvas 文字 加边框 长方形 *********************************/

//      // canvas  绘制文字
//      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
//        textAlign: TextAlign.center,
//        fontWeight: FontWeight.w300,
//        fontStyle: FontStyle.normal,
//        fontSize: 12.0,
//      ));
//      pb.pushStyle(
//        ui.TextStyle(fontSize: 12, color: Colors.white),
//      );
//      pb.addText('这是文字文字 \n ');
//      pb.addText('FF');
//      ParagraphConstraints pc = ParagraphConstraints(width: 90);
//      Paragraph paragraph = pb.build()..layout(pc);
//      canvas.drawParagraph(paragraph, Offset(point.x, point.y));
//
//      // 长方形
//      canvas.drawRect(Rect.fromCenter(center:Offset(point.x+pc.width/2, point.y+15),width: pc.width,height: 50), paintStyle);

      /******************************** TextPainter 富文本 加边框  *********************************/

      // TextPainter 富文本 多个
      var text = TextPainter(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '这是文字文字\n',
              style: const TextStyle(fontSize: 12.0, color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                    text: 'AA',
                    style: const TextStyle(fontSize: 12.0, color: Colors.yellow),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('===测试暂时有误，待研究==');
                      }),
              ]),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: 200, minWidth: 80)
        ..paint(canvas, Offset(point.x, point.y));

      //  正方形
//      canvas.drawRect(Rect.fromCircle(center:Offset(point.x+text.width/2, point.y+20),radius:text.width/2), paintStyle);

      //长方形
//      canvas.drawRect(Rect.fromCenter(center:Offset(point.x+text.width/2, point.y+15),width: text.width,height: 50), paintStyle);

//      //圆角矩形1
//      paintStyle.strokeWidth = 1.0;
//      canvas.drawRRect(
//          RRect.fromRectAndRadius(
//            Rect.fromCenter(center: Offset(point.x + text.width / 2, point.y + 15), width: text.width, height: 50),
//            Radius.circular(10)
//          ),
//          paintStyle);

//      //圆角矩形 2
//      //用Rect构建一个边长50,中心点坐标为100,100的矩形
//      Rect rect = Rect.fromCircle(center: Offset(point.x + text.width / 2, point.y + 15), radius: 50);
//      //根据上面的矩形,构建一个圆角矩形
//      RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(20));
//      canvas.drawRRect(rrect, paintStyle);

      //圆形加阴影
      Color circleColor = Colors.red;
      Offset offset = Offset(point.x + text.width / 2, point.y + 15);
      double tempRadius = 50.0;
      Path circlePath = Path();
      circlePath.reset();
      circlePath.addArc(Rect.fromCircle(center: offset, radius: tempRadius), 0, 2 * pi);
      circlePath.close();
      var circleShader = RadialGradient(colors: [
        Colors.white.withAlpha(0),
        Colors.white.withAlpha(0),
        circleColor.withAlpha(0),
        circleColor.withAlpha(0),
        circleColor.withOpacity(0.1),
        circleColor.withOpacity(0.6),
      ]).createShader(Rect.fromCircle(center: offset, radius: tempRadius));
      canvas.drawPath(
          circlePath,
          paintStyle
            ..style = PaintingStyle.fill
            ..shader = circleShader
            ..strokeWidth = 15);

      //圆形加阴影 通过多画几圈假装阴影效果
//      Color circleColor = Colors.red;
//      Offset offset = Offset(point.x + text.width / 2, point.y + 15);
//
//      double tempRadius = 50.0;
//      var tempW = 10;
//      for (var i = 0; i < 10; i++) {
//        tempRadius = tempRadius -1.0;
//        tempW = tempW - 1;
//        double w= tempW/10.0;
//        var paint1 = Paint()
//          ..strokeWidth = w-0.05
//          ..color = circleColor.withOpacity(w)
//          ..style = PaintingStyle.stroke;
//        Rect rect1 = Rect.fromCircle(center: offset, radius: tempRadius);
//        RRect rrect1 = RRect.fromRectAndRadius(rect1, Radius.circular(tempRadius));
//        canvas.drawRRect(rrect1, paint1);
//
//        var paint2 = Paint()
//          ..strokeWidth = w-0.10
//          ..color = circleColor.withOpacity(w)
//          ..style = PaintingStyle.stroke;
//        Rect rect2 = Rect.fromCircle(center: offset, radius: tempRadius);
//        RRect rrect2 = RRect.fromRectAndRadius(rect2, Radius.circular(tempRadius));
//        canvas.drawRRect(rrect2, paint2);
//      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

double _getOpacity(double z) {
//  根据z坐标设置透明度, 制造距离感
  //在正面为1，背面最低0.1
  return z > 0 ? 1 : (1 + z) * 0.9 + 0.1;
}

double _getScale(double z) {
  //使用z坐标设置标签大小，制造距离感
  //从[-1,1]区间转移到[1/4,1]区间
  //背面最小时为正面1/16大小
  return z * 3 / 8 + 5 / 8;
}
