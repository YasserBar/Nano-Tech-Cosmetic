import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  final List<Category>? categories;
  final bool hasMore;
  final bool loaded;
  const CategoryState(this.categories, this.hasMore, this.loaded);

  @override
  List<Object> get props => [categories!, hasMore, loaded];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial(super.categories, super.hasMore, super.loaded);
}

class LoadingCategoryState extends CategoryState {
  const LoadingCategoryState(super.categories, super.hasMore, super.loaded);
}

class FailureCategoryState extends CategoryState {
  final String message;

  const FailureCategoryState(super.categories, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedCategoriesState extends CategoryState {
  final String message;
  const LoadedCategoriesState(super.categories, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [categories!, hasMore, loaded, message];
}
