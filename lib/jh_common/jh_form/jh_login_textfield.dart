///  jh_login_textfield.dart
///
///  Created by iotjin on 2020/03/26.
///  description:  登录输入框

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/jh_common/utils/jh_color_utils.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const double _lineHeight = 0.8; // 底部线高
const double _textFontSize = 15.0;
const double _hintTextFontSize = 15.0;

typedef _InputCallBack = void Function(String value);

class JhLoginTextField extends StatefulWidget {
  const JhLoginTextField({
    Key? key,
    this.text: '',
    this.keyboardType: TextInputType.text,
    this.hintText: '',
    this.labelText,
    this.controller,
    this.focusNode,
    this.isPwd = false,
    this.leftWidget,
    this.rightWidget,
    this.maxLength: 20,
    this.isShowDeleteBtn = false,
    this.inputFormatters,
    this.inputCallBack,
    this.pwdOpen,
    this.pwdClose,
    this.border,
    this.isDense: false,
  }) : super(key: key);

  final String text;
  final String hintText;
  final String? labelText; // top提示文字
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool isPwd; // 是否是密码，默认不是
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final int maxLength; // 最大长度，默认20
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter>? inputFormatters;
  final _InputCallBack? inputCallBack;
  final String? pwdOpen; // 自定义密码图片路径 睁眼
  final String? pwdClose; // 自定义密码图片路径 闭眼
  final InputBorder? border; // 边框样式
  final bool isDense; // 是否紧凑显示，默认false

  @override
  _JhLoginTextFieldState createState() => _JhLoginTextFieldState();
}

class _JhLoginTextFieldState extends State<JhLoginTextField> {
  TextEditingController? _textController;
  FocusNode? _focusNode;
  bool _isFocused = false;
  bool? _isShowDelete;
  bool? _isHiddenPwdBtn; // 是否隐藏 右侧密码明文切换按钮 ，密码样式才显示（isPwd =true），
  bool? _pwdShow; // 控制密码 明文切换
  Widget? _pwdImg; // 自定义密码图片

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = widget.controller ?? TextEditingController();
    _textController!.text = widget.text;
    _focusNode = widget.focusNode ?? FocusNode();
    _isHiddenPwdBtn = !widget.isPwd;
    _pwdShow = widget.isPwd;

    _isShowDelete = _focusNode!.hasFocus && _textController!.text.isNotEmpty;
    _textController!.addListener(() {
      setState(() {
        _isShowDelete = _textController!.text.isNotEmpty && _focusNode!.hasFocus;
      });
    });
    _focusNode!.addListener(() {
      setState(() {
        _isFocused = _focusNode!.hasFocus;
        _isShowDelete = _textController!.text.isNotEmpty && _focusNode!.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant JhLoginTextField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    // 更新text值到_textController
    _textController!.text = widget.text;
    // 光标保持在文本最后
    _textController!.selection = TextSelection.fromPosition(
      TextPosition(offset: _textController!.text.length),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _focusNode!.unfocus();
    _textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pwdOpen != null && widget.pwdClose != null) {
      if (widget.pwdOpen!.isNotEmpty && widget.pwdClose!.isNotEmpty) {
        _pwdImg = _pwdShow! ? ImageIcon(AssetImage(widget.pwdClose!)) : ImageIcon(AssetImage(widget.pwdOpen!));
      } else {
        _pwdImg = Icon(_pwdShow! ? Icons.visibility_off : Icons.visibility);
      }
    } else {
      _pwdImg = Icon(_pwdShow! ? Icons.visibility_off : Icons.visibility);
//      _pwdImg = _pwdShow?Image.asset("assets/images/ic_pwd_close.png",width: 18.0,):Image.asset("assets/images/ic_pwd_open.png",width: 18.0,);
//      _pwdImg = _pwdShow?ImageIcon(AssetImage("assets/images/ic_pwd_close.png")):ImageIcon(AssetImage("assets/images/ic_pwd_open.png")) ;
    }

    // 默认颜色
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? KColors.kFormInfoDarkColor : KColors.kFormInfoColor;
    var _textStyle = TextStyle(fontSize: _textFontSize, color: textColor);
    var hintColor = isDark ? KColors.kFormHintDarkColor : KColors.kFormHintColor;
    var _hintTextStyle = TextStyle(fontSize: _hintTextFontSize, color: hintColor);
    var _underlineColor = isDark ? KColors.kFocusedBorderDarkColor : Theme.of(context).primaryColor;

    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var _themeColor = provider.isDark() ? KColors.kThemeColor : provider.getThemeColor();
    var _labelTextStyle = TextStyle(fontSize: _hintTextFontSize, color: _themeColor);

    return Theme(
      // 主题设置主要针对左侧图标和光标
      data: new ThemeData(
        primaryColor: _themeColor,
        primarySwatch: JhColorUtils.materialColor(_themeColor),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: _isFocused ? _themeColor : hintColor,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            focusNode: _focusNode,
            controller: _textController,
            keyboardType: widget.keyboardType,
            style: _textStyle,
//            // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
//            inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
//            [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
            inputFormatters: widget.inputFormatters != null
                ? widget.inputFormatters
                : [LengthLimitingTextInputFormatter(widget.maxLength)],
            decoration: InputDecoration(
              prefixIcon: widget.leftWidget,
              labelText: widget.labelText != null ? widget.labelText : null,
              hintText: widget.hintText,
              hintStyle: _hintTextStyle,
              labelStyle: _isFocused ? _labelTextStyle : _hintTextStyle,
              isDense: widget.isDense,
              enabledBorder: widget.border != null
                  ? widget.border
                  : UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: _lineHeight)),
              focusedBorder: widget.border != null
                  ? widget.border
                  : UnderlineInputBorder(borderSide: BorderSide(color: _underlineColor, width: _lineHeight)),
              // suffixIcon: Container(), //如果通过suffixIcon添加右侧自定义widget点击会弹出键盘
            ),
            obscureText: _pwdShow!,
            onChanged: (value) {
              if (widget.inputCallBack != null) {
                widget.inputCallBack!(_textController!.text);
              }
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                offstage: !widget.isShowDeleteBtn,
                child: _isShowDelete!
                    ? IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Color(0xFFC8C8C8),
                          size: 20,
                        ),
                        onPressed: () {
                          _textController!.text = "";
                          if (widget.inputCallBack != null) {
                            widget.inputCallBack!(_textController!.text);
                          }
                        })
                    : Text(""),
              ),
              Offstage(
                  offstage: _isHiddenPwdBtn!,
                  child: IconButton(
//                  icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
//                  icon: Image.asset("assets/images/ic_pwd_close.png",width: 18.0,),
                    icon: _pwdImg!,
                    iconSize: 18.0,
                    onPressed: () {
                      setState(() {
                        _pwdShow = !_pwdShow!;
                      });
                    },
                  )),
              widget.rightWidget ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}

/* 以下代码添加右侧自定义widget点击会弹出键盘 */

//      TextField(
//        focusNode: _focusNode,
//        controller: _textController,
//        keyboardType: widget.keyboardType,
//        style: _textStyle,
//        inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(20)],
//        decoration: InputDecoration(
//          hintText:  widget.hintText,
//          hintStyle: _hintTextStyle,
//          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
//          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 0.5)),
//          prefixIcon: widget.leftWidget,
//          suffixIcon:
//          Container(
//            child: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Offstage(offstage: !widget.isShowDeleteBtn, child:
//                _isShowDelete
//                    ? IconButton(icon: Icon(Icons.cancel,color: Color(0xFFC8C8C8),size: 20,),
//                    onPressed: (){
//                      _textController.text = "";
//                      if(widget.inputCallBack!=null){
//                        widget.inputCallBack(_textController.text);
//                      }
//                    }
//                ): Text(""),
//                ),
//                Offstage( offstage: _isHiddenPwdBtn, child:
//                IconButton(
////                  icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
////                  icon: Image.asset("assets/images/ic_pwd_close.png",width: 18.0,),
//                  icon: _pwdImg,
//                  iconSize: 18.0 ,
//                  onPressed: () {
//                    setState(() {
//                      _pwdShow = !_pwdShow;
//                    });
//                  },
//                )
//                ),
//                widget.rightWidget!=null?widget.rightWidget:Container(),
//
//              ],
//            ),
//          ),
//        ),
//        obscureText: _pwdShow,
//        onChanged: (value){
//          if(widget.inputCallBack!=null){
//            widget.inputCallBack(_textController.text);
//          }
//        },
//      );
