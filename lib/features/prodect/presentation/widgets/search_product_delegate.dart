import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/product_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SearchProductDelegate extends SearchDelegate {
  ProductBloc bloc = di.sl<ProductBloc>();
  SearchProductDelegate() : super(searchFieldLabel: 'Find Product');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                print('object');
                BlocProvider.of<ProductBloc>(context).name = query;
                BlocProvider.of<ProductBloc>(context)
                    .add(const ShowAllProductsEvent());
              },
              icon: const Icon(Icons.search, size: 30),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query == '' ? Get.back() : query = '';
      },
      icon: Icon(
        query == '' ? Icons.arrow_back_ios : Icons.close,
        size: 30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
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
            return Container(
              color: AppColors.white,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.products != null ? state.products!.length : 0,
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
    );
  }
}
