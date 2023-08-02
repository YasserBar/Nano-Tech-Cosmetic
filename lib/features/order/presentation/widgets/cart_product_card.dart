import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CartProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final double rating;

  const CartProductCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.rating})
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
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.28,
          dragDismissible: true,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              borderRadius: BorderRadius.circular(15),
              backgroundColor: AppColors.danger2,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              autoClose: true,
              flex: 100,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {},
              borderRadius: BorderRadius.circular(15),
              backgroundColor: AppColors.primary2,
              foregroundColor: Colors.white,
              flex: 1,
              label: '',
            ),
          ],
        ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        Text(
                          "$price D.I",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.add_box,
                        color: AppColors.success1,
                      ),
                    ),
                    const Text(
                      "3",
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.indeterminate_check_box_rounded,
                        color: AppColors.danger1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
