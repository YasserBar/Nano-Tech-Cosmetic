import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final void Function()? onTap;

  const CategoryCard({Key? key, required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.primary2,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: AppColors.secondary2,
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 1,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(category.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 140,
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
