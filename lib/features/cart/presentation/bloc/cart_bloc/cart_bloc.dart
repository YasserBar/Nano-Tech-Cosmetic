import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/display_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DisplayCartUsecase displayCartUsecase;
  final AddItemCartUsecase addItemCartUsecase;

  CartBloc({
    required this.addItemCartUsecase,
    required this.displayCartUsecase,
  }) : super(
            const CartInitial(index: null, cart: null, message: 'init state')) {
    on<DisplayCartEvent>((event, emit) async {
      emit(const LoadingCartState(index: null, cart: null, message: "loading"));
      final failureOrCart = await displayCartUsecase();
      failureOrCart.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(LoadedCartState(index: null, cart: cart));
      });
    });

    on<AddItemCartEvent>((event, emit) async {
      emit(const LoadingCartState(index: null, cart: null, message: "loading"));
      final failureOrCategories = await addItemCartUsecase(event.itemCart);
      failureOrCategories.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(SuccessAddItemCartState(index: null, cart: state.cart));
      });
    });
  }
}

CartState switchFailure(failure) {
  if (failure is EmptyCacheFailure) {
    return const EmptyCacheFailureCartState(
      index: null,
      cart: null,
    );
  }
  return FailureCartState(
      index: null, cart: null, message: globalMessage ?? "No any message");
}
