import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

class GardCard extends StatelessWidget {
  final String selectedIcon;
  final String unSelectedIcon;
  final String label;
  final bool isSelected;
  final void Function(bool)? onSelected;

  const GardCard(
      {Key? key,
      required this.selectedIcon,
      required this.unSelectedIcon,
      required this.label,
      required this.isSelected,
      this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Container(
        padding: const EdgeInsets.all(15).copyWith(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isSelected ? AppColors.secondary2 : AppColors.secondary2,
              offset: isSelected ? const Offset(0, 5) : const Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(isSelected ? selectedIcon : unSelectedIcon),
            const SizedBox(
              height: 20,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      side: const BorderSide(width: 0.1, color: AppColors.gray),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      elevation: 5,
      shadowColor: AppColors.gray,
      selectedShadowColor: AppColors.secondary,
      selectedColor: AppColors.transparent,
      disabledColor: AppColors.transparent,
      showCheckmark: false,
    );
  }
}
