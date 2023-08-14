import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';

enum SnackBarType {
  info,
  error,
  warning,
}

enum OrderStatus {
  all,
  waiting,
  processing,
  rejected,
  done,
}

enum OrderType {
  normal,
  byNewName,
  manufacturing,
}

extension GetVale on OrderStatus {
  String getVale() {
    switch (this) {
      case OrderStatus.waiting:
        return AppTranslationKeys.waiting;
      case OrderStatus.processing:
        return AppTranslationKeys.processing;
      case OrderStatus.rejected:
        return AppTranslationKeys.rejected;
      case OrderStatus.done:
        return AppTranslationKeys.done;
      case OrderStatus.all:
        return AppTranslationKeys.done;
    }
  }

  Color getColor() {
    switch (this) {
      case OrderStatus.waiting:
        return AppColors.secondary;
      case OrderStatus.processing:
        return AppColors.primarySolid;
      case OrderStatus.rejected:
        return AppColors.danger2;
      case OrderStatus.done:
        return AppColors.success1;
      case OrderStatus.all:
        return AppColors.black;
    }
  }

  String getIcon() {
    switch (this) {
      case OrderStatus.all:
        return AppAssets.allOrders;
      case OrderStatus.waiting:
        return AppAssets.waitingOrder;
      case OrderStatus.processing:
        return AppAssets.processOrder;
      case OrderStatus.rejected:
        return AppAssets.rejectOrder;
      case OrderStatus.done:
        return AppAssets.doneOrder;
    }
  }

  String getLightIcon() {
    switch (this) {
      case OrderStatus.all:
        return AppAssets.allOrdersLight;
      case OrderStatus.waiting:
        return AppAssets.waitingOrderLight;
      case OrderStatus.processing:
        return AppAssets.processOrderLight;
      case OrderStatus.rejected:
        return AppAssets.rejectOrderLight;
      case OrderStatus.done:
        return AppAssets.doneOrderLight;
    }
  }
}

enum Role {
  customer,
  salon,
  company,
}
