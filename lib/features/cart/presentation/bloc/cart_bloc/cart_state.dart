import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';

abstract class CartState extends Equatable {
  final int? index;
  final String message;
  Cart? cart;
  CartState({required this.index, required this.cart, required this.message});

  @override
  List<Object?> get props => [index, cart, message];
}

class CartInitial extends CartState {
  CartInitial(
      {required super.index, required super.cart, required super.message});
}

class LoadingCartState extends CartState {
  LoadingCartState(
      {required super.index, required super.cart, required super.message});
}

class FailureCartState extends CartState {
  FailureCartState(
      {required super.index, required super.cart, required super.message});
}

class EmptyCacheFailureCartState extends CartState {
  EmptyCacheFailureCartState(
      {required super.index,
      required super.cart,
      super.message = AppMessages.EmptyCache_MESSAGE});
}

class LoadedCartState extends CartState {
  LoadedCartState(
      {required super.index,
      required super.cart,
      super.message = AppMessages.LOADED_CART_MESSAGE});
}

class SuccessAddItemCartState extends CartState {
  SuccessAddItemCartState(
      {required super.index,
      required super.cart,
      super.message = AppMessages.ADD_ITEM_MESSAGE});
}
