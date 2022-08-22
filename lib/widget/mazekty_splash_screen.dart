import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class MazektySplashScreen extends StatelessWidget {
  Widget nextScreen;
  MazektySplashScreen({this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: nextScreen,
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/images/logo.jpg",
      text: "MAZEKTY",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
        fontFamily: "Aclonica"
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
        Colors.deepOrange,
      ],
      backgroundColor: Colors.white,
    );
  }
}
