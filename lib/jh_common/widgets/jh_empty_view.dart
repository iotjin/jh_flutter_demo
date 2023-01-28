///  jh_empty_view.dart
///
///  Created by iotjin on 2022/09/21.
///  description: 空数据组件。暂无数据 和 网络加载失败两种

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const double _verticalTop = 40.0;
const double _space = 20.0; // 控件垂直间距
const double _btnBorderRadius = 20.0; // 边框圆角
const double _textFontSize = 16.0; // 文字大小
const double _btnFontSize = 17.0; // 按钮文字大小

const String _emptyText = '暂无数据';
const String _networkErrorText = '网络不给力，点击重新加载';
const String _btnTitle = '点击重试'; // 重新加载
const String _emptyImagePath = 'assets/images/common/empty/ic_empty.png';
const String _networkErrorImagePath = 'assets/images/common/empty/ic_netErr.png';

enum EmptyType { empty, error, loading }

class JhEmptyView extends StatefulWidget {
  const JhEmptyView({
    Key? key,
    this.type = EmptyType.empty,
    this.image,
    this.text,
    this.btnTitle = _btnTitle,
    this.verticalTop = _verticalTop,
    this.space = _space,
    this.clickCallBack,
  }) : super(key: key);

  final EmptyType type; // 空数据类型
  final String? image; // 空数据图片,不传根据类型显示默认图片
  final String? text; // 描述文字,不传根据类型显示默认文字
  final String btnTitle; // 当类型为error时，显示按钮
  final double verticalTop; // margin top
  final double space; // 垂直间距
  final VoidCallback? clickCallBack; // 按钮点击回调

  @override
  State<JhEmptyView> createState() => _JhEmptyViewState();
}

class _JhEmptyViewState extends State<JhEmptyView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    var image = widget.image ?? (widget.type == EmptyType.error ? _networkErrorImagePath : _emptyImagePath);
    var text = widget.text ?? (widget.type == EmptyType.error ? _networkErrorText : _emptyText);
    // 默认颜色
    var textColor = const Color(0xFFB1BBC3);
    var bgColor = KColors.kThemeColor;

    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    // 按钮背景色
    bgColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    var empty = Container(
      padding: EdgeInsets.only(top: widget.verticalTop, bottom: 20),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image.isNotEmpty ? Image.asset(image) : Container(),
          SizedBox(height: image.isNotEmpty ? widget.space : 0),
          Text(text, style: TextStyle(fontSize: _textFontSize, color: textColor)),
          SizedBox(height: widget.type == EmptyType.error ? widget.space : 0),
          Visibility(
            visible: widget.type == EmptyType.error,
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(_btnBorderRadius)),
                child: Center(
                  child: Text(widget.btnTitle, style: const TextStyle(fontSize: _btnFontSize, color: Colors.white)),
                ),
              ),
              onTap: () => widget.clickCallBack?.call(),
            ),
          ),
        ],
      ),
    );

    return empty;
  }
}
