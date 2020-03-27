/**
 *  jhTextField.dart
 *
 *  Created by iotjin on 2020/02/18.
 *  description:  输入框
 */

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class JhTextField extends StatefulWidget {

  const JhTextField({
    Key key,
    @required this.title,
    this.keyboardType: TextInputType.text,
    this.hintText: '',
    this.focusNode,
    this.controller,
    this.config
  }): super(key: key);

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final KeyboardActionsConfig config;

  @override
  _JhTextFieldState createState() => _JhTextFieldState();
}

class _JhTextFieldState extends State<JhTextField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
