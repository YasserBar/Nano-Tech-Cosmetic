import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class GardDescriptionText extends StatelessWidget {
  final String text;

  const GardDescriptionText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 25, right: 15),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            height: 12,
            width: 12,
          ),
          Text(
            text,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
