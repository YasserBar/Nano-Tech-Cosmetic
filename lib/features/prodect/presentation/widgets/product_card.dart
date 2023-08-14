import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/core/widgets/custom_rating_bar.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPagesRoutes.productDetailsScreen, arguments: product);
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
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Get.locale!.languageCode == 'en'
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                          right: Get.locale!.languageCode == 'ar'
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            product.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 20,
                      color: AppColors.gray,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          Get.locale!.languageCode == 'ar'
                              ? product.name
                              : product.nameEn,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20),
                        ),
                        Text(
                          "${product.price} ${AppTranslationKeys.di.tr}",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                          ),
                        ),
                        CustomRatingBar(
                          rating: double.parse(product.rating.toString()),
                          itemSize: 20,
                          onRatingUpdate: (double rating) {},
                        )
                      ],
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
                            title: "Failure",
                            message: state.message,
                            snackBarType: SnackBarType.error,
                          );
                        } else if (state is SuccessAddItemCartState) {
                          WidgetsUtils.showSnackBar(
                            title: "Success add item to cart",
                            message: state.message,
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
                                  id: product.id,
                                  title: product.name,
                                  titleEn: product.nameEn,
                                  price: product.price,
                                  imageUrl: product.imageUrl,
                                  account: 1,
                                  isProduct: true,
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
