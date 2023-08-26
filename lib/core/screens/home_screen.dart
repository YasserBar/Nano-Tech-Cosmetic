import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_bloc.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_event.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_state.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/widgets/ad_card.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;
import 'package:nano_tech_cosmetic/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdBloc>(
            create: (context) => di.sl<AdBloc>()..add(const DisplayAdsEvent())),
        BlocProvider<ProductBloc>(
            create: (context) =>
                di.sl<ProductBloc>()..add(ShowAllProductsEvent())),
      ],
      child: BlocConsumer<AdBloc, AdState>(
        listener: (context, state) {
          if (state is FailureAdState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message.tr,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, adState) {
          if (adState is LoadedAdsState) {
            return BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is FailureProductState) {
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.failure.tr,
                    message: state.message.tr,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, productState) {
                if (productState is LoadedProductsState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<AdBloc>(context)
                          .add(const DisplayAdsEvent());
                      BlocProvider.of<ProductBloc>(context)
                          .add(ShowAllProductsEvent());
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.appbarBodyPadding,
                      ),
                      controller: context.read<ProductBloc>().scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.sidesBodyPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppTranslationKeys.welcome.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 35),
                              ),
                              SizedBox(height: globalUser == null ? 0 : 5),
                              if (globalUser == null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTranslationKeys.doYouHaveAnAccount.tr,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            AppPagesRoutes.signInScreen);
                                      },
                                      child: Text(
                                        AppTranslationKeys.singIn.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: AppColors.secondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.sidesBodyPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppTranslationKeys.ads.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 26),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.adsScreen);
                                },
                                child: Text(
                                  AppTranslationKeys.seeAll.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.35,
                          child: BlocConsumer<AdBloc, AdState>(
                            listener: (context, state) {
                              if (state is FailureAdState) {
                                WidgetsUtils.showSnackBar(
                                  title: AppTranslationKeys.failure.tr,
                                  message: state.message.tr,
                                  snackBarType: SnackBarType.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadedAdsState) {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  physics: const BouncingScrollPhysics(),
                                  controller:
                                      context.read<AdBloc>().scrollController,
                                  children: List.generate(state.ads!.length + 1,
                                      (index) {
                                    if (index < state.ads!.length) {
                                      return AdCard(
                                        ad: state.ads![index],
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
                                                        AppTranslationKeys
                                                            .noMoreAds.tr,
                                                      ),
                                                    ),
                                            );
                                    }
                                  }),
                                );
                              }
                              return const LoaderIndicator(
                                size: 50,
                                lineWidth: 4,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.sidesBodyPadding,
                              vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppTranslationKeys.products.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 26),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.categoriesScreen);
                                },
                                child: Text(
                                  AppTranslationKeys.categories.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocConsumer<ProductBloc, ProductState>(
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
                              return Column(
                                children: List.generate(
                                    state.products!.length + 1, (index) {
                                  if (index < state.products!.length) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimensions.sidesBodyPadding,
                                        ),
                                        child: ProductCard(
                                          product: state.products![index],
                                        ));
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
                                                      AppTranslationKeys
                                                          .noMoreProdects.tr,
                                                    ),
                                                  ),
                                          );
                                  }
                                }),
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: LoaderIndicator(size: 50, lineWidth: 4),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                if (productState is OfflineFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.offline,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(ShowAllProductsEvent());
                    },
                  );
                }
                if (productState is UnexpectedFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.unexpectedProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(ShowAllProductsEvent());
                    },
                  );
                }
                if (productState is InternalServerFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.internalServerProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(ShowAllProductsEvent());
                    },
                  );
                }
                return const LoaderIndicator();
              },
            );
          }
          if (adState is OfflineFailureAdState) {
            return HandleStatesWidget(
              stateType: StateType.offline,
              onPressedTryAgain: () {
                BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
                BlocProvider.of<ProductBloc>(context)
                    .add(ShowAllProductsEvent());
              },
            );
          }
          if (adState is UnexpectedFailureAdState) {
            return HandleStatesWidget(
              stateType: StateType.unexpectedProblem,
              onPressedTryAgain: () {
                BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
              },
            );
          }
          if (adState is InternalServerFailureAdState) {
            return HandleStatesWidget(
              stateType: StateType.internalServerProblem,
              onPressedTryAgain: () {
                BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
              },
            );
          }
          return const LoaderIndicator();
        },
      ),
    );
  }
}
