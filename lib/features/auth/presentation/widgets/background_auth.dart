import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class BackgroundAuth extends StatelessWidget {
  final Widget child;
  final bool isSignUpScreen;

  const BackgroundAuth(
      {Key? key, required this.child, this.isSignUpScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          alignment: Alignment.center,
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.primary,
                  AppColors.white,
                ]),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height-25,
                child: Column(
                  children: [
                    if (!isSignUpScreen)
                      SizedBox(
                        height: Get.height * 0.2,
                        child: SvgPicture.asset(
                          AppAssets.logo,
                        ),
                      ),
                    const Spacer(flex: 1),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: !isSignUpScreen
                          ? const EdgeInsets.only(
                              top: 30,
                              bottom: 40,
                              left: 20,
                              right: 20,
                            )
                          : const EdgeInsets.only(
                              top: 0,
                              bottom: 40,
                            ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.secondary2,
                            offset: Offset(0, 3),
                            blurRadius: 4,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: child,
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
