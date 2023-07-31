import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/pickers.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isMail = true;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomTextField(
                          labelText: "First name",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const CustomTextField(
                          labelText: "Last name",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const CustomTextField(
                          labelText: "Address",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: "Birth date",
                          onTap: () {
                            Pickers.choseDate(context);
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Row(
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              isMail=true;
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: isMail,
                                side: const BorderSide(
                                  color: AppColors.secondary,
                                  width: 2,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    isMail=true;
                                  });
                                },
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
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isMail=false;
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: !isMail,
                                side: const BorderSide(
                                  color: AppColors.secondary,
                                  width: 2,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    isMail=false;
                                  });
                                },
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
                        SizedBox(
                          height: 15,
                        ),
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
                onPressed: () {
                  Get.toNamed(AppPagesRoutes.mainScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
