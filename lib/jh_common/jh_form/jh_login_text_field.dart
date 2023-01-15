///  jh_login_text_field.dart
///
///  Created by iotjin on 2020/03/26.
///  description:  登录输入框

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/jh_common/utils/jh_color_utils.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';

const double _lineHeight = 0.8; // 底部线高
const double _textFontSize = 15.0;
const double _hintTextFontSize = 15.0;

/// 录入回调
typedef _InputCallBack = void Function(String value);

/// 录入完成回调（失去焦点或者点击键盘右下角按钮触发）
/// isSubmitted：是否通过onSubmitted方法触发
/// 直接使用回调范围更大，可判断外部三方键盘关闭按钮点击事件，如果有多个textField切换，也会走这个回调，按需使用
typedef _InputCompletionCallBack = void Function(String value, bool isSubmitted);

class JhLoginTextField extends StatefulWidget {
  const JhLoginTextField({
    Key? key,
    this.text = '',
    this.hintText = '',
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.isPwd = false,
    this.leftWidget,
    this.rightWidget,
    this.maxLength = 20,
    this.isShowDeleteBtn = false,
    this.inputFormatters,
    this.inputCallBack,
    this.inputCompletionCallBack,
    this.pwdOpen,
    this.pwdClose,
    this.border,
    this.isDense = false,
    this.contentPadding,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final String? labelText; // top提示文字
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction; // 键盘右下角按钮类型
  final FocusNode? focusNode;
  final bool isPwd; // 是否是密码，默认不是
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final int maxLength; // 最大长度，默认20
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter>? inputFormatters;
  final _InputCallBack? inputCallBack;
  final _InputCompletionCallBack? inputCompletionCallBack;
  final String? pwdOpen; // 自定义密码图片路径 睁眼
  final String? pwdClose; // 自定义密码图片路径 闭眼
  final InputBorder? border; // 边框样式
  final bool isDense; // 是否紧凑显示，默认false
  final EdgeInsetsGeometry? contentPadding; // 当父组件固定高度时，文本一行显示文本过多会出现文字显示不全bug,可设置EdgeInsets.symmetric(vertical: 4)

  @override
  State<JhLoginTextField> createState() => _JhLoginTextFieldState();
}

class _JhLoginTextFieldState extends State<JhLoginTextField> {
  TextEditingController? _textController;
  FocusNode? _focusNode;
  bool _isFocused = false;
  bool? _isShowDelete;
  bool? _isHiddenPwdBtn; // 是否隐藏 右侧密码明文切换按钮 ，密码样式才显示（isPwd =true），
  bool? _pwdShow; // 控制密码 明文切换
  Widget? _pwdImg; // 自定义密码图片
  bool _isSubmitted = false; // 记录是否点击键盘右下角按钮

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = widget.controller ?? TextEditingController();
    _textController!.text = widget.text ?? '';
    // 超过最大长度截取
    if ((widget.text ?? '').length > widget.maxLength) {
      _textController!.text = (widget.text ?? '').substring(0, widget.maxLength);
    }
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
      if (mounted) {
        setState(() {
          _isFocused = _focusNode!.hasFocus;
          _isShowDelete = _textController!.text.isNotEmpty && _focusNode!.hasFocus;
          // 录入完成回调，失去焦点并且不是点击键盘右下角时触发
          if (!_isFocused && !_isSubmitted) {
            widget.inputCompletionCallBack?.call(_textController!.text, false);
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant JhLoginTextField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    /// 更新text的值，并处理光标
    /// https://github.com/flutter/flutter/issues/11416
    var cursorPos = _textController!.selection;
    // 更新text值到_textController
    _textController!.text = widget.text ?? '';
    // 超过最大长度截取
    if ((widget.text ?? '').length > widget.maxLength) {
      _textController!.text = (widget.text ?? '').substring(0, widget.maxLength);
    }
    if (cursorPos.start > _textController!.text.length) {
      // 光标保持在文本最后
      cursorPos = TextSelection.fromPosition(TextPosition(offset: _textController!.text.length));
    }
    _textController!.selection = cursorPos;
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
    return _body();
  }

  _body() {
    if (widget.pwdOpen != null && widget.pwdClose != null) {
      if (widget.pwdOpen!.isNotEmpty && widget.pwdClose!.isNotEmpty) {
        _pwdImg = _pwdShow! ? ImageIcon(AssetImage(widget.pwdClose!)) : ImageIcon(AssetImage(widget.pwdOpen!));
      } else {
        _pwdImg = Icon(_pwdShow! ? Icons.visibility_off : Icons.visibility);
      }
    } else {
      _pwdImg = Icon(_pwdShow! ? Icons.visibility_off : Icons.visibility);
//      _pwdImg = _pwdShow?Image.asset('assets/images/ic_pwd_close.png',width: 18.0,):Image.asset('assets/images/ic_pwd_open.png',width: 18.0,);
//      _pwdImg = _pwdShow?ImageIcon(AssetImage('assets/images/ic_pwd_close.png')):ImageIcon(AssetImage('assets/images/ic_pwd_open.png')) ;
    }

    // 默认颜色
    var textColor = KColors.dynamicColor(context, KColors.kFormInfoColor, KColors.kFormInfoDarkColor);
    var textStyle = TextStyle(fontSize: _textFontSize, color: textColor);
    var hintColor = KColors.dynamicColor(context, KColors.kFormHintColor, KColors.kFormHintDarkColor);
    var hintTextStyle = TextStyle(fontSize: _hintTextFontSize, color: hintColor);
    var underlineColor = KColors.dynamicColor(context, Theme.of(context).primaryColor, KColors.kFocusedBorderDarkColor);

    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var labelTextStyle = TextStyle(fontSize: _hintTextFontSize, color: themeColor);

    return Theme(
      // 主题设置主要针对左侧图标和光标
      data: ThemeData(
        primaryColor: themeColor,
        primarySwatch: JhColorUtils.materialColor(themeColor),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: _isFocused ? themeColor : hintColor,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            focusNode: _focusNode,
            controller: _textController,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: textStyle,
//            // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
//            inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
//            [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
            inputFormatters: widget.inputFormatters ?? [LengthLimitingTextInputFormatter(widget.maxLength)],
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              prefixIcon: widget.leftWidget,
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintStyle: hintTextStyle,
              labelStyle: _isFocused ? labelTextStyle : hintTextStyle,
              isDense: widget.isDense,
              enabledBorder: widget.border ??
                  const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: _lineHeight)),
              focusedBorder: widget.border ??
                  UnderlineInputBorder(borderSide: BorderSide(color: underlineColor, width: _lineHeight)),
              // suffixIcon: Container(), //如果通过suffixIcon添加右侧自定义widget点击会弹出键盘
            ),
            obscureText: _pwdShow!,
            // 执行顺序为 onTap -> onChanged -> onEditingComplete -> onSubmitted
            // 点击输入框
            onTap: () {
              _isSubmitted = false;
            },
            // 每次输入框文字改变，均会执行
            onChanged: (value) {
              widget.inputCallBack?.call(_textController!.text);
            },
            // 输入完成，提交按钮点击后会先执行这里
            onEditingComplete: () {
              _focusNode!.unfocus();
            },
            // 提交按钮点击
            onSubmitted: (value) {
              _isSubmitted = true;
              widget.inputCompletionCallBack?.call(_textController!.text, true);
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                offstage: !widget.isShowDeleteBtn,
                child: _isShowDelete!
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Color(0xFFC8C8C8), size: 20),
                        onPressed: () {
                          _textController!.text = '';
                          if (widget.inputCallBack != null) {
                            widget.inputCallBack!(_textController!.text);
                          }
                        })
                    : const Text(''),
              ),
              Offstage(
                  offstage: _isHiddenPwdBtn!,
                  child: IconButton(
//                  icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
//                  icon: Image.asset('assets/images/ic_pwd_close.png',width: 18.0,),
                    icon: _pwdImg!,
                    color: const Color(0xFFC8C8C8),
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
//                      _textController.text = '';
//                      if(widget.inputCallBack!=null){
//                        widget.inputCallBack(_textController.text);
//                      }
//                    }
//                ): Text(''),
//                ),
//                Offstage( offstage: _isHiddenPwdBtn, child:
//                IconButton(
////                  icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
////                  icon: Image.asset('assets/images/ic_pwd_close.png',width: 18.0,),
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
