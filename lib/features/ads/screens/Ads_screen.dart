import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/ads/widgets/ad_card.dart';
import 'package:nano_tech_cosmetic/features/orders/widgets/order_product_card.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.09),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10)
              .copyWith(bottom: 0),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, 2),
              spreadRadius: 10,
              blurRadius: 10,
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  )),
              Text(
                "All Ads",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Icon(
                Icons.search,
                color: AppColors.transparent,
                size: 35,
              ),
            ],
          ),
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20
        ),
        children: List.generate(
            10,
            (index) => const AdCard(
                image: AppAssets.image1,
                description: "Buy more 25000 and get \nfree delivery ")),
      ),
    );
  }
}
