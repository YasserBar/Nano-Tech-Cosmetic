import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  bool isReadMoreMode = false, isEnd = false;
  Offer offer = Get.arguments;

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
                if (offer.imageUrl == null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: Image.asset(
                      AppAssets.image1,
                      width: Get.width,
                      height: Get.height * 0.6,
                    ),
                  ),
                if (offer.imageUrl != null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: CachedNetworkImage(
                      imageUrl: offer.imageUrl!,
                      width: Get.width,
                      height: Get.height * 0.5,
                    ),
                  ),
                Positioned(
                  top: 15,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primary,
                          size: 35,
                        ),
                      ),
                    ],
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
                        color: AppColors.materialPrimary.withOpacity(0.9),
                        borderRadius: isReadMoreMode
                            ? null
                            : const BorderRadius.vertical(
                                top: Radius.circular(50),
                              ),
                      ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                   Get.locale!.languageCode == 'ar'
                                      ? offer.title
                                      : offer.titleEn,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.white, fontSize: 36),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${offer.price} ${AppTranslationKeys.di.tr}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: 30,
                                            letterSpacing: 2),
                                  ),
                                  Text(
                                    "${offer.oldPrice} ${AppTranslationKeys.di.tr}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.white,
                                          fontSize: 30,
                                          letterSpacing: 2,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                               Get.locale!.languageCode == 'ar'
                                    ? offer.description
                                    : offer.descriptionEn,
                                maxLines: isReadMoreMode && isEnd ? null : 4,
                                overflow: isReadMoreMode && isEnd
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.white,
                                      fontSize: 22,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocProvider(
                                create: (context) => di.sl<CartBloc>(),
                                child: BlocConsumer<CartBloc, CartState>(
                                  listener: (context, state) {
                                    if (state is FailureCartState ||
                                        state is EmptyCacheFailureCartState) {
                                      WidgetsUtils.showSnackBar(
                                        title: "Failure",
                                        message: state.message,
                                        snackBarType: SnackBarType.error,
                                      );
                                    } else if (state
                                        is SuccessAddItemCartState) {
                                      WidgetsUtils.showSnackBar(
                                        title: "Success add item to cart",
                                        message: state.message,
                                        snackBarType: SnackBarType.info,
                                      );
                                      Get.toNamed(AppPagesRoutes.mainScreen,
                                          arguments: 1);
                                    }
                                  },
                                  builder: (context, state) {
                                    return MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 35,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                          AddItemCartEvent(
                                            itemCart: ItemCart(
                                              id: offer.id,
                                              title: offer.title,
                                              titleEn: offer.titleEn,
                                              price: int.parse(offer.price),
                                              imageUrl: offer.imageUrl,
                                              account: 1,
                                              isProduct: false,
                                            ),
                                          ),
                                        );
                                      },
                                      color: AppColors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        side: BorderSide(
                                            width: 1, color: AppColors.gray),
                                      ),
                                      child: Text(
                                        AppTranslationKeys.addToCart.tr,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.gray),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
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
