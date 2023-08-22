import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  final List<Category>? categories;
  final bool hasMore;
  final bool loaded;
  final String message;

  const CategoryState(this.categories, this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props => [categories ?? [], hasMore, loaded, message];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial(super.categories, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingCategoryState extends CategoryState {
  const LoadingCategoryState(super.categories, super.hasMore, super.loaded,
      {required super.message});
}

class FailureCategoryState extends CategoryState {
  const FailureCategoryState(super.categories, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureCategoryState extends CategoryState {
  const InternalServerFailureCategoryState(
      super.categories, super.hasMore, super.loaded,
      {super.message = AppMessages.internalServerError});
}

class UnexpectedFailureCategoryState extends CategoryState {
  const UnexpectedFailureCategoryState(
      super.categories, super.hasMore, super.loaded,
      {super.message = AppMessages.unexpectedException});
}

class OfflineFailureCategoryState extends CategoryState {
  const OfflineFailureCategoryState(
      super.categories, super.hasMore, super.loaded,
      {super.message = AppMessages.offline});
}

class LoadedCategoriesState extends CategoryState {
  const LoadedCategoriesState(super.categories, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [categories!, hasMore, loaded, message];
}
