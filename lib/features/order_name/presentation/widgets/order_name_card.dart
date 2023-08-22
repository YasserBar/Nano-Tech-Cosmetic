import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';

class OrderNameCard extends StatelessWidget {
  final OrderName orderName;

  const OrderNameCard({Key? key, required this.orderName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPagesRoutes.orderNameDetailsScreen, arguments: orderName);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.primary2,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondary2,
                  offset: Offset(0, 1),
                  blurRadius: 4,
                  spreadRadius: 1)
            ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: AppColors.gray,
              )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${orderName.cost} ${AppTranslationKeys.di.tr}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 22,
                          color: AppColors.primary,
                        ),
                  ),
                  Text(
                    orderName.createdAt.substring(0, 10),
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderName.response ?? '*******************',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.gray,
                      fontSize: 18,
                    ),
                  ),
                  SvgPicture.asset(orderName.status.getIcon())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
