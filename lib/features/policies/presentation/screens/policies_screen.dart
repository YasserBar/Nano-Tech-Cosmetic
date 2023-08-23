import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/policies/presentation/widgets/custom_section.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppbar(title: AppTranslationKeys.policies.tr),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.sidesBodyPadding,
            vertical: AppDimensions.appbarBodyPadding),
        children: [
          CustomSection(
            title: AppTranslationKeys.police1.tr,
            content: AppTranslationKeys.policeContent1.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.police2.tr,
            content: AppTranslationKeys.policeContent2.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.police3.tr,
            content: AppTranslationKeys.policeContent3.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.police4.tr,
            content: AppTranslationKeys.policeContent4.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.police5.tr,
            content: AppTranslationKeys.policeContent5.tr,
          ),
        ],
      ),
    );
  }
}
