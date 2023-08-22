import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';

void signInDialog(BuildContext context, {required String title}) {
  WidgetsUtils.showCustomDialog(
    context,
    hasBtnCancel: false,
    title: title,
    children: [
      Center(
        child: SizedBox(
          width: Get.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTranslationKeys.doNotHaveAnAccount.tr,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.toNamed(AppPagesRoutes.chooseGardScreen);
                },
                child: Text(
                  AppTranslationKeys.singUp.tr,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    btnOkOnPress: () {
      Get.back();
      Get.toNamed(AppPagesRoutes.signInScreen);
    },
    okText: AppTranslationKeys.singIn.tr,
  );
}
