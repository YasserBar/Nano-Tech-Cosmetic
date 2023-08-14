import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_bloc.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_event.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_state.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/widgets/category_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(title: AppTranslationKeys.categories.tr),
      body: BlocProvider(
        create: (context) => di.sl<CategoryBloc>()
          ..add(
            ShowAllCategoriesEvent(),
          ),
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
            if (state is LoadedCategoriesState) {
              return RefreshIndicator(
                onRefresh: () async {},
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.appbarBodyPadding,
                    horizontal: AppDimensions.sidesBodyPadding,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .9,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categories!.length,
                  itemBuilder: (context, index) => CategoryCard(
                    category: state.categories![index],
                  ),
                ),
              );
            }
            return const LoaderIndicator();
          },
        ),
      ),
    );
  }
}
