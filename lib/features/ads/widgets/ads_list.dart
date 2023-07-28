import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/features/ads/widgets/ad_card.dart';

class AdsList extends StatelessWidget {
  const AdsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.bodyHeightWithNav * 0.4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: List.generate(
          10,
          (index) => const AdCard(
              image: AppAssets.image1,
              description: "Buy more and get \nfree delivery "),
        ),
      ),
    );
  }
}
