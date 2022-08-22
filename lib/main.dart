import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazekty/helper/binding.dart';
import 'package:mazekty/translation.dart';
import 'package:mazekty/view/control_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mazekty/widget/mazekty_splash_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      translations: Translation(),
      locale: Locale("en"),
      fallbackLocale: Locale("en") ,
      home: MazektySplashScreen(
        nextScreen: ControlView(),
      ),
    );
  }
}


