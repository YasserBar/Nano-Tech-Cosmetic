import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';

class OrderNameDetailsScreen extends StatelessWidget {
  final OrderName orderName = Get.arguments;

  OrderNameDetailsScreen({Key? key}) : super(key: key);

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
                    Text(
                      "${orderName.cost} ${AppTranslationKeys.di.tr}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 26,
                            color: AppColors.primary,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (orderName.status).getVale().tr,
                      style: TextStyle(
                          color: (orderName.status).getColor(), fontSize: 20),
                    ),
                    Text(
                      orderName.createdAt.toString().substring(0, 10),
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
                      orderName.response ?? AppTranslationKeys.notResponse.tr,
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
                      orderName.amount.toString(),
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTranslationKeys.newName.tr,
                          style: const TextStyle(
                              color: AppColors.black, fontSize: 20),
                        ),
                        Text(
                          orderName.newName,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
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
                      orderName.note ?? AppTranslationKeys.notNote.tr,
                      style:
                          const TextStyle(color: AppColors.gray, fontSize: 16),
                      maxLines: 3,
                    )
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
