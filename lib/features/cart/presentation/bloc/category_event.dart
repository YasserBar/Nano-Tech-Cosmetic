import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ShowAllCategoriesEvent extends CategoryEvent {
  const ShowAllCategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreCategoriesEvent extends CategoryEvent {
  const LoadMoreCategoriesEvent();

  @override
  List<Object> get props => [];
}
