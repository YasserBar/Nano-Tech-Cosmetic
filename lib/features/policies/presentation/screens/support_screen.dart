import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/policies/presentation/widgets/support_cart.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppbar(title: AppTranslationKeys.support.tr),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.sidesBodyPadding,
            vertical: AppDimensions.appbarBodyPadding),
        children: [
          const SizedBox(
            height: 80,
          ),
          SvgPicture.asset(
            AppAssets.logoDrawer,
          ),
          const SizedBox(
            height: 100,
          ),
          SupportCart(
            title: "964-242152452",
            leading: SvgPicture.asset(
              AppAssets.phone,
              height: 30,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          SupportCart(
            title: "nano-tech.telegram",
            leading: SvgPicture.asset(
              AppAssets.telegram,
              height: 30,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          SupportCart(
            title: "nano-tech.twitter",
            leading: SvgPicture.asset(
              AppAssets.twitter,
              height: 30,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          SupportCart(
            title: "nano-tech.facebook",
            leading: SvgPicture.asset(
              AppAssets.facebook,
              height: 30,
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          SupportCart(
            title: "nano-tech.instagram",
            leading: SvgPicture.asset(
              AppAssets.instagram,
              height: 30,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
