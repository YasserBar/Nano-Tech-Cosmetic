import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAuth(
        isSignUpScreen: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.height * 0.75,
              child: ListView(
                padding: const EdgeInsets.only(top: 25),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          labelText: "First name",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Last name",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Address",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.gray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              side: const BorderSide(
                                color: AppColors.secondary,
                                width: 2,
                              ),
                              onChanged: (val) {},
                            ),
                            const Text(
                              "Male",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.gray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              side: const BorderSide(
                                color: AppColors.secondary,
                                width: 2,
                              ),
                              onChanged: (val) {},
                            ),
                            const Text(
                              "Female",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.gray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          labelText: "Email",
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Password",
                          isObscureText: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Confirm Password",
                          isObscureText: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Phone Number",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Instagram",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Twitter",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Facebook",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Telegram",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButtonAuth(
                text: "Sign up",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
