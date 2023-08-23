import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPagesRoutes.offerDetailsScreen, arguments: offer);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.primary2,
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
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Get.locale!.languageCode == 'en'
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                          right: Get.locale!.languageCode == 'ar'
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                        ),
                        image: offer.imageUrl != null
                            ? DecorationImage(
                                image:
                                    CachedNetworkImageProvider(offer.imageUrl!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image:
                                    AssetImage(AppAssets.logo1),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 20,
                      color: AppColors.gray,
                    ),
                    SizedBox(
                      width: Get.width*0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            Get.locale!.languageCode == 'ar'
                                ? offer.title
                                : offer.titleEn,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 20,
                                    ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${offer.price} ${AppTranslationKeys.di.tr}",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            Get.locale!.languageCode == 'ar'
                                ? offer.description
                                : offer.descriptionEn,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocProvider(
                      create: (context) => di.sl<CartBloc>(),
                      child: BlocConsumer<CartBloc, CartState>(
                          listener: (context, state) {
                        if (state is FailureCartState ||
                            state is EmptyCacheFailureCartState) {
                          WidgetsUtils.showSnackBar(
                            title: AppTranslationKeys.failure.tr,
                            message: state.message,
                            snackBarType: SnackBarType.error,
                          );
                        } else if (state is SuccessAddItemCartState) {
                          WidgetsUtils.showSnackBar(
                            title: AppTranslationKeys.addItemSuccessfully.tr,
                            message: state.message.tr,
                            snackBarType: SnackBarType.info,
                          );
                          // Get.toNamed(AppPagesRoutes.mainScreen, arguments: 1);
                        }
                      }, builder: (context, state) {
                        return InkWell(
                          onTap: () {
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
                          child: const Icon(
                            Icons.add_shopping_cart_outlined,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
