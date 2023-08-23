import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/regex.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/custom_rating_bar.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_event.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_state.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_event.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_state.dart';
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
  GlobalKey<FormState> formKeyAddOrderNamed = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyAddOrderManufacturing = GlobalKey<FormState>();
  TextEditingController amountFieldController = TextEditingController();
  TextEditingController notesFieldController = TextEditingController();
  TextEditingController detailsFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();

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
                                      ? product.name
                                      : product.nameEn,
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
                                    "${AppTranslationKeys.category.tr}${product.categoryId}",
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
                                    onTap: onCustomRatingTap,
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
                                    "${product.price} ${AppTranslationKeys.di.tr}",
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
                                Get.locale!.languageCode == 'ar'
                                    ? product.description
                                    : product.descriptionEn,
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
                                          title: AppTranslationKeys.failure.tr,
                                          message: state.message.tr,
                                          snackBarType: SnackBarType.error,
                                        );
                                      } else if (state
                                          is SuccessAddItemCartState) {
                                        WidgetsUtils.showSnackBar(
                                          title: AppTranslationKeys.success.tr,
                                          message: state.message.tr,
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
                                                titleEn: product.nameEn,
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
                                        child: Text(
                                          AppTranslationKeys.addToCart.tr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
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
                                  child: BlocProvider(
                                    create: (context) => di.sl<CartBloc>(),
                                    child: BlocConsumer<CartBloc, CartState>(
                                      listener: (context, state) {
                                        if (state is FailureCartState ||
                                            state
                                                is EmptyCacheFailureCartState) {
                                          WidgetsUtils.showSnackBar(
                                            title:
                                                AppTranslationKeys.failure.tr,
                                            message: state.message.tr,
                                            snackBarType: SnackBarType.error,
                                          );
                                        } else if (state
                                            is SuccessAddItemCartState) {
                                          WidgetsUtils.showSnackBar(
                                            title: AppTranslationKeys.success.tr,
                                            message: state.message.tr,
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
                                                  titleEn: product.nameEn,
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
                                                width: 1,
                                                color: AppColors.gray),
                                          ),
                                          child: Text(
                                            AppTranslationKeys.addToCart.tr,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: AppColors.gray),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    onPressed: () {
                                      if (globalUser!.role == Role.company) {
                                        addOrderManufacturing();
                                      } else {
                                        addOrderNamed();
                                      }
                                    },
                                    color: AppColors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      side: BorderSide(
                                          width: 1, color: AppColors.gray),
                                    ),
                                    child: Text(
                                      AppTranslationKeys.specialOrder.tr,
                                      style: const TextStyle(
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

  onCustomRatingTap() {
    if (globalUser == null) {
      signInDialog(context, title: AppTranslationKeys.rating.tr);
    } else {
      WidgetsUtils.showCustomDialog(
        context,
        title: AppTranslationKeys.ratingProduct.tr,
        children: [
          BlocProvider(
            create: (context) => di.sl<ProductBloc>(),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (BuildContext context, state) {
                if (state is FailureProductState) {
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.failure.tr,
                    message: state.message.tr,
                    snackBarType: SnackBarType.error,
                  );
                } else if (state is SuccessRatingState) {
                  Get.back();
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.success.tr,
                    message: state.message.tr,
                    snackBarType: SnackBarType.info,
                  );
                }
              },
              builder: (BuildContext context, ProductState state) {
                if (state is OfflineFailureProductState) {
                  return HandleStatesWidget(
                    isDialog: true,
                    stateType: StateType.offline,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        RateProductEvent(
                          rateProduct: RateProduct(
                            productId: product.id,
                            rate: rating,
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is UnexpectedFailureProductState) {
                  return HandleStatesWidget(
                    isDialog: true,
                    stateType: StateType.unexpectedProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        RateProductEvent(
                          rateProduct: RateProduct(
                            productId: product.id,
                            rate: rating,
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is InternalServerFailureProductState) {
                  return HandleStatesWidget(
                    isDialog: true,
                    stateType: StateType.internalServerProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        RateProductEvent(
                          rateProduct: RateProduct(
                            productId: product.id,
                            rate: rating,
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is LoadingProductState) {
                  return const LoaderIndicator();
                }
                return Column(
                  children: [
                    Center(
                      child: CustomRatingBar(
                        rating: double.parse(
                          product.rating.toString(),
                        ),
                        itemSize: 40,
                        ignoreGestures: false,
                        onRatingUpdate: (double rating) {
                          this.rating = rating.floor();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30).copyWith(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              onPressed: () {
                                BlocProvider.of<ProductBloc>(context).add(
                                  RateProductEvent(
                                    rateProduct: RateProduct(
                                      productId: product.id,
                                      rate: rating,
                                    ),
                                  ),
                                );
                              },
                              color: AppColors.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side: BorderSide(
                                  width: 1,
                                  color: AppColors.gray,
                                ),
                              ),
                              child: Text(
                                AppTranslationKeys.confirm.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 3,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () {
                                Get.back();
                              },
                              color: AppColors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side:
                                    BorderSide(width: 1, color: AppColors.gray),
                              ),
                              child: Text(
                                AppTranslationKeys.cancel.tr.tr,
                                style: const TextStyle(
                                    fontSize: 20, color: AppColors.gray),
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
        hasBtns: false,
      );
    }
  }

  addOrderNamed() {
    WidgetsUtils.showCustomDialog(
      context,
      title: AppTranslationKeys.orderByName.tr,
      children: [
        BlocProvider(
          create: (context) => di.sl<OrderNameBloc>(),
          child: BlocConsumer<OrderNameBloc, OrderNameState>(
            listener: (context, state) {
              if (state is FailureOrderNameState) {
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.failure.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessAddOrderNameState) {
                Get.back();
                nameFieldController.clear();
                notesFieldController.clear();
                amountFieldController.clear();
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.success.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.info,
                );
                Get.toNamed(AppPagesRoutes.mainScreen, arguments: 2);
              }
            },
            builder: (context, state) {
              if (state is OfflineFailureOrderNameState) {
                return HandleStatesWidget(
                  stateType: StateType.offline,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderNameBloc>(context).add(
                      AddOrderNameEvent(
                        requestOrderName: RequestOrderName(
                          newName: nameFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is UnexpectedFailureOrderNameState) {
                return HandleStatesWidget(
                  stateType: StateType.unexpectedProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderNameBloc>(context).add(
                      AddOrderNameEvent(
                        requestOrderName: RequestOrderName(
                          newName: nameFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is InternalServerFailureOrderNameState) {
                return HandleStatesWidget(
                  stateType: StateType.internalServerProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderNameBloc>(context).add(
                      AddOrderNameEvent(
                        requestOrderName: RequestOrderName(
                          newName: nameFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is LoadingOrderNameState) {
                return const LoaderIndicator();
              }
              return Form(
                key: formKeyAddOrderNamed,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: AppTranslationKeys.newName.tr,
                      controller: nameFieldController,
                      validator: (val) => AppValidator.validateRequired(val),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: AppTranslationKeys.amount.tr,
                      inputType: TextInputType.number,
                      controller: amountFieldController,
                      validator: (val) => AppValidator.validateRequired(val),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: AppTranslationKeys.notes.tr,
                      isTextArea: true,
                      controller: notesFieldController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () {
                                if (formKeyAddOrderNamed.currentState!
                                    .validate()) {
                                  BlocProvider.of<OrderNameBloc>(context).add(
                                    AddOrderNameEvent(
                                      requestOrderName: RequestOrderName(
                                        newName: nameFieldController.text,
                                        amount: int.parse(
                                            amountFieldController.text),
                                        note: notesFieldController.text,
                                        productId: product.id,
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side:
                                    BorderSide(width: 1, color: AppColors.gray),
                              ),
                              child: Text(
                                AppTranslationKeys.order.tr,
                                style: const TextStyle(
                                    fontSize: 20, color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      okText: AppTranslationKeys.order.tr,
      hasBtns: false,
    );
  }

  addOrderManufacturing() {
    WidgetsUtils.showCustomDialog(
      context,
      title: AppTranslationKeys.orderManufacturing.tr,
      children: [
        BlocProvider(
          create: (context) => di.sl<OrderManufacturingBloc>(),
          child: BlocConsumer<OrderManufacturingBloc, OrderManufacturingState>(
            listener: (context, state) {
              if (state is FailureOrderManufacturingState) {
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.failure.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessAddOrderManufacturingState) {
                Get.back();
                detailsFieldController.clear();
                notesFieldController.clear();
                amountFieldController.clear();
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.success.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.info,
                );
                Get.toNamed(AppPagesRoutes.mainScreen, arguments: 2);
              }
            },
            builder: (context, state) {
              if (state is OfflineFailureOrderManufacturingState) {
                return HandleStatesWidget(
                  stateType: StateType.offline,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderManufacturingBloc>(context).add(
                      AddOrderManufacturingEvent(
                        requestOrderManufacturing: RequestOrderManufacturing(
                          details: detailsFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is UnexpectedFailureOrderManufacturingState) {
                return HandleStatesWidget(
                  stateType: StateType.unexpectedProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderManufacturingBloc>(context).add(
                      AddOrderManufacturingEvent(
                        requestOrderManufacturing: RequestOrderManufacturing(
                          details: detailsFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is InternalServerFailureOrderManufacturingState) {
                return HandleStatesWidget(
                  stateType: StateType.internalServerProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<OrderManufacturingBloc>(context).add(
                      AddOrderManufacturingEvent(
                        requestOrderManufacturing: RequestOrderManufacturing(
                          details: detailsFieldController.text,
                          amount: int.parse(amountFieldController.text),
                          note: notesFieldController.text,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is LoadingOrderManufacturingState) {
                return const LoaderIndicator();
              }
              return Form(
                key: formKeyAddOrderManufacturing,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: AppTranslationKeys.orderDetails.tr,
                      isTextArea: true,
                      controller: detailsFieldController,
                      validator: (val) => AppValidator.validateRequired(val),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: AppTranslationKeys.amount.tr,
                      inputType: TextInputType.number,
                      controller: amountFieldController,
                      validator: (val) => AppValidator.validateRequired(val),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: AppTranslationKeys.notes.tr,
                      isTextArea: true,
                      controller: notesFieldController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () {
                                if (formKeyAddOrderManufacturing.currentState!
                                    .validate()) {
                                  BlocProvider.of<OrderManufacturingBloc>(
                                          context)
                                      .add(
                                    AddOrderManufacturingEvent(
                                      requestOrderManufacturing:
                                          RequestOrderManufacturing(
                                        details: detailsFieldController.text,
                                        amount: int.parse(
                                            amountFieldController.text),
                                        note: notesFieldController.text,
                                        productId: product.id,
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side:
                                    BorderSide(width: 1, color: AppColors.gray),
                              ),
                              child: Text(
                                AppTranslationKeys.order.tr,
                                style: const TextStyle(
                                    fontSize: 20, color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      okText: AppTranslationKeys.order.tr,
      hasBtns: false,
    );
  }
}
