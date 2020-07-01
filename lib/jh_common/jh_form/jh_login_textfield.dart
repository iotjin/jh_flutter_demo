/**
 *  jh_login_textfield.dart
 *
 *  Created by iotjin on 2020/03/26.
 *  description:  登录输入框
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


const Color _textColor = Colors.black;
const TextStyle _textStyle = TextStyle(fontSize: 15.0,color: _textColor);
const TextStyle _hintTextStyle = TextStyle(fontSize: 15.0,color: Color(0xFFBBBBBB));

typedef _InputCallBack = void Function(String value);

class JhLoginTextField extends StatefulWidget {

  final String text;
  final String hintText;
  final String labelText;//top提示文字
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final bool isPwd; //是否是密码，默认不是
  final Widget leftWidget; //左侧widget ，默认隐藏
  final Widget rightWidget; //右侧widget ，默认隐藏
  final int maxLength; //最大长度，默认20
  final bool isShowDeleteBtn;  //是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter> inputFormatters;
  final _InputCallBack inputCallBack;
  final String pwdOpen; //自定义密码图片路径 睁眼
  final String pwdClose;//自定义密码图片路径 闭眼
  final InputBorder border; //边框样式
  final bool isDense; //是否紧凑显示，默认false

  const JhLoginTextField({
    Key key,
    this.text: '',
    this.keyboardType: TextInputType.text,
    this.hintText: '',
    this.labelText,
    this.controller,
    this.focusNode,
    this.isPwd = false,
    this.leftWidget,
    this.rightWidget,
    this.maxLength:20,
    this.isShowDeleteBtn = false,
    this.inputFormatters,
    this.inputCallBack,
    this.pwdOpen,
    this.pwdClose,
    this.border,
    this.isDense:false,

  }): super(key: key);

  @override
  _JhLoginTextFieldState createState() => _JhLoginTextFieldState();
}

class _JhLoginTextFieldState extends State<JhLoginTextField> {


   TextEditingController _textController;
   FocusNode _focusNode;
   bool _isShowDelete;
   bool _isHideenPwdBtn; //是否隐藏 右侧密码明文切换按钮 ，密码样式才显示（isPwd =true），
   bool _pwdShow; //控制密码 明文切换
   Widget _pwdImg; //自定义密码图片

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = widget.controller!=null ? widget.controller : TextEditingController();
    _textController.text = widget.text;
    _focusNode = widget.focusNode !=null ?widget.focusNode : FocusNode();
    _isHideenPwdBtn = !widget.isPwd ;
    _pwdShow = widget.isPwd;

    _isShowDelete = _focusNode.hasFocus && _textController.text.isNotEmpty;
    _textController.addListener(() {
      setState(() {
        _isShowDelete = _textController.text.isNotEmpty &&_focusNode.hasFocus;
      });
    });
    _focusNode.addListener(() {
      setState(() {
        _isShowDelete = _textController.text.isNotEmpty &&_focusNode.hasFocus;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    if(widget.pwdOpen!=null && widget.pwdClose!=null){
      if(widget.pwdOpen.isNotEmpty && widget.pwdClose.isNotEmpty){
        _pwdImg = _pwdShow ? ImageIcon(AssetImage(widget.pwdClose)):ImageIcon(AssetImage(widget.pwdOpen)) ;
      }else{
        _pwdImg = Icon(_pwdShow ? Icons.visibility_off : Icons.visibility);
      }
    }else{
      _pwdImg = Icon(_pwdShow ? Icons.visibility_off : Icons.visibility);
//      _pwdImg = _pwdShow?Image.asset("assets/images/ic_pwd_close.png",width: 18.0,):Image.asset("assets/images/ic_pwd_open.png",width: 18.0,);
//      _pwdImg = _pwdShow?ImageIcon(AssetImage("assets/images/ic_pwd_close.png")):ImageIcon(AssetImage("assets/images/ic_pwd_open.png")) ;
    }

    return

      Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[

          TextField(
            focusNode: _focusNode,
            controller: _textController,
            keyboardType: widget.keyboardType,
            style: _textStyle,
//            // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
//            inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
//            [WhitelistingTextInputFormatter(RegExp('[0-9]'))] : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
            inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(widget.maxLength)],
            decoration: InputDecoration(
              prefixIcon: widget.leftWidget,
              labelText: widget.labelText!= null ?widget.labelText: null,
              hintText:  widget.hintText,
              hintStyle: _hintTextStyle,
              isDense: widget.isDense,
              enabledBorder: widget.border!=null?widget.border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)),
              focusedBorder: widget.border!=null?widget.border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
//          suffixIcon:
            ),
            obscureText: _pwdShow,
            onChanged: (value){
              if(widget.inputCallBack!=null){
                widget.inputCallBack(_textController.text);
              }
            },
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(offstage: !widget.isShowDeleteBtn, child:
              _isShowDelete
                  ? IconButton(icon: Icon(Icons.cancel,color: Color(0xFFC8C8C8),size: 20,),
                  onPressed: (){
                    _textController.text = "";
                    if(widget.inputCallBack!=null){
                      widget.inputCallBack(_textController.text);
                    }
                  }
              ): Text(""),
              ),
              Offstage( offstage: _isHideenPwdBtn, child:
              IconButton(
//                  icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
//                  icon: Image.asset("assets/images/ic_pwd_close.png",width: 18.0,),
                icon: _pwdImg,
                iconSize: 18.0 ,
                onPressed: () {
                  setState(() {
                    _pwdShow = !_pwdShow;
                  });
                },
              )
              ),
              widget.rightWidget!=null?widget.rightWidget:Container(),
            ],
          ),
        ],
      );


  /*以下代码添加右侧自定义widget点击会弹出键盘*/


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
//                Offstage( offstage: _isHideenPwdBtn, child:
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


  }
}
