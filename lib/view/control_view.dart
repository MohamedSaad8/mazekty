import 'package:flutter/material.dart';
import 'package:mazekty/viewModel/app_langauge_viewModel.dart';
import 'package:mazekty/viewModel/control_view_viewModel.dart';
import 'package:mazekty/widget/current_playing_song_floating_button.dart';
import 'package:mazekty/widget/custom_text.dart';
import 'package:mazekty/widget/gradient_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ControlView extends StatelessWidget {
  TextStyle _style = TextStyle(color: Colors.purple, fontFamily: "Cairo" , fontSize: 16 , fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewViewModel>(
      init: ControlViewViewModel(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: mazektyAppBar(),
        drawer: mazektyDrawer(),
        bottomNavigationBar: mazektyBottomNavigationBar(),
        body: controller.currentScreen,
        floatingActionButton: CurrentPlayingSongFloatingButton(),
      ),
    );
  }

  AppBar mazektyAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.purple),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: GradientText(
        text: "mazekty".tr,
        gradient: LinearGradient(colors: [
          Colors.red,
          Colors.pink,
          Colors.purple,
          Colors.deepPurple,
          Colors.deepPurple,
          Colors.indigo,
          Colors.blue,
          Colors.lightBlue,
          Colors.cyan,
          Colors.teal,
          Colors.green,
          Colors.lightGreen,
          Colors.lime,
          Colors.yellow,
          Colors.amber,
          Colors.orange,
          Colors.deepOrange,
        ]),
      ),
    );
  }

  Drawer mazektyDrawer() {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<AppLanguageViewModel>(
          init: AppLanguageViewModel(),
          builder: (controller) => Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height*0.05,
                color: Colors.purple,
                child: Center(
                  child: CustomText(
                    text: "selectLanguage".tr,
                    fontColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                  ),
                ),
              ),
              RadioListTile(
                value: "ar",
                groupValue: controller.currentAppLanguage,
                onChanged: (value) {
                  controller.changeSelectedLanguage(value);
                  Get.updateLocale(Locale(value));
                },
                title: CustomText(
                  text: "العربية",
                  fontFamily: "Cairo",
                ),
              ),
              RadioListTile(
                value: "en",
                groupValue: controller.currentAppLanguage,
                onChanged: (value) {
                  controller.changeSelectedLanguage(value);
                  Get.updateLocale(Locale(value));
                },
                title: CustomText(text :"English" , fontFamily: "Cairo",),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder<ControlViewViewModel> mazektyBottomNavigationBar() {
    return GetBuilder<ControlViewViewModel>(
      builder: (controller) => BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Icon(
                Icons.queue_music_rounded,
                color: Colors.purple,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "allSongs".tr,
                style: _style,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Icon(
                Icons.album,
                color: Colors.purple,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "albums".tr,
                style: _style,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Icon(
                Icons.person_outline_outlined,
                color: Colors.purple,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "artists".tr,
                style: _style,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding:const EdgeInsets.only(top: 15),
              child: Icon(
                Icons.favorite_border,
                color: Colors.purple,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "favorite".tr,
                style: _style,
              ),
            ),
            label: "",
          ),
        ],
        onTap: (index) {
          controller.changeValueOfBottomNavigator(index);
        },
        currentIndex: controller.navigatorValue,
      ),
    );
  }
}


