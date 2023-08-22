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
  String? name;
  int? categoryId;
  ShowAllProductsEvent({this.name,this.categoryId});

  @override
  List<Object> get props => [];
}

class LoadMoreProductsEvent extends ProductEvent {
  String? name;
  int? categoryId;

  LoadMoreProductsEvent({this.name,this.categoryId});

  @override
  List<Object> get props => [];
}
