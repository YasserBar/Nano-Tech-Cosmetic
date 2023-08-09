import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_card.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.white,
      onRefresh: () async {},
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.appbarBodyPadding,
          horizontal: AppDimensions.sidesBodyPadding,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => OrderCard(
          price: "3500",
          response: "Your order will prepare you\n can show status of...  ",
          date: "21-3-2023",
          status: OrderStatus.rejected,
          onTap: () {
            Get.toNamed(AppPagesRoutes.orderDetailsScreen);
          },
        ),
      ),
    );
  }
}