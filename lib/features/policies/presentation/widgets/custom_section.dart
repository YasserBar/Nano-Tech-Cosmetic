import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final String content;

  const CustomSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 20, color: AppColors.black),
        ),
        Text(content),
        const SizedBox(height: 20),
      ],
    );
  }
}
