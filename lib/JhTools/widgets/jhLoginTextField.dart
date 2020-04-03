/**
 *  jhLoginTextField.dart
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
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final bool isPwd; //是否是密码，默认不是
  final Widget leftIcon; //左侧的图标 ，不设置隐藏
  final bool isShowDeleteBtn;  //是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter> inputFormatters;
  final _InputCallBack inputCallBack;

  const JhLoginTextField({
    Key key,
    this.text: '',
    this.keyboardType: TextInputType.text,
    this.hintText: '',
    this.focusNode,
    this.isPwd = false,
    this.leftIcon,
    this.isShowDeleteBtn = false,
    this.inputFormatters,
    this.inputCallBack,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController = TextEditingController();
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


    if(widget.leftIcon!=null){
      return
        TextField(
          focusNode: _focusNode,
          controller: _textController,
          keyboardType: widget.keyboardType,
          style: _textStyle,
          inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(20)],
          decoration: InputDecoration(
            hintText:  widget.hintText,
            hintStyle: _hintTextStyle,
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 0.5)),
            prefixIcon: widget.leftIcon,
            suffixIcon: Container(
              child: Row(
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
                  IconButton(icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _pwdShow = !_pwdShow;
                      });
                    },
                  )
                  )
                ],
              ),
            ),
          ),
          obscureText: _pwdShow,
          onChanged: (value){
            if(widget.inputCallBack!=null){
              widget.inputCallBack(_textController.text);
            }
          },
        );

    }else{
      return
        TextField(
          focusNode: _focusNode,
          controller: _textController,
          keyboardType: widget.keyboardType,
          style: _textStyle,
          inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(20)],
          decoration: InputDecoration(
            hintText:  widget.hintText,
            hintStyle: _hintTextStyle,
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 0.5)),
            suffixIcon: Container(
              child: Row(
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
                  IconButton(icon: Icon(_pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _pwdShow = !_pwdShow;
                      });
                    },
                  )
                  )
                ],
              ),
            ),
          ),
          obscureText: _pwdShow,
          onChanged: (value){
            if(widget.inputCallBack!=null){
              widget.inputCallBack(_textController.text);
            }
          },
        );
    }




  }
}
