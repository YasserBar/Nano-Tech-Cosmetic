import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class SecondaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SecondaryAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, Get.height * 0.09),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10)
            .copyWith(bottom: 0),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            offset: Offset(0, 2),
            spreadRadius: 10,
            blurRadius: 10,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, Get.height * 0.09);
}
