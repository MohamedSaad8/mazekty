import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPlayerButton extends StatelessWidget {

  Function buttonFunction ;
  IconData buttonIcon ;
  double iconSize ;
  double buttonHeight ;
  Color iconColor ;

  CustomPlayerButton(
      {this.buttonFunction, this.buttonIcon, this.iconSize, this.buttonHeight , this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      minWidth: 0,
      onPressed: buttonFunction,
      child: Icon(buttonIcon , size: iconSize, color: iconColor,),
      shape: CircleBorder(),
      color: Colors.purple,
      height: buttonHeight,

    );
  }
}
