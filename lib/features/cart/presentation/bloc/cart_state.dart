import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';

abstract class CartState extends Equatable {
  final Cart? cart;
  final String message;
  const CartState(this.cart, {required this.message});

  @override
  List<Object> get props => [cart!, message];
}

class CartInitial extends CartState {
  const CartInitial(super.cart, {required super.message});
}

class LoadingCartState extends CartState {
  const LoadingCartState(super.cart, {required super.message});
}

class FailureCartState extends CartState {
  const FailureCartState(super.cart, {required super.message});
}

class EmptyCacheFailureCartState extends CartState {
  const EmptyCacheFailureCartState(super.cart,
      {super.message = AppMessages.EmptyCache_MESSAGE});
}

class LoadedCartState extends CartState {
  const LoadedCartState(super.cart, {required super.message});
}

class SuccessDeleteItemCartState extends CartState {
  const SuccessDeleteItemCartState(super.cart,
      {super.message = AppMessages.DELETE_ITEM_MESSAGE});
}

class SuccessAddItemCartState extends CartState {
  const SuccessAddItemCartState(super.cart,
      {super.message = AppMessages.ADD_ITEM_MESSAGE});
}
