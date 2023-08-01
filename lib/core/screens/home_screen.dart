import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.appbarBodyPadding,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.sidesBodyPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 35),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Do you have an account? ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPagesRoutes.signInScreen);
                      },
                      child: Text(
                        "sign in",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  "Ads",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 26),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.adsScreen);
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
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
            child: BlocProvider(
              create: (context) =>
                  di.sl<AdBloc>()..add(const DisplayAdsEvent()),
              child: BlocConsumer<AdBloc, AdState>(
                listener: (context, state) {
                  if (state is FailureAdState ||
                      state is OfflineFailureAdState ||
                      state is InternalServerFailureAdState ||
                      state is UnexpectedFailureAdState) {
                    WidgetsUtils.showSnackBar(
                      title: "Failure",
                      message: state.message,
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
                      children: List.generate(
                        state.ads!.length,
                        (index) => AdCard(
                          ad: state.ads![index],
                        ),
                      ),
                    );
                  }
                  return const LoaderIndicator(size: 50,lineWidth: 4,);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.sidesBodyPadding, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product  ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 26),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.categoriesScreen);
                  },
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) =>
                di.sl<ProductBloc>()..add(const ShowAllProductsEvent()),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is FailureProductState ||
                    state is OfflineFailureProductState ||
                    state is InternalServerFailureProductState ||
                    state is UnexpectedFailureProductState) {
                  WidgetsUtils.showSnackBar(
                    title: "Failure",
                    message: state.message,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedProductsState) {
                  return Column(
                    children: List.generate(
                      state.loaded ? state.products!.length : 0,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.sidesBodyPadding,
                        ),
                        child: ProductCard(
                          product: state.products![index],
                        ),
                      ),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: LoaderIndicator(size: 50,lineWidth: 4),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
