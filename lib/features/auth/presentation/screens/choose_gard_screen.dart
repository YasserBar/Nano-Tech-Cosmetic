import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/enum_roll.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/gard_card.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/gard_description_text.dart';

class ChooseGardScreen extends StatefulWidget {
  const ChooseGardScreen({super.key});

  @override
  State<ChooseGardScreen> createState() => _ChooseGardScreenState();
}

class _ChooseGardScreenState extends State<ChooseGardScreen> {
  bool isCustomer = true, isSalon = false, isCompany = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    AppColors.white,
                  ]),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: Get.height - 25,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.2,
                        child: SvgPicture.asset(
                          AppAssets.logo,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GardCard(
                            selectedIcon: AppAssets.customerFill,
                            unSelectedIcon: AppAssets.customerOutlined,
                            label: "Customer",
                            isSelected: isCustomer,
                            onSelected: (p0) {
                              setState(() {
                                isCustomer = p0;
                                isSalon = !p0;
                                isCompany = !p0;
                              });
                            },
                          ),
                          GardCard(
                            selectedIcon: AppAssets.salonFill,
                            unSelectedIcon: AppAssets.salonOutlined,
                            label: "Salon",
                            isSelected: isSalon,
                            onSelected: (p0) {
                              setState(() {
                                isCustomer = !p0;
                                isSalon = p0;
                                isCompany = !p0;
                              });
                            },
                          ),
                          GardCard(
                            selectedIcon: AppAssets.companyFill,
                            unSelectedIcon: AppAssets.companyOutlined,
                            label: "Company",
                            isSelected: isCompany,
                            onSelected: (p0) {
                              setState(() {
                                isCustomer = !p0;
                                isSalon = !p0;
                                isCompany = p0;
                              });
                            },
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Column(children: [
                        GardDescriptionText(
                          text: "Buy your cosmetics directly from the\nsource",
                        ),
                        GardDescriptionText(
                          text: "Enjoy unique GardDescription shopping",
                        ),
                        GardDescriptionText(
                          text: "Get direct service",
                        ),
                      ]),
                      const Spacer(
                        flex: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CustomButtonAuth(
                          text: "Next",
                          onPressed: () {
                            Get.toNamed(
                              AppPagesRoutes.signUpScreen,
                              arguments: {
                                AppKeys.ROLL: isCustomer
                                    ? Roll.customer
                                    : isSalon
                                        ? Roll.salon
                                        : Roll.company
                              },
                            );
                          },
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
