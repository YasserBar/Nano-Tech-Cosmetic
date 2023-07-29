import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/usecases/rate_product_usecase.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/usecases/show_all_product_usecase.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_event.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ShowAllProductUsecase showAllProductUsecase;
  final RateProductUsecase rateProductUsecase;

  int page = 1;
  int? categoryId;
  String? name;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  ProductBloc(
      {required this.showAllProductUsecase, required this.rateProductUsecase})
      : super(const ProductInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreProductsEvent());
    });
    on<ShowAllProductsEvent>((event, emit) async {
      emit(const LoadingProductState(null, true, true));
      final failureOrproducts =
          await showAllProductUsecase(page, categoryId: categoryId, name: name);
      failureOrproducts.fold((failure) {
        emit(FailureProductState(null, true, true, message: globalMessage!));
      }, (products) {
        emit(
            LoadedProductsState(products, true, true, message: globalMessage!));
      });
    });
    on<LoadMoreProductsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedProductsState(state.products, true, false,
            message: globalMessage!));
        page++;
        final failureOrproducts = await showAllProductUsecase(page,
            categoryId: categoryId, name: name);
        failureOrproducts.fold((failure) {
          page--;
          emit(FailureProductState(null, true, true, message: globalMessage!));
        }, (products) {
          if (products.isEmpty) {
            page--;
            emit(LoadedProductsState(state.products!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedProductsState(
                [...state.products!, ...products], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
    on<RateProductEvent>((event, emit) async {
      emit(const LoadingProductState(null, true, true));
      final failureOrproducts =
          await showAllProductUsecase(page, categoryId: categoryId, name: name);
      failureOrproducts.fold((failure) {
        emit(FailureProductState(null, true, true, message: globalMessage!));
      }, (products) {
        emit(SuccessRatingState(null, true, true, message: globalMessage!));
      });
    });
  }
}
