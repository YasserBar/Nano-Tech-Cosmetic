import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/rate_product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class RateProductEvent extends ProductEvent {
  final RateProduct rateProduct;
  const RateProductEvent({required this.rateProduct});

  @override
  List<Object> get props => [rateProduct];
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
