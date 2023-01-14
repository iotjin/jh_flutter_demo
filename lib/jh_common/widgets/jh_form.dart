///  jh_form.dart
///
///  Created by iotjin on 2020/02/21.
///  description:  表单录入样式

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

const double _titleFontSize = 16.0; // 左侧字体大小
const double _infoFontSize = 15.0; // 右侧字体大小
const Color _textColor = Colors.black87;
const Color _inputBorderColor = Colors.grey; // 边框默认颜色
const double _titleSpace = 80.0; // 左侧title默认宽
const double _cellHeight = 50.0; // 输入、选择样式一行的高度
const double _inputCellHeight = 40.0; // 输入框、选择框高度
const Color _bgColor = Colors.transparent;
const Color _inputColor = Colors.transparent;

//const Color  _bgColor = Colors.orange;
//const Color  _inputColor = Colors.yellow;

typedef _InputCallBack = void Function(String value);
typedef _ClickCallBack = void Function();

/// 建议使用jh_form文件夹组件
class JhForm {
  /// 一行输入样式
  static Widget inputText({
    required String title,
    String inputInfo = '',
    String hintText = '请输入',
    FocusNode? focusNode,
    TextInputType keyboardType = TextInputType.text,
    double space = _titleSpace,
    _InputCallBack? inputCallBack,
  }) {
    return CreateInputCell(
      title: title,
      inputInfo: inputInfo,
      hintText: hintText,
      focusNode: focusNode!,
      keyboardType: keyboardType,
      space: space,
      inputCallBack: inputCallBack,
    );
  }

  /// 多行输入样式
  static Widget textView({
    String inputInfo = '',
    String hintText = '请输入',
    FocusNode? focusNode,
    bool showRedStar = false,
    _InputCallBack? inputCallBack,
  }) {
    return CreateTextViewCell(
      inputInfo: inputInfo,
      hintText: hintText,
      focusNode: focusNode!,
      showRedStar: showRedStar,
      inputCallBack: inputCallBack,
    );
  }

  /// 选择样式
  static Widget selectText({
    required String title,
    String selectInfo = '',
    String hintText = '请选择',
    double space = _titleSpace,
    _ClickCallBack? clickCallBack,
  }) {
    return CreateSelectTextCell(
      title: title,
      selectInfo: selectInfo,
      hintText: hintText,
      space: space,
      clickCallBack: clickCallBack,
    );
  }

  /// 三方键盘配置
  static KeyboardActionsConfig getKeyboardConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
        list.length,
        (i) => KeyboardActionsItem(
          focusNode: list[i],
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      width: 100,
                    ),
                    const Positioned(right: 15, child: Text('关闭')),
                  ],
                ),
              );
            },
          ],
        ),
      ),
    );
  }
}

class CreateInputCell extends StatefulWidget {
  const CreateInputCell({
    Key? key,
    required this.title,
    this.inputInfo,
    this.hintText,
    this.focusNode,
    this.keyboardType,
    this.space,
    this.inputCallBack,
  }) : super(key: key);

  final String title;
  final String? inputInfo;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final double? space;
  final _InputCallBack? inputCallBack;

  @override
  State<CreateInputCell> createState() => _CreateInputCellState();
}

class _CreateInputCellState extends State<CreateInputCell> {
  var inputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputController.text = widget.inputInfo!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      height: _cellHeight,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: widget.space,
            child: Text(widget.title, style: const TextStyle(fontSize: _titleFontSize, color: _textColor)),
          ),
          Expanded(
            child: Container(
              color: _inputColor,
              height: _inputCellHeight,
              child: TextField(
                controller: inputController,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                // 键盘类型
                maxLines: 1,
                style: const TextStyle(fontSize: _infoFontSize, color: _textColor),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.all(5),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: _inputBorderColor)),
                ),
                onChanged: (value) => widget.inputCallBack?.call(inputController.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateTextViewCell extends StatefulWidget {
  const CreateTextViewCell({
    Key? key,
    this.inputInfo,
    this.hintText,
    this.focusNode,
    this.showRedStar,
    this.inputCallBack,
  }) : super(key: key);

  final String? inputInfo;
  final String? hintText;
  final FocusNode? focusNode;
  final bool? showRedStar;
  final _InputCallBack? inputCallBack;

  @override
  State<CreateTextViewCell> createState() => _CreateTextViewCellState();
}

class _CreateTextViewCellState extends State<CreateTextViewCell> {
  var inputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputController.text = widget.inputInfo!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.showRedStar! ? '*' : '', style: const TextStyle(fontSize: 18.0, color: Colors.red)),
          SizedBox(
            width: widget.showRedStar! ? 5 : 0,
          ),
          Expanded(
            child: Container(
              color: _inputColor,
              child: TextField(
                controller: inputController,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.text,
                // 键盘类型
                maxLines: 5,
                style: const TextStyle(fontSize: _infoFontSize, color: _textColor),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.all(5),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: _inputBorderColor)),
                ),
                onChanged: (val) => widget.inputCallBack?.call(inputController.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateSelectTextCell extends StatefulWidget {
  const CreateSelectTextCell({
    Key? key,
    required this.title,
    this.selectInfo,
    this.hintText,
    this.space,
    this.clickCallBack,
  }) : super(key: key);

  final String? title;
  final String? selectInfo;
  final String? hintText;
  final double? space;
  final _ClickCallBack? clickCallBack;

  @override
  State<CreateSelectTextCell> createState() => _CreateSelectTextCellState();
}

class _CreateSelectTextCellState extends State<CreateSelectTextCell> {
  var selectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    selectController.text = widget.selectInfo!;

    return Container(
      color: _bgColor,
      height: _cellHeight,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: widget.space,
            child: Text(widget.title!, style: const TextStyle(fontSize: _titleFontSize, color: _textColor)),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
                height: _inputCellHeight,
//                        decoration: BoxDecoration(
//                          border: Border.all(width: 0.7, color: Colors.grey),
//                          color: Colors.transparent,
//                          borderRadius: BorderRadius.all(new Radius.circular(4.0)),
//                        ),
                child: TextField(
                  controller: selectController,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  enabled: false,
                  style: const TextStyle(fontSize: _infoFontSize, color: _textColor),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    contentPadding: const EdgeInsets.all(5),
                    border: const OutlineInputBorder(),
//                              border: InputBorder.none,
                    disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: _inputBorderColor)),
                  ),
                ),
              ),
              onTap: () => widget.clickCallBack?.call(),
            ),
          ),
        ],
      ),
    );
  }
}
