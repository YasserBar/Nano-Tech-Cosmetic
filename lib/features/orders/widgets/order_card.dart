import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

class OrderCard extends StatelessWidget {
  final String price;
  final String response;
  final String date;
  final OrderStatus status;
  final void Function()? onTap;

  const OrderCard({Key? key,
    required this.price,
    required this.response,
    required this.date,
    required this.status,
    this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                    "$price D.I",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    response,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.gray,
                      fontSize: 18,
                    ),
                  ),
                  SvgPicture.asset(status == OrderStatus.waiting
                      ? AppAssets.waitingOrder
                      : status == OrderStatus.processing
                      ? AppAssets.processOrder
                      : status == OrderStatus.rejecting
                      ? AppAssets.rejectOrder
                      : AppAssets.doneOrder)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
