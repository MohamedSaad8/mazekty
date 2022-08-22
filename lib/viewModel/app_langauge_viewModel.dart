import 'dart:ui';
import 'package:get/get.dart';
import 'package:mazekty/helper/local_storage_helper/language_local_storage.dart';

class AppLanguageViewModel extends GetxController {
  var currentAppLanguage = "ar";

  @override
  void onInit() async {
    super.onInit();
   // LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();
    currentAppLanguage = await Get.find<LanguageLocalStorage>().selectedLanguage == null
        ? "ar"
        :await Get.find<LanguageLocalStorage>().selectedLanguage;
    Get.updateLocale(Locale(currentAppLanguage));
    update();
  }

  void changeSelectedLanguage(String language) async {
    //LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();
    if (currentAppLanguage == language)
      return;
    else {
      currentAppLanguage = language;
      Get.find<LanguageLocalStorage>().saveLanguageToDisk(language);
    }
    update();
  }
}
