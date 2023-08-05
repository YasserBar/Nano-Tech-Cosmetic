import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/custom_rating_bar.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/rate_product_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/main.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isReadMoreMode = false, isEnd = false;
  Product product = Get.arguments;
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    // print(globalUser!.role);
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
                if (product.imageUrl == null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: Image.asset(
                      AppAssets.image1,
                      width: Get.width,
                      height: Get.height * 0.6,
                    ),
                  ),
                if (product.imageUrl != null)
                  Positioned(
                    top: -Get.statusBarHeight - 5,
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
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
                                  product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.white, fontSize: 36),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Electronic",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: 24),
                                  ),
                                  CustomRatingBar(
                                    rating:
                                        double.parse(product.rating.toString()),
                                    itemSize: 30,
                                    onTap: () {
                                      if (globalUser == null) {
                                        signInDialog(context, title: "Rating");
                                      } else {
                                        WidgetsUtils.showCustomDialog(
                                          context,
                                          title: "Rating Product",
                                          hasBtns: false,
                                          children: [
                                            BlocProvider(
                                              create: (context) =>
                                                  di.sl<ProductBloc>(),
                                              child: BlocConsumer<ProductBloc,
                                                  ProductState>(
                                                listener: (BuildContext context,
                                                    state) {
                                                  if (state is FailureProductState ||
                                                      state
                                                          is OfflineFailureProductState ||
                                                      state
                                                          is InternalServerFailureProductState ||
                                                      state
                                                          is UnexpectedFailureProductState) {
                                                    WidgetsUtils.showSnackBar(
                                                      title: "Failure",
                                                      message: state.message,
                                                      snackBarType:
                                                          SnackBarType.error,
                                                    );
                                                  } else if (state
                                                      is SuccessRatingState) {
                                                    Get.back();
                                                    WidgetsUtils.showSnackBar(
                                                      title: "Success ",
                                                      message: state.message,
                                                      snackBarType:
                                                          SnackBarType.info,
                                                    );
                                                  }
                                                },
                                                builder: (BuildContext context,
                                                    ProductState state) {
                                                  return Column(
                                                    children: [
                                                      Center(
                                                        child: CustomRatingBar(
                                                          rating: double.parse(
                                                            product.rating
                                                                .toString(),
                                                          ),
                                                          itemSize: 40,
                                                          ignoreGestures: false,
                                                          onRatingUpdate:
                                                              (double rating) {
                                                            this.rating =
                                                                rating.floor();
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(30)
                                                                .copyWith(
                                                                    bottom: 20),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  MaterialButton(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                onPressed: () {
                                                                  BlocProvider.of<
                                                                              ProductBloc>(
                                                                          context)
                                                                      .add(
                                                                    RateProductEvent(
                                                                      rateProduct:
                                                                          RateProduct(
                                                                        productId:
                                                                            product.id,
                                                                        rate:
                                                                            rating,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                color: AppColors
                                                                    .primary,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30)),
                                                                  side:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color:
                                                                        AppColors
                                                                            .gray,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Confirm",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  MaterialButton(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                color: AppColors
                                                                    .white,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30)),
                                                                  side: BorderSide(
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .gray),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: AppColors
                                                                          .gray),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                          btnOkOnPress: () {},
                                        );
                                      }
                                    },
                                    onRatingUpdate: (double rating) {},
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${product.price} D.I",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: 30,
                                            letterSpacing: 2),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                product.description,
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
                          if (globalUser == null ||
                              globalUser!.role == Role.customer)
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
                                          BlocProvider.of<CartBloc>(context)
                                              .add(
                                            AddItemCartEvent(
                                              itemCart: ItemCart(
                                                id: product.id,
                                                title: product.name,
                                                price: product.price,
                                                imageUrl: product.imageUrl,
                                                account: 1,
                                                isProduct: true,
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
                                        child: const Text(
                                          "add to cart",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.gray),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          if (globalUser != null &&
                              globalUser!.role != Role.customer)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    onPressed: () {},
                                    color: AppColors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      side: BorderSide(
                                          width: 1, color: AppColors.gray),
                                    ),
                                    child: const Text(
                                      "add to cart",
                                      style: TextStyle(
                                          fontSize: 20, color: AppColors.gray),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    onPressed: () {
                                      if (globalUser!.role == Role.company) {
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
                                                labelText: "Amount",
                                                inputType: TextInputType.number,
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              const CustomTextField(
                                                labelText: "Notes",
                                                isTextArea: true,
                                              ),
                                            ]);
                                      } else {
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
                                                labelText: "Amount",
                                                inputType: TextInputType.number,
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              const CustomTextField(
                                                labelText: "Notes",
                                                isTextArea: true,
                                              ),
                                            ]);
                                      }
                                    },
                                    color: AppColors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      side: BorderSide(
                                          width: 1, color: AppColors.gray),
                                    ),
                                    child: const Text(
                                      "Special order",
                                      style: TextStyle(
                                          fontSize: 20, color: AppColors.gray),
                                    ),
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
