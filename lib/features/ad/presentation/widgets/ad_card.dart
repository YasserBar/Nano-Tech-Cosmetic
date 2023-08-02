import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

class AdCard extends StatelessWidget {
  final Ad ad;

  const AdCard({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPagesRoutes.adDetailsScreen,arguments: ad);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: AppColors.secondary2,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondary2,
                  offset: Offset(0, 1),
                  blurRadius: 4,
                  spreadRadius: 1)
            ]),
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
                height: AppDimensions.bodyHeightWithNav * 0.2,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: ad.imageUrl != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(ad.imageUrl!))
                      : const DecorationImage(
                          image: AssetImage(AppAssets.image1),
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
                  ad.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.gray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
