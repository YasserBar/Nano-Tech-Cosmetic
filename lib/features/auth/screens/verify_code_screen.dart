import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/background_auth.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAuth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "We send verify code to majeLESPd@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.gray,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Verify Code",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderWidth: 3,
              borderColor: AppColors.gray,
              showFieldAsBox: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              borderRadius: BorderRadius.circular(15),
              autoFocus: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                Get.toNamed(AppPagesRoutes.resetPasswordScreen);
              }, // end onSubmit
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    "resend",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
