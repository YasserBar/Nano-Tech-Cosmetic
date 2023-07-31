import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SecondaryAppbar(title: "Categories"),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.appbarBodyPadding,
            horizontal: AppDimensions.sidesBodyPadding,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) => CategoryCard(
            image: AppAssets.image1,
            name: "Buy more 25000 and get \nfree delivery ",
            onTap: () {
              Get.toNamed(AppPagesRoutes.productsScreen);
            },
          ),
        ),
      ),
    );
  }
}
