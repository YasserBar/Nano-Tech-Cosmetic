import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';

class Pickers{
  static Future<String?> choseDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      cancelText: AppTranslationKeys.cancel.tr,
      confirmText: AppTranslationKeys.confirm.tr,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      return formatDate(date);
    }
    return null;
  }
  static String formatDate(DateTime date){
    if(date.month<10){
      if(date.day<10){
        return '${date.year}-0${date.month}-0${date.day}';
      }
      return '${date.year}-0${date.month}-${date.day}';
    }
    if(date.day<10){
      if(date.month<10){
        return '${date.year}-0${date.month}-0${date.day}';
      }
      return '${date.year}-${date.month}-0${date.day}';
    }
    return '${date.year}-${date.month}-${date.day}';
  }

}