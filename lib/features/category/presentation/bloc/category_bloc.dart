import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
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
      : super(const CategoryInitial(null, true, true, message: 'init state')) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreCategoriesEvent()); //TODO: تحتاج تعديل في كل الأماكن التي تحوي تحميل المزيد بحيث تكون بارامتر الفلترة يمكن الوصول له نها لكي لايختل الفلترة عند تحميل المزيد name
      }
    });
    on<ShowAllCategoriesEvent>((event, emit) async {
      emit(const LoadingCategoryState(null, true, true, message: "loading"));
      page = 1;
      final failureOrCategories =
          await showAllCategoryUsecase(page, name: event.name);
      failureOrCategories.fold((failure) {
        emit(switchFailure(failure));
      }, (categories) {
        emit(LoadedCategoriesState(categories, true, true,
            message: globalMessage!));
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
        final failureOrCategories =
            await showAllCategoryUsecase(page, name: event.name);
        failureOrCategories.fold((failure) {
          page--;
          emit(switchFailure(failure));
        }, (categories) {
          if (categories.isEmpty) {
            page--;
            emit(LoadedCategoriesState(state.categories!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedCategoriesState(
                [...state.categories!, ...categories], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}

CategoryState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureCategoryState(null, true, true);
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureCategoryState(null, true, true);
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureCategoryState(null, true, true);
  }
  return FailureCategoryState(null, true, true,
      message: globalMessage ?? "No any message");
}
