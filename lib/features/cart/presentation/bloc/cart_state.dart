import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';

abstract class CartState extends Equatable {
  final String message;
  const CartState({required this.message});

  @override
  List<Object> get props => [message];
}

class CartInitial extends CartState {
  const CartInitial({required super.message});
}

class LoadingCartState extends CartState {
  const LoadingCartState({required super.message});
}

class FailureCartState extends CartState {
  const FailureCartState({required super.message});
}

class EmptyCacheFailureCartState extends CartState {
  const EmptyCacheFailureCartState(
      {super.message = AppMessages.EmptyCache_MESSAGE});
}

abstract class LoadedDeleteCartState extends CartState {
  final Cart cart;
  const LoadedDeleteCartState(this.cart, {required super.message});

  @override
  List<Object> get props => [message, cart.totalPrice];
}

class LoadedCartState extends LoadedDeleteCartState {
  const LoadedCartState(super.cart,
      {super.message = AppMessages.LOADED_CART_MESSAGE});
}

class SuccessDeleteItemCartState extends LoadedDeleteCartState {
  const SuccessDeleteItemCartState(super.cart,
      {super.message = AppMessages.DELETE_ITEM_MESSAGE});
}

class SuccessAddItemCartState extends CartState {
  const SuccessAddItemCartState({super.message = AppMessages.ADD_ITEM_MESSAGE});
}
