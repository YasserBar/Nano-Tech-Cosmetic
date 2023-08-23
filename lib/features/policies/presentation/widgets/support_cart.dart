import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class SupportCart extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function() onTap;

  const SupportCart({
    Key? key,
    required this.title,
    required this.leading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 1),
                color: AppColors.gray.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5)
          ]),
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: onTap,
      ),
    );
  }
}
