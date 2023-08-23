import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/policies/presentation/widgets/custom_section.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppbar(title: AppTranslationKeys.about.tr),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.sidesBodyPadding,
            vertical: AppDimensions.appbarBodyPadding),
        children: [
          CustomSection(
            title: "${AppTranslationKeys.about.tr}:",
            content: AppTranslationKeys.aboutContent.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.goals.tr,
            content: AppTranslationKeys.goalsContent.tr,
          ),
          CustomSection(
            title: AppTranslationKeys.vision.tr,
            content: AppTranslationKeys.visionContent.tr,
          )
        ],
      ),
    );
  }
}
