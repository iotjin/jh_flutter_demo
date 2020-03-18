import 'package:flutter/material.dart';

class JhButton extends StatelessWidget {

  const JhButton({
    Key key,
    this.text: '',
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      textColor: Colors.white,
        color: Theme.of(context).primaryColor ,
      //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
