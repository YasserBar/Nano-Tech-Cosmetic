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

/*
IconButton(
              onPressed: () {
                WidgetsUtils.showCustomDialog(context,
                    title: "Order by name",
                    okText: "Order",
                    hasBtnCancel: false,
                    children: [
                      const CustomTextField(
                        labelText: "New name",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const CustomTextField(
                        labelText: "New name",
                        isTextArea: true,
                      ),
                    ]);
              },
              icon: const Icon(
                Icons.addchart,
                size: 28,
              ),
              color: AppColors.white),
          IconButton(
              onPressed: () {
                WidgetsUtils.showCustomDialog(context,
                    title: "Order Manufacturing",
                    okText: "Order",
                    hasBtnCancel: false,
                    children: [
                      const CustomTextField(
                        labelText: "Details order",
                        isTextArea: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const CustomTextField(
                        labelText: "Notes",
                        isTextArea: true,
                      ),
                    ]);
              },
              icon: const Icon(
                Icons.post_add_rounded,
                size: 30,
              ),
              color: AppColors.white),
 */
