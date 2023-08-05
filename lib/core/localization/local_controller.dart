import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class LocaleController extends GetxController {
  Locale? language;
  SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
  ThemeData appTheme = AppThemes.themeEnglish;

  @override
  void onInit() {
    String? sharedPrefLang = sharedPreferences.getString(AppKeys.LANG);
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = AppThemes.themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = AppThemes.themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      if (Get.deviceLocale!.languageCode == "ar") {
        appTheme = AppThemes.themeArabic;
      } else if (Get.deviceLocale!.languageCode == "en") {
        appTheme = AppThemes.themeEnglish;
      }
      sharedPreferences.setString(AppKeys.LANG, Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }

  void changeLang() {
    String oldLangCode = sharedPreferences.getString(AppKeys.LANG) ?? 'ar';
    String newLangCode = oldLangCode == "ar" ? 'en' : 'ar';
    Locale locale = Locale(newLangCode);
    sharedPreferences.setString(AppKeys.LANG, newLangCode);
    appTheme =
        newLangCode == "ar" ? AppThemes.themeArabic : AppThemes.themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }
}
