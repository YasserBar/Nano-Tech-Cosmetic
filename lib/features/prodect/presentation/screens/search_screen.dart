import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_bloc.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_event.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_state.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/widgets/category_card.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  ProductBloc productBloc = di.sl<ProductBloc>();
  CategoryBloc categoryBloc = di.sl<CategoryBloc>();
  Key searchProductsKey=const Key('searchProductsKey');
  Key searchCategoriesKey=const Key('searchCategoriesKey');

  final FocusNode focusNode = FocusNode();
  String filterType = 'product';
  TextEditingController searchController = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) =>
              productBloc..add(ShowAllProductsEvent()),
        ),
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) =>
              categoryBloc..add(ShowAllCategoriesEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              searchController.text == ''
                  ? Get.back()
                  : searchController.text = '';
              setState(() {});
            },
            icon: Icon(
              searchController.text == '' ? Icons.arrow_back_ios : Icons.close,
              size: 30,
            ),
          ),
          title: TextFormField(
            controller: searchController,
            onChanged: (value) {
              if (searchController.text != '') {
                if (filterType == 'product') {
                  productBloc.add(
                    ShowAllProductsEvent(name: searchController.text),
                  );
                } else {
                  categoryBloc.add(
                    ShowAllCategoriesEvent(name: searchController.text),
                  );
                }
              }
              setState(() {});
            },
            onFieldSubmitted: (value) {
              if (searchController.text != '') {
                FocusScope.of(context).unfocus();
                if (filterType == 'product') {
                  productBloc.add(
                    ShowAllProductsEvent(name: searchController.text),
                  );
                } else {
                  categoryBloc.add(
                    ShowAllCategoriesEvent(name: searchController.text),
                  );
                }
              }
            },
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              hintText: filterType == 'product'
                  ? AppTranslationKeys.findProduct.tr
                  : AppTranslationKeys.findCategory.tr,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            if (filterType == 'product')
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return IconButton(
                    key: searchProductsKey,
                    onPressed: () {
                      if (searchController.text != '') {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<ProductBloc>(context).add(
                          ShowAllProductsEvent(name: searchController.text),
                        );
                      }
                    },
                    icon: const Icon(Icons.search, size: 30),
                  );
                },
              ),
            if (filterType == 'category')
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (searchController.text != '') {
                        BlocProvider.of<CategoryBloc>(context).add(
                            ShowAllCategoriesEvent(
                                name: searchController.text));
                      }
                    },
                    icon: const Icon(Icons.search, size: 30),
                  );
                },
              ),
          ],
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.gray,
            dividerColor: AppColors.black,
            controller: tabController,
            onTap: (value) {
              filterType = value == 0 ? 'product' : 'category';
              setState(() {});
            },
            isScrollable: false,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gray,
                    ),
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primary,
                ),
            tabs: [
              Tab(
                text: AppTranslationKeys.products.tr,
              ),
              Tab(
                text: AppTranslationKeys.categories.tr,
              ),
            ],
          ),
          elevation: 3,
        ),
        body: TabBarView(
          controller: tabController,
          children: [
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
                  if (state.products!.isEmpty) {
                    return const HandleStatesWidget(
                      stateType: StateType.noAnyProduct,
                    );
                  }
                  return Container(
                    color: AppColors.white,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.appbarBodyPadding,
                        horizontal: AppDimensions.sidesBodyPadding,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          state.products != null ? state.products!.length : 0,
                      itemBuilder: (context, index) => ProductCard(
                        product: state.products![index],
                      ),
                    ),
                  );
                }
                if (state is LoadingProductState) {
                  return const Center(
                    child: LoaderIndicator(),
                  );
                }
                if (state is OfflineFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.offline,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        ShowAllProductsEvent(name: searchController.text),
                      );
                    },
                  );
                }
                if (state is UnexpectedFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.unexpectedProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        ShowAllProductsEvent(name: searchController.text),
                      );
                    },
                  );
                }
                if (state is InternalServerFailureProductState) {
                  return HandleStatesWidget(
                    stateType: StateType.internalServerProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        ShowAllProductsEvent(name: searchController.text),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is FailureCategoryState) {
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.failure.tr,
                    message: state.message.tr,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedCategoriesState) {
                  if (state.categories!.isEmpty) {
                    return Center(
                      child: SvgPicture.asset(AppAssets.noAnyProduct),
                    );
                  }
                  return Container(
                    color: AppColors.white,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .9,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.appbarBodyPadding,
                        horizontal: AppDimensions.sidesBodyPadding,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.categories != null
                          ? state.categories!.length
                          : 0,
                      itemBuilder: (context, index) => CategoryCard(
                        category: state.categories![index],
                      ),
                    ),
                  );
                }
                if (state is LoadingCategoryState) {
                  return const Center(
                    child: LoaderIndicator(),
                  );
                }
                if (state is OfflineFailureCategoryState) {
                  return HandleStatesWidget(
                    stateType: StateType.offline,
                    onPressedTryAgain: () {
                      BlocProvider.of<CategoryBloc>(context).add(
                          ShowAllCategoriesEvent(
                              name: searchController.text));
                    },
                  );
                }
                if (state is InternalServerFailureCategoryState) {
                  return HandleStatesWidget(
                    stateType: StateType.unexpectedProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<CategoryBloc>(context).add(
                          ShowAllCategoriesEvent(
                              name: searchController.text));
                    },
                  );
                }
                if (state is UnexpectedFailureCategoryState) {
                  return HandleStatesWidget(
                    stateType: StateType.internalServerProblem,
                    onPressedTryAgain: () {
                      BlocProvider.of<CategoryBloc>(context).add(
                          ShowAllCategoriesEvent(
                              name: searchController.text));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
