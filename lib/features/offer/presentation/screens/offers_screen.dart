import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/widgets/offer_card.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.appbarBodyPadding,
          horizontal: AppDimensions.sidesBodyPadding,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => const OfferCard(
          image: AppAssets.image1,
          name: "Cream Mini",
          price: "250",
          rating: 1,
          content: "Your order will prepare you\n can show status of...",
        ),
      ),
    );
  }
}
