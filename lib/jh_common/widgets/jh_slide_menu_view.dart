///  jh_slide_menu_view.dart
///
///  Created by iotjin on 2022/11/19.
///  description: 水平滑动菜单(效果同拼多多首页、淘宝我的频道)

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/project/configs/colors.dart';

const double _sliderW = 20.0;
const double _sliderH = 4.0;
const double _sliderRadius = 2.0;
const double _sliderBgW = 40.0;
const Color _sliderBgColor = Color(0xFFD7D7DC);
const Color _sliderColor = Colors.red;

class JhSlideMenuView extends StatefulWidget {
  const JhSlideMenuView({
    Key? key,
    required this.data,
    this.maxRow = 2,
    this.maxColumn = 5,
    this.margin = 0.0,
    this.radius = 0.0,
    this.bgColor,
    this.isShowSlider = true,
    this.clickCallBack,
  }) : super(key: key);

  final List? data; // 功能菜单数组，格式：[{'text': '功能菜单名称','image': '功能菜单图片',}]
  final int maxRow; // 行数
  final int maxColumn; // 每行菜单个数
  final double margin; // 整体外边距
  final double radius; // 整体圆角
  final Color? bgColor; // 背景色
  final bool isShowSlider; // 是否显示底部滑块
  final Function(int selectIndex, dynamic selectItem)? clickCallBack;

  @override
  State<JhSlideMenuView> createState() => _JhSlideMenuViewState();
}

class _JhSlideMenuViewState extends State<JhSlideMenuView> {
  var _dataArr = [];
  final ScrollController _scrollController = ScrollController();
  double _offset = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dataArr = widget.data ?? [];
    // 监听滚动
    _scrollController.addListener(() {
      if (_scrollController.offset >= 0 && _scrollController.offset <= _scrollController.position.maxScrollExtent) {
        setState(() {
          _offset = (_sliderBgW - _sliderW) * _scrollController.offset / _scrollController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    var margin = widget.margin;
    var mainAxisExtent = (JhScreenUtils.screenWidth - margin * 2) / widget.maxColumn;
    var bgColor = widget.bgColor ?? KColors.dynamicColor(context, KColors.kCellBgColor, KColors.kCellBgDarkColor);
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(widget.radius)),
      child: Column(
        children: [
          SizedBox(
            height: mainAxisExtent * widget.maxRow * 1.0,
            width: JhScreenUtils.screenWidth,
            child: GridView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: mainAxisExtent,
                crossAxisCount: widget.maxRow, // 几行
              ),
              itemCount: _dataArr.length,
              itemBuilder: (context, index) {
                return _buildCell(mainAxisExtent, index);
              },
            ),
          ),
          Visibility(
            visible: widget.isShowSlider,
            child: Container(
              margin: const EdgeInsets.all(8),
              width: _sliderBgW,
              height: _sliderH,
              decoration: BoxDecoration(color: _sliderBgColor, borderRadius: BorderRadius.circular(_sliderRadius)),
              child: Stack(
                children: [
                  Positioned(
                    left: _offset,
                    child: Container(
                      width: _sliderW,
                      height: _sliderH,
                      decoration:
                          BoxDecoration(color: _sliderColor, borderRadius: BorderRadius.circular(_sliderRadius)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(mainAxisExtent, index) {
    var img = _dataArr[index]['image'];
    Widget imageWidget =
        img.startsWith('http') ? JhNetworkImage(img, fit: BoxFit.cover) : Image.asset(img, fit: BoxFit.cover);

    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 3),
          SizedBox(
            width: mainAxisExtent * 0.6,
            height: mainAxisExtent * 0.5,
            child: imageWidget,
          ),
          const SizedBox(height: 8),
          Text(_dataArr[index]['text'], style: const TextStyle(fontSize: 13)),
        ],
      ),
      onTap: () => widget.clickCallBack?.call(index, _dataArr[index]),
    );
  }
}
