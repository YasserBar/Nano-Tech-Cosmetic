
import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';

enum SnackBarType {
  info,
  error,
  warning,
}

enum OrderStatus {
  waiting,
  processing,
  rejected,
  done,


}

extension GetVale on OrderStatus{
  String getVale(){
    switch (this){
      case OrderStatus.waiting:
        return AppTranslationKeys.waiting;
      case OrderStatus.processing:
        return AppTranslationKeys.processing;
      case OrderStatus.rejected:
        return AppTranslationKeys.rejected;
      case OrderStatus.done:
        return AppTranslationKeys.done;
    }
  }
  Color getColor(){
    switch (this){
      case OrderStatus.waiting:
        return AppColors.secondary;
      case OrderStatus.processing:
        return AppColors.primarySolid;
      case OrderStatus.rejected:
        return AppColors.danger2;
      case OrderStatus.done:
        return AppColors.success1;
    }
  }
}


enum OrderType {
  normal,
  byNewName,
  manufacturing,
}

enum Role {
  customer,
  salon,
  company,
}
