import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CustomRatingBar extends StatelessWidget {
  final bool ignoreGestures;
  final double rating;
  final double itemSize;
  final void Function(double rating) onRatingUpdate;
  final void Function()? onTap;
  const CustomRatingBar({
    Key? key,
    required this.rating,
    required this.onRatingUpdate,
    this.ignoreGestures = true,
    this.itemSize = 25,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RatingBar(
        initialRating: rating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: const Icon(
            Icons.star_outlined,
            color: AppColors.amber,
          ),
          half: const Icon(
            Icons.star_half_outlined,
            color: AppColors.amber,
          ),
          empty: const Icon(
            Icons.star_outline_outlined,
            color: AppColors.amber,
          ),
        ),
        ignoreGestures: ignoreGestures,
        itemSize: itemSize,
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}
