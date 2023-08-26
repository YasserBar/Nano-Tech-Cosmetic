import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/gard_card.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/gard_description_text.dart';

class ChooseGardScreen extends StatefulWidget {
  const ChooseGardScreen({super.key});

  @override
  State<ChooseGardScreen> createState() => _ChooseGardScreenState();
}

class _ChooseGardScreenState extends State<ChooseGardScreen> {
  Role selectedRole = Role.customer;
  bool isAcceptPolicies = false;

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
                            label: AppTranslationKeys.customer.tr,
                            isSelected: selectedRole == Role.customer,
                            onSelected: (p0) {
                              setState(() {
                                selectedRole = Role.customer;
                              });
                            },
                          ),
                          GardCard(
                            selectedIcon: AppAssets.salonFill,
                            unSelectedIcon: AppAssets.salonOutlined,
                            label: AppTranslationKeys.salon.tr,
                            isSelected: selectedRole == Role.salon,
                            onSelected: (p0) {
                              setState(() {
                                selectedRole = Role.salon;
                              });
                            },
                          ),
                          GardCard(
                            selectedIcon: AppAssets.companyFill,
                            unSelectedIcon: AppAssets.companyOutlined,
                            label: AppTranslationKeys.company.tr,
                            isSelected: selectedRole == Role.company,
                            onSelected: (p0) {
                              setState(() {
                                selectedRole = Role.company;
                              });
                            },
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Column(
                        children: List.generate(
                          selectedRole.getFeatures().length,
                          (index) => GardDescriptionText(
                            text: selectedRole.getFeatures()[index],
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAcceptPolicies = !isAcceptPolicies;
                              });
                            },
                            child: SizedBox(
                              width: Get.width,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Checkbox(
                                    value: isAcceptPolicies,
                                    side: const BorderSide(
                                      color: AppColors.secondary,
                                      width: 2,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        isAcceptPolicies = !isAcceptPolicies;
                                      });
                                    },
                                  ),
                                  Text(
                                    "${AppTranslationKeys.iAgreeOn.tr} ",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPagesRoutes.policiesScreen);
                                    },
                                    child: Text(
                                      AppTranslationKeys.privacyPolicies.tr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " ${AppTranslationKeys.and.tr} ",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPagesRoutes.policiesScreen);
                                    },
                                    child: Text(
                                      AppTranslationKeys.tearmCondition.tr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CustomButtonAuth(
                          text: AppTranslationKeys.next.tr,
                          onPressed: isAcceptPolicies
                              ? () {
                                  Get.toNamed(AppPagesRoutes.signUpScreen,
                                      arguments: selectedRole);
                                }
                              : null,
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
