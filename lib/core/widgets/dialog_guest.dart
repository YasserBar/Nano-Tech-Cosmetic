import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';

void signInDialog(BuildContext context, {required String title}) {
  WidgetsUtils.showCustomDialog(context, title: title, btnOkOnPress: () {
    Get.toNamed(AppPagesRoutes.signInScreen);
  }, okText: "Sign in", children: [
    Center(
      child: SizedBox(
        width: Get.width *0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 18,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppPagesRoutes.signUpScreen);
              },
              child: const Text(
                "sign up",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ]);
}
