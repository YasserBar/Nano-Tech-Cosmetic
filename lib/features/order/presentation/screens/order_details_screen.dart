import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_product_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SecondaryAppbar(title: "Order Details"),
      body: Column(
        children: [
          Container(
            height: AppDimensions.bodyHeightWithoutNav * 0.3,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.appbarBodyPadding+5,
              horizontal: AppDimensions.sidesBodyPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(color: AppColors.gray, fontSize: 20),
                    ),
                    Text(
                      "240.000 D.I",
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Response",
                      style: TextStyle(color: AppColors.gray, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your order will prepare you can show status \nof...",
                      style: TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(height: 0, thickness: 2, indent: 15, endIndent: 15),
          SizedBox(
            height: AppDimensions.bodyHeightWithoutNav * 0.7 - 30,
            child: ListView(
              padding: const EdgeInsets.all(15),
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                  10,
                  (index) => const OrderProductCard(
                        image: AppAssets.image1,
                        name: "Cream Mini",
                        price: "250",
                        count: 3,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
