import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/display_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DisplayCartUsecase displayCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;
  final AddItemCartUsecase addItemCartUsecase;

  CartBloc({
    required this.addItemCartUsecase,
    required this.displayCartUsecase,
    required this.deleteCartUsecase,
  }) : super(CartInitial(index: null, cart: null, message: 'init state')) {
    on<DisplayCartEvent>((event, emit) async {
      emit(LoadingCartState(index: null, cart: null, message: "loading"));
      final failureOrCart = await displayCartUsecase();
      failureOrCart.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(LoadedCartState(index: null, cart: cart));
      });
    });

    on<AddItemCartEvent>((event, emit) async {
      emit(LoadingCartState(index: null, cart: null, message: "loading"));
      final failureOrCategories = await addItemCartUsecase(event.itemCart);
      failureOrCategories.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(SuccessAddItemCartState(index: null, cart: state.cart));
      });
    });

    on<DeleteCartEvent>((event, emit) async {
      emit(LoadingCartState(index: null, cart: null, message: "loading"));
      final failureOrDone = await deleteCartUsecase();
      failureOrDone.fold((failure) {
        emit(switchFailure(failure));
      }, (done) {
        emit(SuccessDeleteCartState(index: null, cart: null));
      });
    });
  }
}

CartState switchFailure(failure) {
  if (failure is EmptyCacheFailure) {
    return EmptyCacheFailureCartState(
      index: null,
      cart: null,
    );
  }
  return FailureCartState(
      index: null, cart: null, message: globalMessage ?? "No any message");
}
