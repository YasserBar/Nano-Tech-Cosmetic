import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/item_cart_bloc/item_cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/item_cart_bloc/item_cart_state.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/widgets/item_card.dart';
import 'package:nano_tech_cosmetic/main.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<CartBloc>()..add(const DisplayCartEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<ItemCartBloc>(),
        ),
      ],
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is FailureCartState ||
              state is EmptyCacheFailureCartState) {
            WidgetsUtils.showSnackBar(
              title: "Failure",
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadedCartState) {
            if (kDebugMode) {
              print(
                  "00000000000000000000000000${state.cart!.itemsCart.length}");
            }
            return Column(
              children: [
                SizedBox(
                  height: AppDimensions.bodyHeightWithNav * 0.75,
                  child: SlidableAutoCloseBehavior(
                    child: BlocBuilder<ItemCartBloc, ItemCartState>(
                        builder: (context, stateItem) {
                      if (stateItem is SuccessDeleteItemCartState) {
                        state.cart!.itemsCart.removeAt(stateItem.index!);
                        if (state.cart!.itemsCart.isEmpty) {
                          state.cart = null;
                          return SizedBox(
                            child: Center(
                                child: SvgPicture.asset(AppAssets.emptyCart)),
                          );
                        }
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.appbarBodyPadding,
                          horizontal: AppDimensions.sidesBodyPadding,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.cart!.itemsCart.length,
                        itemBuilder: (context, index) => ItemCard(
                          itemCart: state.cart!.itemsCart[index],
                          index: index,
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(
                    height: 0, thickness: 2, indent: 15, endIndent: 15),
                Container(
                  height: AppDimensions.bodyHeightWithNav * 0.25 - 55,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                  color: AppColors.gray, fontSize: 18),
                            ),
                            BlocBuilder<ItemCartBloc, ItemCartState>(
                                builder: (context, stateItem) {
                              if (stateItem is SuccessDecreaseItemCartState) {
                                if (stateItem.index != null) {
                                  state.cart!.totalPrice -= state
                                      .cart!.itemsCart[stateItem.index!].price;
                                }
                                return Text(
                                  "${state.cart!.totalPrice} ${AppTranslationKeys.di.tr}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 26,
                                        color: AppColors.primary,
                                      ),
                                );
                              }
                              if (stateItem is SuccessIncreaseItemCartState) {
                                if (stateItem.index != null) {
                                  state.cart!.totalPrice += state
                                      .cart!.itemsCart[stateItem.index!].price;
                                }
                                return Text(
                                  "${state.cart!.totalPrice} ${AppTranslationKeys.di.tr}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 26,
                                        color: AppColors.primary,
                                      ),
                                );
                              }
                              if (stateItem is SuccessDeleteItemCartState) {
                                if (stateItem.index != null) {
                                  state.cart!.totalPrice -= (state.cart!
                                          .itemsCart[stateItem.index!].price *
                                      state.cart!.itemsCart[stateItem.index!]
                                          .account);
                                }
                                return Text(
                                  "${state.cart!.totalPrice} ${AppTranslationKeys.di.tr}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 26,
                                        color: AppColors.primary,
                                      ),
                                );
                              }
                              return Text(
                                "${state.cart!.totalPrice} ${AppTranslationKeys.di.tr}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 26,
                                      color: AppColors.primary,
                                    ),
                              );
                            })
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              globalUser != null
                                  ? WidgetsUtils.showCustomDialog(context,
                                      title: "Total",
                                      children: [
                                          Center(
                                            child: Text(
                                              "${state.cart!.totalPrice} ${AppTranslationKeys.di.tr}",
                                              style: const TextStyle(
                                                  color: AppColors.secondary,
                                                  fontSize: 30),
                                            ),
                                          )
                                        ])
                                  : signInDialog(context,
                                      title: AppTranslationKeys.myOrders.tr);
                            },
                            color: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: AppColors.gray, width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: Text(
                                AppTranslationKeys.order.tr,
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (state is EmptyCacheFailureCartState) {
            return SizedBox(
              child: Center(child: SvgPicture.asset(AppAssets.emptyCart)),
            );
          } else if (state is FailureCartState) {
            return SizedBox(
              child: Center(child: SvgPicture.asset(AppAssets.caution)),
            );
          }
          return const LoaderIndicator();
        },
      ),
    );
  }
}
