import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/ads/widgets/ads_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 35,
                color: AppColors.gray,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ads",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.gray,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.adsScreen);
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AdsList(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product  ",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
