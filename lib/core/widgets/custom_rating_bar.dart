import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class CustomRatingBar extends StatelessWidget {
  final bool ignoreGestures;
  final double rating;
  final double itemSize;
  final void Function(double rating) onRatingUpdate;

  const CustomRatingBar({
    Key? key,
    required this.rating,
    required this.onRatingUpdate,
    this.ignoreGestures = true,
    this.itemSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star_outlined,
          color: AppColors.yellowAccent,
        ),
        half: const Icon(
          Icons.star_half_outlined,
          color: AppColors.yellowAccent,
        ),
        empty: const Icon(
          Icons.star_outline_outlined,
          color: AppColors.yellowAccent,
        ),
      ),
      ignoreGestures: ignoreGestures,
      itemSize: itemSize,
      onRatingUpdate: onRatingUpdate,
    );
  }
}
