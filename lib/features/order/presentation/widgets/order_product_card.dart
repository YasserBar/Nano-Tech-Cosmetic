import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class OrderProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int count;

  const OrderProductCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: IntrinsicHeight(
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: -4,
                  //   right: -4,
                  //   child: Container(
                  //     height: 20,
                  //     width: 20,
                  //     decoration: const BoxDecoration(
                  //         color: AppColors.primary2,
                  //         shape: BoxShape.circle),
                  //   ),
                  // ),
                ],
              ),
              const VerticalDivider(
                thickness: 1,
                width: 20,
                color: AppColors.gray,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$price D.I",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Count: $count",
                          style: const TextStyle(
                            color: AppColors.gray,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
