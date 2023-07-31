import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';

class SearchProductDelegate extends SearchDelegate {
  SearchProductDelegate() : super(searchFieldLabel: 'Find Product');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
