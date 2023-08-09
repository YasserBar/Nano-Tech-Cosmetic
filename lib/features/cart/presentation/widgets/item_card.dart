import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ItemCard extends StatelessWidget {
  final ItemCart itemCart;
  final int index;

  const ItemCard({Key? key, required this.itemCart, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
          }
          if (state is SuccessDeleteItemCartState) {
            WidgetsUtils.showSnackBar(
              title: "Success Delete",
              message: state.message,
              snackBarType: SnackBarType.info,
            );
          }
        },
        builder: (context, state) {
          if (state is SuccessDeleteItemCartState) {
            return const SizedBox();
          }
          return Container(
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
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Slidable(
              startActionPane: ActionPane(
                extentRatio: 0.28,
                dragDismissible: true,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      BlocProvider.of<CartBloc>(context).add(
                          DeleteItemCartEvent(
                              index: index, price: itemCart.price));
                    },
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: AppColors.danger2,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    autoClose: true,
                    flex: 100,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: AppColors.primary2,
                    foregroundColor: Colors.white,
                    flex: 1,
                    label: '',
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
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 85,
                                width: 85,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        itemCart.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   bottom: -4,
                              //   right: -4,
                              //   child: Container(
                              //     height: 20,
                              //     width: 20,
                              //     decoration: const BoxDecoration(
                              //         color: AppColors.primary2,
                              //         shape: BoxShape.circle),
                              //   ),
                              // ),
                            ],
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
                                itemCart.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 20,
                                    ),
                              ),
                              Text(
                                "${itemCart.price} ${AppTranslationKeys.di.tr}",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.add_box,
                              color: AppColors.success1,
                            ),
                          ),
                          Text(
                            itemCart.account.toString(),
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.indeterminate_check_box_rounded,
                              color: AppColors.danger1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
