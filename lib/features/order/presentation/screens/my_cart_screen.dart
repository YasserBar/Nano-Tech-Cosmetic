import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/cart_product_card.dart';
import 'package:nano_tech_cosmetic/main.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.bodyHeightWithNav * 0.75,
          child: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            onRefresh: () async {},
            child: SlidableAutoCloseBehavior(

              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => const CartProductCard(
                  image: AppAssets.image1,
                  name: "Cream Mini",
                  price: "250",
                  rating: 1,
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 0, thickness: 2, indent: 15, endIndent: 15),
        Container(
          height: AppDimensions.bodyHeightWithNav * 0.25 - 55,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(color: AppColors.gray, fontSize: 18),
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
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      globalUser != null
                          ? WidgetsUtils.showCustomDialog(context,
                              title: "Total",
                              children: [
                                  const Center(
                                    child: Text(
                                      "240.000 D.I",
                                      style: TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: 30),
                                    ),
                                  )
                                ])
                          : signInDialog(context, title: 'Order');
                    },
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side:
                            const BorderSide(color: AppColors.gray, width: 1)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Text(
                        "Order",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
