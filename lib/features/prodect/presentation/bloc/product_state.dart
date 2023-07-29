import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  final List<Product>? products;
  final bool hasMore;
  final bool loaded;
  const ProductState(this.products, this.hasMore, this.loaded);

  @override
  List<Object> get props => [products!, hasMore, loaded];
}

class ProductInitial extends ProductState {
  const ProductInitial(super.products, super.hasMore, super.loaded);
}

class LoadingProductState extends ProductState {
  const LoadingProductState(super.products, super.hasMore, super.loaded);
}

class FailureProductState extends ProductState {
  final String message;

  const FailureProductState(super.products, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedProductsState extends ProductState {
  final String message;
  const LoadedProductsState(super.products, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [products!, hasMore, loaded, message];
}

class SuccessRatingState extends ProductState {
  final String message;
  const SuccessRatingState(super.products, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}
