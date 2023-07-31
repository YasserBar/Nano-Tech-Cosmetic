import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/ads/widgets/ad_card.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SecondaryAppbar(title: "All Ads"),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.appbarBodyPadding,
            horizontal: AppDimensions.sidesBodyPadding,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) => const AdCard(
            image: AppAssets.image1,
            description: "Buy more 25000 and get \nfree delivery ",
          ),
        ),
      ),
    );
  }
}
