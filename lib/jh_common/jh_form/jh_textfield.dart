/**
 *  jh_textfield.dart
 *
 *  Created by iotjin on 2020/02/18.
 *  description:  输入框（默认没有边框，宽充满屏幕，文字居左，默认显示1行，自动换行，最多5行，可设置键盘类型，右侧添加自定义widget，多行，最大长度，是否可编辑，文字样式）
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const int _maxLines = 5;   //最大行数
const int _maxLength = 100;  //最大录入长度
const Color _textColor = Colors.black;
const TextStyle _textStyle = TextStyle(fontSize: 15.0,color: _textColor);
const TextStyle _hintTextStyle = TextStyle(fontSize: 15.0,color: Color(0xFFBBBBBB)); //187

typedef _InputCallBack = void Function(String value);

class JhTextField extends StatefulWidget {

  final String text;
  final String hintText;
  final TextInputType keyboardType; //键盘类型，默认文字
  final FocusNode focusNode;
  final Widget leftWidget; //左侧widget ，默认隐藏
  final Widget rightWidget; //右侧widget ，默认隐藏
  final int maxLines; //最大行数，默认显示一行，自动换行，最多展示_maxLines 行
  final int maxLength; //最大长度，默认_maxLength
  final bool showMaxLength;//是否显示右侧最大长度文字，默认不显示
  final bool enabled; //是否可编辑，默认true
  final List<TextInputFormatter> inputFormatters;
  final _InputCallBack inputCallBack;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final TextAlign textAlign; //对齐方式，默认左对齐
  final InputBorder border; //边框样式，默认无边框

  const JhTextField({
    Key key,
    this.text: '',
    this.keyboardType: TextInputType.text,
    this.hintText: '请输入',
    this.focusNode,
    this.leftWidget,
    this.rightWidget,
    this.maxLines,
    this.maxLength:_maxLength,
    this.showMaxLength:false,
    this.enabled:true,
    this.inputFormatters,
    this.inputCallBack,
    this.textStyle = _textStyle,
    this.hintTextStyle= _hintTextStyle,
    this.textAlign= TextAlign.left,
    this.border = InputBorder.none, //去掉下划线
  }): super(key: key);

  @override
  _JhTextFieldState createState() => _JhTextFieldState();
}

class _JhTextFieldState extends State<JhTextField> {

  TextEditingController _textController;
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = TextEditingController();
    _textController.text = widget.text;
    _focusNode = widget.focusNode !=null ?widget.focusNode : FocusNode();

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    print("JhTextField dispose");
  }

  @override
  Widget build(BuildContext context) {

      return
        TextField(
          enabled: widget.enabled,
          focusNode: _focusNode,
          controller: _textController,
          keyboardType: widget.keyboardType,
          style: widget.textStyle,
          textAlign: widget.textAlign,
          minLines: widget.maxLines !=null ? widget.maxLines : 1,
          maxLines: widget.maxLines !=null ? widget.maxLines :_maxLines,
          maxLength: widget.showMaxLength ==true ? widget.maxLength:null,
          inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(widget.maxLength)],
          decoration: InputDecoration(
              prefixIcon: widget.leftWidget,
              suffixIcon:widget.rightWidget,
              hintText:  widget.hintText,
              hintStyle: widget.hintTextStyle,
              isDense: true,
              contentPadding: widget.border!=InputBorder.none ?EdgeInsets.symmetric(horizontal: 5, vertical: 8):EdgeInsets.fromLTRB(0, 8, 5, 8),
              border: widget.border
          ),
          onChanged: (value){
            if(widget.inputCallBack!=null){
              widget.inputCallBack(_textController.text);
            }
          },
        );

    }

}
