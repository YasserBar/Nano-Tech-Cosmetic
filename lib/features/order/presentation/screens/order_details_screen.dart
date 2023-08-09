import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_product_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(title: AppTranslationKeys.orderDetails.tr),
      body: ListView(
        children: [
          Container(
            // height: AppDimensions.bodyHeightWithoutNav * 0.35,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.appbarBodyPadding + 5,
              horizontal: AppDimensions.sidesBodyPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTranslationKeys.total.tr,
                      style: const TextStyle(color: AppColors.gray, fontSize: 20),
                    ),
                    Text(
                      "240.000 ${AppTranslationKeys.di.tr}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 26,
                            color: AppColors.primary,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(color: AppColors.success2, fontSize: 20),
                    ),
                    Text(
                      "21-3-2023",
                      style:
                          TextStyle(color: AppColors.secondary, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTranslationKeys.response.tr,
                      style: const TextStyle(color: AppColors.gray, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Your order will prepare you can show status of...",
                      style: TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(height: 30, thickness: 2, indent: 15, endIndent: 15),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.sidesBodyPadding),
            child: Column(
              children: [
                ...List.generate(
                    10,
                    (index) => const OrderProductCard(
                          image: AppAssets.image1,
                          name: "Cream Mini",
                          price: "250",
                          count: 3,
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
