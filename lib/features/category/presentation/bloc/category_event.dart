import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ShowAllCategoriesEvent extends CategoryEvent {
  String? name;
  ShowAllCategoriesEvent({this.name});

  @override
  List<Object> get props => [];
}

class LoadMoreCategoriesEvent extends CategoryEvent {
  String? name;
  LoadMoreCategoriesEvent({this.name});

  @override
  List<Object> get props => [];
}
