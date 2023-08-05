import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
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
      appBar: const SecondaryAppbar(title: "Electrical"),
      body: BlocProvider(
        create: (context) => di.sl<ProductBloc>()
          ..add(
            const ShowAllProductsEvent(),
          )
          ..categoryId = Get.arguments,
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
              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.appbarBodyPadding,
                    horizontal: AppDimensions.sidesBodyPadding,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.products!.length,
                  itemBuilder: (context, index) => ProductCard(
                    product: state.products![index],
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
