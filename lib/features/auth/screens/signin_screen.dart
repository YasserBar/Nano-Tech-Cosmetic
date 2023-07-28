import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAuth(
        child: Column(
          children: [
            const CustomTextField(
              labelText: "Email",
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 25,
            ),
            const CustomTextField(
              labelText: "Password",
              isObscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.forgetPasswordScreen);
                  },
                  child: const Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.chooseGardScreen);
                  },
                  child: const Text(
                    "sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButtonAuth(
              text: "Sign in",
              onPressed: () {
                Get.toNamed(AppPagesRoutes.mainScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
