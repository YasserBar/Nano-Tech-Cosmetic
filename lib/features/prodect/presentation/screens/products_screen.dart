import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SecondaryAppbar(title: "Electrical"),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.appbarBodyPadding,
            horizontal: AppDimensions.sidesBodyPadding,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) => const ProductCard(
            image: AppAssets.image1,
            name: "Cream Mini",
            price: "250",
            rating: 1,
          ),
        ),
      ),
    );
  }
}
