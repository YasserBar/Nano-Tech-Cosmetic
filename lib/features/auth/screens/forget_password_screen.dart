import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAuth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomTextField(
              labelText: "Email",
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 75,
            ),
            CustomButtonAuth(
              text: "Send Code",
              onPressed: () {
                Get.toNamed(AppPagesRoutes.verifyCodeScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
