import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_product_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

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
                "Order Details",
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
      body: Column(
        children: [
          Container(
            height: AppDimensions.bodyHeightWithoutNav * 0.3,
            padding: const EdgeInsets.all(20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(color: AppColors.gray, fontSize: 20),
                    ),
                    Text(
                      "240.000 D.I",
                      style: TextStyle(color: AppColors.primary, fontSize: 25),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
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
                SizedBox(
                  height: 10,
                ),
                Column(
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
          const Divider(height: 20, thickness: 2, indent: 15, endIndent: 15),
          SizedBox(
            height: AppDimensions.bodyHeightWithoutNav * 0.7 -30,
            child: RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              onRefresh: () async {
                Get.toNamed(AppPagesRoutes.myOrderScreen);
              },
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
          ),
        ],
      ),
    );
  }
}
