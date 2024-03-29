import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(
        title: Get.locale!.languageCode == 'ar'
            ? Get.arguments.name
            : Get.arguments.nameEn,
      ),
      body: BlocProvider(
        create: (context) => di.sl<ProductBloc>()
          ..add(ShowAllProductsEvent(categoryId: Get.arguments.id)),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is FailureProductState) {
              WidgetsUtils.showSnackBar(
                title: AppTranslationKeys.failure.tr,
                message: state.message.tr,
                snackBarType: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadedProductsState) {
              if (state.products!.isEmpty) {
                return const HandleStatesWidget(
                  stateType: StateType.noAnyProduct,
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ProductBloc>(context)
                      .add(ShowAllProductsEvent(categoryId: Get.arguments.id));
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.appbarBodyPadding,
                    horizontal: AppDimensions.sidesBodyPadding,
                  ),
                  controller: context.read<ProductBloc>().scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.products!.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.products!.length) {
                      return ProductCard(
                        product: state.products![index],
                      );
                    } else {
                      return state.loaded
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(10),
                              child: state.hasMore
                                  ? const LoaderIndicator(
                                      size: 30,
                                      lineWidth: 3,
                                    )
                                  : Center(
                                      child: Text(
                                        AppTranslationKeys.noMoreProdects.tr,
                                      ),
                                    ),
                            );
                    }
                  },
                ),
              );
            }
            if (state is OfflineFailureProductState) {
              return HandleStatesWidget(
                stateType: StateType.offline,
                onPressedTryAgain: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(ShowAllProductsEvent(categoryId: Get.arguments.id));
                },
              );
            }
            if (state is UnexpectedFailureProductState) {
              return HandleStatesWidget(
                stateType: StateType.unexpectedProblem,
                onPressedTryAgain: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(ShowAllProductsEvent(categoryId: Get.arguments.id));
                },
              );
            }
            if (state is InternalServerFailureProductState) {
              return HandleStatesWidget(
                stateType: StateType.internalServerProblem,
                onPressedTryAgain: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(ShowAllProductsEvent(categoryId: Get.arguments.id));
                },
              );
            }
            return const LoaderIndicator();
          },
        ),
      ),
    );
  }
}
