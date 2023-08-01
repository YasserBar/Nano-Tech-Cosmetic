import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  final List<Product>? products;
  final bool hasMore;
  final bool loaded;
  final String message;

  const ProductState(this.products, this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props => [products??[], hasMore, loaded];
}

class ProductInitial extends ProductState {
  const ProductInitial(super.products, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingProductState extends ProductState {
  const LoadingProductState(super.products, super.hasMore, super.loaded,
      {required super.message});
}

class FailureProductState extends ProductState {
  const FailureProductState(super.products, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureProductState extends ProductState {
  const InternalServerFailureProductState(
      super.products, super.hasMore, super.loaded,
      {super.message = AppMessages.InternalServerError});
}

class UnexpectedFailureProductState extends ProductState {
  const UnexpectedFailureProductState(
      super.products, super.hasMore, super.loaded,
      {super.message = AppMessages.UnexpectedException});
}

class OfflineFailureProductState extends ProductState {
  const OfflineFailureProductState(super.products, super.hasMore, super.loaded,
      {super.message = AppMessages.Offline});
}

class LoadedProductsState extends ProductState {
  const LoadedProductsState(super.products, super.hasMore, super.loaded,
      {required super.message});
}

class SuccessRatingState extends ProductState {
  const SuccessRatingState(super.products, super.hasMore, super.loaded,
      {required super.message});
}
