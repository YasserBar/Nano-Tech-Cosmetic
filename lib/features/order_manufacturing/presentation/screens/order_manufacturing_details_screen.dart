import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';

class OrderManufacturingDetailsScreen extends StatelessWidget {
  final OrderManufacturing orderManufacturing = Get.arguments;

  OrderManufacturingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(title: AppTranslationKeys.orderDetails.tr),
      body: ListView(
        children: [
          Container(
            // height: AppDimensions.bodyHeightWithoutNav * 0.35,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.appbarBodyPadding + 5,
              horizontal: AppDimensions.sidesBodyPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTranslationKeys.total.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${orderManufacturing.cost ?? "  ? "}",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 22,
                            color: AppColors.primary,
                            decoration: orderManufacturing.cost == null
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                        Text(
                          "${AppTranslationKeys.di.tr}",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 22,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (orderManufacturing.status).getVale().tr,
                      style: TextStyle(
                          color: (orderManufacturing.status).getColor(),
                          fontSize: 20),
                    ),
                    Text(
                      orderManufacturing.createdAt.toString().substring(0, 10),
                      style: const TextStyle(
                          color: AppColors.secondary, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppTranslationKeys.response.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderManufacturing.response ??
                          AppTranslationKeys.notResponse.tr,
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppTranslationKeys.amount.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderManufacturing.amount.toString(),
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppTranslationKeys.orderDetails.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderManufacturing.details,
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppTranslationKeys.notes.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderManufacturing.note ?? AppTranslationKeys.notNote.tr,
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
