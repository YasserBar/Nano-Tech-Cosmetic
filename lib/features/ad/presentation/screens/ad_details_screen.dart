import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

class AdDetailsScreen extends StatefulWidget {
  const AdDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  bool isReadMoreMode = false, isEnd = false;
  Ad ad = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isReadMoreMode ? AppColors.materialPrimary.withOpacity(0.9) : null,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (isReadMoreMode) {
              setState(() {
                isReadMoreMode = false;
              });
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            body: Stack(
              children: [
                if (ad.imageUrl == null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: Image.asset(
                      AppAssets.image1,
                      width: Get.width,
                      height: Get.height * 0.6,
                    ),
                  ),
                if (ad.imageUrl != null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: CachedNetworkImage(
                      imageUrl: ad.imageUrl!,
                      width: Get.width,
                      height: Get.height * 0.5,
                    ),
                  ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                      size: 35,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isReadMoreMode = !isReadMoreMode;
                      });
                    },
                    child: AnimatedContainer(
                      height: isReadMoreMode ? Get.height : Get.height * 0.6,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.appbarBodyPadding + 15,
                        horizontal: AppDimensions.sidesBodyPadding + 10,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: isReadMoreMode
                              ? null
                              : const BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                          border: Border.all(color: AppColors.primary, width: 5)),
                      duration: const Duration(microseconds: 600),
                      onEnd: () {
                        setState(() {
                          if (isReadMoreMode) {
                            isEnd = true;
                          } else {
                            isEnd = false;
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                ad.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: AppColors.gray, fontSize: 36),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ad.description,
                                maxLines: isReadMoreMode && isEnd ? null : 4,
                                overflow: isReadMoreMode && isEnd
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.gray,
                                      fontSize: 22,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
IconButton(
                        onPressed: () {
                          WidgetsUtils.showCustomDialog(context,
                              title: "Order by name",
                              okText: "Order",
                              hasBtnCancel: false,
                              children: [
                                const CustomTextField(
                                  labelText: "New name",
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const CustomTextField(
                                  labelText: "New name",
                                  isTextArea: true,
                                ),
                              ]);
                        },
                        icon: const Icon(
                          Icons.addchart,
                          size: 28,
                        ),
                        color: AppColors.white),
                    IconButton(
                        onPressed: () {
                          WidgetsUtils.showCustomDialog(context,
                              title: "Order Manufacturing",
                              okText: "Order",
                              hasBtnCancel: false,
                              children: [
                                const CustomTextField(
                                  labelText: "Details order",
                                  isTextArea: true,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const CustomTextField(
                                  labelText: "Notes",
                                  isTextArea: true,
                                ),
                              ]);
                        },
                        icon: const Icon(
                          Icons.post_add_rounded,
                          size: 30,
                        ),
                        color: AppColors.white),
 */
