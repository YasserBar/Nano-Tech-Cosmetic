import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_bloc.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_event.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_state.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SearchProductDelegate extends SearchDelegate {
  ProductBloc productBloc = di.sl<ProductBloc>();
  CategoryBloc categoryBloc = di.sl<CategoryBloc>();
  final FocusNode focusNode = FocusNode();
  String filterType = 'product';

  SearchProductDelegate()
      : super(searchFieldLabel: AppTranslationKeys.findProduct.tr);


  @override
  ThemeData appBarTheme(BuildContext context){
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: AppColors.gray),
        titleTextStyle: theme.textTheme.titleLarge,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (filterType == 'product')
        BlocProvider(
          create: (context) => productBloc,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<ProductBloc>(context).name = query;
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
                  BlocProvider.of<CategoryBloc>(context)
                      .add(ShowAllCategoriesEvent(name: query));
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
    return const SizedBox();
  }
}
