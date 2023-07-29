import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/features/category/domain/usecases/showAllCategory_usecase.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_event.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_state.dart';
import 'package:nano_tech_cosmetic/main.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ShowAllCategoryUsecase showAllCategoryUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  CategoryBloc({required this.showAllCategoryUsecase})
      : super(const CategoryInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreCategoriesEvent());
    });
    on<ShowAllCategoriesEvent>((event, emit) async {
      emit(const LoadingCategoryState(null, true, true));
      final failureOrCategories = await showAllCategoryUsecase(page);
      failureOrCategories.fold((failure) {
        emit(FailureCategoryState(null, true, true, message: globalMessage!));
      }, (categories) {
        emit(LoadedCategoriesState(categories, true, true, message: globalMessage!));
      });
    });
    on<LoadMoreCategoriesEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedCategoriesState(state.categories, true, false,
            message: globalMessage!));
        page++;
        final failureOrCategories = await showAllCategoryUsecase(page);
        failureOrCategories.fold((failure) {
          page--;
          emit(FailureCategoryState(null, true, true, message: globalMessage!));
        }, (categories) {
          if (categories.isEmpty) {
            page--;
            emit(LoadedCategoriesState(state.categories!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedCategoriesState([...state.categories!, ...categories], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}
