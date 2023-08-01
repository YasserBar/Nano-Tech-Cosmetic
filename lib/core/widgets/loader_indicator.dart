import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class LoaderIndicator extends StatelessWidget {
  final double size;
  final double lineWidth;

  const LoaderIndicator({Key? key, this.size = 100, this.lineWidth = 7})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        lineWidth: lineWidth,
        size: size,
        color: AppColors.primary,
      ),
    );
  }
}
