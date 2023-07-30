import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class RateProductEvent extends ProductEvent {
  const RateProductEvent();

  @override
  List<Object> get props => [];
}

class ShowAllProductsEvent extends ProductEvent {
  const ShowAllProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreProductsEvent extends ProductEvent {
  const LoadMoreProductsEvent();

  @override
  List<Object> get props => [];
}
