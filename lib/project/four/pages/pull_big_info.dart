import 'dart:math';

import 'package:flutter/material.dart';

enum SVDragState {
  SVDragStateIdle,
  SVDragStateBegin,
  SVDrageStateEnd,
}

class SVPersonalInfoPage extends StatefulWidget {
  @override
  _SVPersonalInfoPageState createState() => _SVPersonalInfoPageState();
}

class _SVPersonalInfoPageState extends State<SVPersonalInfoPage> {
  double startOffsetY;
  static double defaultHeight = 150;
  static double maxHeight = 600.0;
  static double offsetY = 0;
  static double distance = maxHeight - defaultHeight;
  SVDragState dragState = SVDragState.SVDragStateIdle;
  final ScrollController controller =
      ScrollController(initialScrollOffset: distance);

  @override
  void initState() {
    controller.addListener(() {
      offsetY = controller.offset;
      if (offsetY <= 0) {
        controller.jumpTo(0);
        _resetWithAnimation(true);
      }
    });

    super.initState();
  }

  _resetWithAnimation(bool delay) {
    if (!delay) {
      if (controller.offset < distance &&
          dragState == SVDragState.SVDrageStateEnd) {
        dragState = SVDragState.SVDragStateIdle;
        controller.animateTo(distance,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        return;
      }
    }
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      if (controller.offset < distance &&
          dragState == SVDragState.SVDrageStateEnd) {
        dragState = SVDragState.SVDragStateIdle;
        controller.animateTo(distance,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (e) {
          dragState = SVDragState.SVDragStateBegin;
        },
        onPointerUp: (e) {
          dragState = SVDragState.SVDrageStateEnd;
          _resetWithAnimation(false);
        },
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: _SVPersonalAppBarDelegate(
                  minHeight: defaultHeight,
                  maxHeight: maxHeight,
                  child: _createImageWidget()),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  child: Text(
                    "This is item $index",
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Colors.redAccent,
                );
              },
            ))
          ],
        ));
  }

  _createImageWidget() {
    return Container(
      child: Image.network(
        'https://pic4.zhimg.com/80/v2-b02e601349241df0e3f25fd1ec622155_1440w.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SVPersonalAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SVPersonalAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SVPersonalAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
