import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/ads/widgets/ad_card.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.appbarBodyPadding,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.sidesBodyPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 35),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Do you have an account? ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPagesRoutes.signInScreen);
                        },
                        child: Text(
                          "sign in",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.secondary,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sidesBodyPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ads",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 26),
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
            SizedBox(
              height: Get.height * 0.35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  10,
                  (index) => const AdCard(
                      image: AppAssets.image1,
                      description: "Buy more and get \nfree delivery "),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sidesBodyPadding, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product  ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 26),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPagesRoutes.categoriesScreen);
                    },
                    child: const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
              10,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                child: ProductCard(
                  image: AppAssets.image1,
                  name: "Cream Mini",
                  price: "250",
                  rating: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
