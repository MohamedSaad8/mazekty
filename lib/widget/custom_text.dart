import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  String fontFamily;
  double fontSize;
  Color fontColor;
  FontWeight fontWeight;

  CustomText(
      {this.text,
      this.fontFamily = "Cairo",
      this.fontSize  = 14.0,
      this.fontColor = Colors.black,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: fontFamily
      ),
    );
  }
}
