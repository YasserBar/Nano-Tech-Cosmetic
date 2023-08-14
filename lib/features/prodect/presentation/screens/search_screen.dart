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
    return Scaffold(
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
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: AppTranslationKeys.findProduct.tr,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          if (filterType == 'product')
            BlocProvider(
              create: (context) => productBloc,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<ProductBloc>(context).name =
                          searchController.text;
                      BlocProvider.of<ProductBloc>(context)
                          .add(const ShowAllProductsEvent());
                    },
                    icon: const Icon(Icons.search, size: 30),
                  );
                },
              ),
            ),
          if (filterType == 'category')
            BlocProvider(
              create: (context) => productBloc,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<CategoryBloc>(context).add(
                          ShowAllCategoriesEvent(name: searchController.text));
                    },
                    icon: const Icon(Icons.search, size: 30),
                  );
                },
              ),
            ),
        ],
        bottom: TabBar(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.gray,
          dividerColor: AppColors.black,
          controller: tabController,
          onTap: (value) {
            // widget.changeFilter(value == 0 ? 'product' : 'category');
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
          BlocProvider(
            create: (context) => productBloc,
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is FailureProductState ||
                    state is OfflineFailureProductState ||
                    state is InternalServerFailureProductState ||
                    state is UnexpectedFailureProductState) {
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.failure.tr,
                    message: state.message,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedProductsState) {
                  if (state.products!.isEmpty) {
                    return Center(
                      child: SvgPicture.asset(AppAssets.nothingHere),
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
                return const SizedBox();
              },
            ),
          ),
          BlocProvider(
            create: (context) => categoryBloc,
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is FailureCategoryState ||
                    state is OfflineFailureCategoryState ||
                    state is InternalServerFailureCategoryState ||
                    state is UnexpectedFailureCategoryState) {
                  WidgetsUtils.showSnackBar(
                    title: AppTranslationKeys.failure.tr,
                    message: state.message,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedProductsState) {
                  if (state.categories!.isEmpty) {
                    return Center(
                      child: SvgPicture.asset(AppAssets.nothingHere),
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
                if (state is LoadingProductState) {
                  return const Center(
                    child: LoaderIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
